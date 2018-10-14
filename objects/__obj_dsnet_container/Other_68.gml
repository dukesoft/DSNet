///Handle all networking
// since the async event is triggered EVERYWHERE in EVERY object, this sends it to the proper ones
var inboundSocket = async_load[? "id"];
var type = async_load[? "type"];

if (verbose) {
	debug_log("DSNET: Network event (" + dsnet_netevent_to_string(type) + ") for socket " + string(inboundSocket));
}

var obj = socketHandles[? inboundSocket];

if (obj == undefined) {
	if debug debug_log("DSNET: Socket handler for socket " + inboundSocket + " not found!");
}

switch (type) {
    case network_type_connect:
	case network_type_non_blocking_connect: 
		// These only happen on servers
		var socket = async_load[? "socket"];
		var ip = async_load[? "ip"];
		//Submit the event to the handling object
		with (obj) {
			network_set_timeout(socket, network_timeout, network_timeout);
			
			//Todo: Manually store the client in the list here
			var connected_client = instance_create_depth(0, 0, 0, __obj_dsnet_connected_client);
			connected_client.ip = ip;
			connected_client.socket = socket;
			connected_client.server_object = obj;
			
			//with (parent) {
				//script_execute(other.func_connect, socket, ip);
			//}
		}
		//script_execute(dsnet_reference_connect, socket, ip);
        break;
    case network_type_disconnect:
		var socket = async_load[? "socket"];
		with (obj) {
			with (parent) {
				script_execute(func_disconnect, socket);
			}
		}
		//script_execute(dsnet_reference_disconnect, socket);
        break;
    case network_type_data:
		var socket = async_load[? "id"];
		var buffer = async_load[? "buffer"];
		var size = async_load[? "size"];

		with (obj) {
			with (parent) {
				script_execute(func_data, socket, buffer, size);
			}
		}
		//script_execute(dsnet_reference_data, socket, buffer, size);
        break;
}
