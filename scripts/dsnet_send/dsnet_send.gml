if (__obj_dsnet_container.debug) {
	if (object_index != __obj_dsnet_connected_client && object_index != __obj_dsnet_client)	 {
		debug_log("DSNET: Cannot call dsnet_send() on " + string(object_get_name(object_index) + " - only on __obj_dsnet_connected_client or __obj_dsnet_client"));
		return 0;
	}
}

if (__obj_dsnet_container.is_html5) {
	dsnet_js_send(socket, buffer_get_address(send_buffer), buffer_tell(send_buffer));
} else {
	if (websocket) { //If the client is a websocket, we have to wrap the buffer in 0x00 ... 0xFF
		buffer_seek(ws_buffer, buffer_seek_start, 0);
		buffer_write(ws_buffer, buffer_u8, 0); //0x00
		buffer_copy(send_buffer, 0, buffer_tell(send_buffer), ws_buffer, 1);
		buffer_seek(ws_buffer, buffer_seek_relative, buffer_tell(send_buffer));
		buffer_write(ws_buffer, buffer_u8, 255); //0xFF
		network_send_raw(socket, send_buffer, buffer_tell(send_buffer));
	} else {
		network_send_raw(socket, send_buffer, buffer_tell(send_buffer));
	}
}

//if (object_index

/*
if (object_index == __obj_dsnet_connected_client) {
	network_send_raw(socket, dsnet_send_buffer, buffer_tell(dsnet_send_buffer));
}

if (object_index == __obj_dsnet_client) {
	network_send_raw(socket, dsnet_send_buffer, buffer_tell(dsnet_send_buffer));
}
*/

//if (os_browser == browser_not_a_browser) {
	
//} else {
//	dsnet_js_send_buffer(socket, buffer_get_address(dsnet_send_buffer));
//}