//if (live_call(argument0, argument1, argument2, argument3, argument4, argument5)) return live_result;
///@param inboundSocket
///@param type
///@param socket
///@param ip
///@param buffer
///@param size

///Handle all networking
// since the async event is triggered EVERYWHERE in EVERY object, this sends it to the proper ones
var inboundSocket = argument0;
var type = argument1;
var socket = argument2;
var ip = argument3;
var buffer = argument4;
var size = argument5;

var p = noone;

if (verbose) {
	debug_log("DSNET: Network event (" + netevent_to_string(type) + ") for socket " + string(inboundSocket));
}

var obj = __dsnet_get_handling_object_for_socket(inboundSocket);

if (obj == undefined) {
	if debug debug_log("DSNET: Socket handler for socket " + string(inboundSocket) + " not found!");
	return 0;
}

switch (type) {
    case network_type_connect:
	case network_type_non_blocking_connect:
		//Submit the event to the handling object
		with (obj) {
			if (server) {
				//A new connection to a server object - spawn the client
				network_set_timeout(socket, other.network_timeout, other.network_timeout);
				var connected_client = instance_create_depth(0, 0, 0, __obj_dsnet_connected_client);
				connected_client.ip = ip;
				connected_client.socket = socket;
				connected_client.parent = obj;
				connected_client.handshake_timer = other.handshake_timeout;
				ds_map_add(clients, socket, connected_client);
			} else {
				//Happening in a real client
				//We send the fact that we're ready for the handshake
				__dsnet_create_packet(dsnet_msg.c_ready_for_handshake);
				dsnet_send();
			}
		}
        break;
    case network_type_disconnect:

		with (obj) {
			if (server) {
				if (other.debug) debug_log("DSNET: Server received disconnect from client");
				return instance_destroy(clients[? socket]);
			} else {
				if (other.debug) debug_log("DSNET: Client received disconnect");
				return instance_destroy();
			}
		}
		
		/*
		with (obj.parent) {
			script_execute(obj.func_disconnect, socket);
		}
		*/
		//script_execute(dsnet_reference_disconnect, socket);
        break;
    case network_type_data:
		var minSize = 1 + buffer_datatype_size(custom_id_buffer_type); //1 byte for first id
		
		if (obj.websocket) {
			minSize += 2; //Need at least 2 header bytes for websocket
		}
		
		if (size < minSize) {
			//Discard! All packets should be bigger than 1 byte (internal identifier) + 2 bytes (custom identifier)
			return 0;
		}
		
		if (obj.websocket) {
		    //Read the websocket header
			var h1 = buffer_read(buffer, buffer_u8);

			var fin = (h1 & 0x80) != 0;
			//show_debug_message("FIN: " + string(fin));
			if (!fin) {
				if (verbose) debug_log("DSNET: Framed WS messages are currently not supported.");
				return instance_destroy(obj);
			}
			
			var opcode = h1 & 0x0F; //Lower 4 bits
			if (opcode == 0x08) { 
				//Connection termination
				if (verbose) debug_log("DSNET: Received disconnect opcode.");
				return instance_destroy(obj);
			}
			
			if (opcode != 0x02) { //Opcode 0x02 = Binary
				if (verbose) debug_log("DSNET: Only binary WS frames are supported.");
				return instance_destroy(obj);
			}
			
			var h2 = buffer_read(buffer, buffer_u8);
			
			var masked = (h1 & 0x80) != 0;
			if (!masked) {
				if (verbose) debug_log("DSNET: Non-masked messages are not supported.");
				return instance_destroy(obj);
			}
			
			var payload_len = h2 & 0x7F; //Lower 7 bits
			if (payload_len == 126) { //Payload length is 2 bytes
				payload_len = buffer_read(buffer, buffer_u16);
			} else if (payload_len == 127) { //Payload length is 8 bytes
				payload_len = buffer_read(buffer, buffer_u64);
			}
			show_debug_message("payload_len: " + string(payload_len));
			
			var mask;
			mask[0] = buffer_read(buffer, buffer_u8); //Mask is built up of a u32, 
			mask[1] = buffer_read(buffer, buffer_u8); // but we need to apply 
			mask[2] = buffer_read(buffer, buffer_u8); // bytes to bytes, so we'll store
			mask[3] = buffer_read(buffer, buffer_u8); // it in an array for easy access
			
			show_debug_message("mask: " + string(mask));
			var newBuffer = buffer_create(payload_len, buffer_fast, 1);
			for (var i = 0; i < payload_len; i++) {
				buffer_write(newBuffer, buffer_u8, buffer_read(buffer, buffer_u8) ^ mask[i%4]); //Unmask the payload into a new buffer, so we can read that as we like
			}
			buffer_seek(newBuffer, buffer_seek_start, 0);
			buffer = newBuffer;
		}
		
		var mtype = buffer_read(buffer, buffer_u8);
		var mid = buffer_read(buffer, custom_id_buffer_type);

		var executeOn = undefined;
		var handler = undefined;

		switch (mtype) {
			case 0: //internal
				handler = messageMap_internal[? mid];
				executeOn = obj;
				break;
			case 1: //custom
				handler = messageMap[? mid];
				executeOn = obj.parent;
				break;
		}
		
		if (obj.object_index == __obj_dsnet_connected_client && obj.handshake == false && obj.websocket == false && executeOn == undefined && handler == undefined) {
			buffer_seek(buffer, buffer_seek_start, 0);
			var headerString = "";
			while (buffer_tell(buffer) != size) {
				headerString += chr(buffer_read(buffer, buffer_u8));
			}
			var websocketHandshake = __dsnet_websocket_handshake(headerString);
			if (websocketHandshake == false) {
				if (debug) debug_log("DSNET: Unexpected handshake - closing connection");
				if (verbose) debug_log("DSNET: Tried to decode data as a websocket response because there's no handshake - but its not a valid websocket request either.");
				return instance_destroy(obj);
			}

			if (debug) debug_log("DSNET: [" + object_get_name(obj.object_index) + "] Received a valid Websocket connection!");
			with (obj) {
				handshake_timer += 1; //5 extra second time
				websocket = true;
				var hsLength = string_length(websocketHandshake);
				var tempBuffer = buffer_create(hsLength+1, buffer_fixed, 1);
				buffer_write(tempBuffer, buffer_string, websocketHandshake); //GM appends a 0 byte at the end here
				buffer_seek(tempBuffer, buffer_seek_relative, -1); //So we move the pointer back 1 byte
				network_send_raw(obj.socket, tempBuffer, buffer_tell(tempBuffer));
				buffer_delete(tempBuffer); //Remove it, we don't need it anymore
			}
			return 0;
		}

		/*if (obj.websocket) { //DEBUG
			buffer_seek(buffer, buffer_seek_start, 0);

			//Read out the entire buffer and drop it here
			while (buffer_tell(buffer) != buffer_get_size(buffer)) {
			    debug_log("                              "+string(buffer_read(buffer, buffer_u8)));
			}
		}*/

		if (verbose) debug_log("DSNET: [" + object_get_name(executeOn.object_index) + "] Received message: " + string(mtype) + " - " + string(mid));

		if (is_undefined(handler)) {
			if (debug) debug_log("DSNET: [" + object_get_name(executeOn.object_index) + "] Received message that could not be handled: " + string(mtype) + " - " + string(mid));
			return;
		}

		if (obj.object_index == __obj_dsnet_connected_client) {
			if (obj.handshake == false) { //Manual override for handshake!
				//No handshake happened yet, we expect the first few bytes to be an internal handshake request
				if (mtype != 0 || (mid != dsnet_msg.c_ready_for_handshake && mid != dsnet_msg.c_handshake_answer)) {
					if (debug) debug_log("DSNET: Unexpected handshake - closing connection");
					return instance_destroy(obj);
				}
			}
			
			//Now we have validated the request - only a handshake request if there is no handshake yet, or just regular messages
			obj.messageTimeout = 0; //Reset timeout counter to 0
			with (executeOn) {
				script_execute(handler, buffer);
			}
			return 0; //Early return
		}
		
		if (obj.object_index == __obj_dsnet_client) {
			with (executeOn) {
				script_execute(handler, buffer);
			}
			return 0; //Early return
		}
		/*
		var msgtype = buffer_read(buffer, buffer_u8);
		var msgid = buffer_read(buffer, buffer_u16);
		if (msgtype == 0) {
			//Internal
			
		} else {
			//Custom
			
		}
		*/
		/*
		with (obj.parent) {
			script_execute(obj.func_data, socket, buffer, size);
		}
		*/
		//script_execute(dsnet_reference_data, socket, buffer, size);
        break;
}
