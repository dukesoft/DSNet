if (__obj_dsnet_container.debug) {
	if (object_index != __obj_dsnet_connected_client && object_index != __obj_dsnet_client)	 {
		debug_log("DSNET: Cannot call dsnet_send() on " + string(object_get_name(object_index) + " - only on __obj_dsnet_connected_client or __obj_dsnet_client"));
		return 0;
	}
}

network_send_raw(socket, send_buffer, buffer_tell(send_buffer));

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