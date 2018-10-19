///Handle all networking
// since the async event is triggered EVERYWHERE in EVERY object, this sends it to the proper ones
var inboundSocket = async_load[? "id"];
var type = async_load[? "type"];
var p = noone;

if (verbose) {
	debug_log("DSNET: Network event (" + netevent_to_string(type) + ") for socket " + string(inboundSocket));
}

var is_connected_client = false;

var obj = socketHandles[? inboundSocket];

if (obj == undefined) {
	//Its not a server / direct client - it might now be a connected client sending data. Search through our servers
	var skey = ds_map_find_first(socketHandles);
	while (!is_undefined(skey)) {
		var sobj = socketHandles[? skey];
		if (sobj.server) {
			if (sobj.clients[? inboundSocket] != undefined) {
				obj = sobj.clients[? inboundSocket];
				is_connected_client = true;
				break;
			}
		}
		skey = ds_map_find_next(socketHandles, skey);
	}
}

if (obj == undefined) {
	if debug debug_log("DSNET: Socket handler for socket " + string(inboundSocket) + " not found!");
	return 0;
}

switch (type) {
    case network_type_connect:
	case network_type_non_blocking_connect:
		var socket = async_load[? "socket"];
		var ip = async_load[? "ip"];
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
		var socket = async_load[? "socket"];
		
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
		var socket = async_load[? "id"];
		var buffer = async_load[? "buffer"];
		var size = async_load[? "size"];
		
		var minSize = 1 + buffer_datatype_size(custom_id_buffer_type); //1 byte for first id
		
		if (size < minSize) {
			//Discard! All packets should be bigger than 1 byte (internal identifier) + 2 bytes (custom identifier)
			return 0;
		}

		var mtype = buffer_read(buffer, buffer_u8);
		var mid = buffer_read(buffer, custom_id_buffer_type);
		
		var executeOn;
		var handler;
		
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

		if (verbose) debug_log("DSNET: [" + object_get_name(executeOn.object_index) + "] Received message: " + string(mtype) + " - " + string(mid));

		if (is_undefined(handler)) {
			if (debug) debug_log("DSNET: [" + object_get_name(executeOn.object_index) + "] Received message that could not be handled: " + string(mtype) + " - " + string(mid));
			return;
		}
		
		obj.messageTimeout = 0; //Reset timeout counter to 0

		if (obj.object_index == __obj_dsnet_connected_client) {
			if (obj.handshake == false) { //Manual override for handshake!
				//No handshake happened yet, we expect the first few bytes to be an internal handshake request
				if (mtype != 0 || (mid != dsnet_msg.c_ready_for_handshake && mid != dsnet_msg.c_handshake_answer)) {
					if (debug) debug_log("DSNET: Unexpected handshake - closing connection");
					return instance_destroy(obj);
				}
			}
			
			//Now we have validated the request - only a handshake request if there is no handshake yet, or just regular messages
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
