///@param dsnet_server_instance
///@param client_array
///@description This function DOES NOT CHECK CONNECTION STATUS. This is an internal function.

var dsnet_instance = argument0;
var arr = argument1;

var arrl = array_length_1d(arr);

if (arrl == 0) {
	return 0;
}

with (dsnet_instance) {
	var __dsnet_ws_made = false; //Keep track if we ever make a WS version of the packet
	
	for (var i = 0; i < arrl; i++) {
		var _tosend_c = arr[i];
		
		//Note: This code also resides in dsnet_send
	
		if (_tosend_c.websocket) { //If the client is a websocket, we have to pack the packet as a websocket one
			if (!__dsnet_ws_made) {
				__dsnet_send_buffer_to_ws_buffer();
				__dsnet_ws_made = true;
			}
			network_send_raw(_tosend_c.socket, ws_buffer, buffer_tell(ws_buffer));
		} else {
			network_send_packet(_tosend_c.socket, send_buffer, buffer_tell(send_buffer));
		}
	}
}