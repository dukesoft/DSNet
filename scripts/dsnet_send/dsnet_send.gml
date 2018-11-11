///@param packet
///@param to_dsnet_instance(optional)

var dsnet_instance = id;
if (argument_count >= 1) {
	dsnet_instance = argument[0];
}

if (__obj_dsnet_container.debug) {
	if (dsnet_instance.object_index != __obj_dsnet_connected_client && dsnet_instance.object_index != __obj_dsnet_client)	 {
		debug_log("DSNET: Cannot call dsnet_send() to " + string(object_get_name(dsnet_instance.object_index) + " - only on __obj_dsnet_connected_client or __obj_dsnet_client"));
		return 0;
	}
}
TODO -> Figure out what works best when writing packets and sending them. Remember dsnet_send() can be called multiple times, and you can send to 1 or more clients. Or just the server.

Kinda depends on where you create it from.


with (dsnet_instance) {
	if (__obj_dsnet_container.is_html5) {
		dsnet_js_send(socket, buffer_get_address(send_buffer), buffer_tell(send_buffer));
	} else {
		if (websocket) { //If the client is a websocket, we have to add a websocket header to the packet
			buffer_seek(ws_buffer, buffer_seek_start, 0);
		
			//Write the websocket header 
			buffer_write(ws_buffer, buffer_u8, 130) // 10000010
			//1 (fin)
			//0 (reserved 1)
			//0 (reserved 2)
			//0 (reserved 3)
			// 0010 (opcode, binary data)
		
			var bLength = buffer_tell(send_buffer);
			if (bLength < 126) {
				buffer_write(ws_buffer, buffer_u8, bLength); // The length
			} else if (bLength < 65536) {
				buffer_write(ws_buffer, buffer_u8, 126);
				buffer_write(ws_buffer, buffer_u16, bLength);
			} else {
				buffer_write(ws_buffer, buffer_u8, 127);
				buffer_write(ws_buffer, buffer_u64, bLength);
			}

			buffer_copy(send_buffer, 0, buffer_tell(send_buffer), ws_buffer, buffer_tell(ws_buffer));
			buffer_seek(ws_buffer, buffer_seek_relative, buffer_tell(send_buffer));
			network_send_raw(socket, ws_buffer, buffer_tell(ws_buffer));
		} else {
			network_send_raw(socket, send_buffer, buffer_tell(send_buffer));
		}
	}
}