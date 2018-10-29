///On clean we free memory we reserved
show_debug_message("Cleanup event on client");
if (!is_undefined(socket)) {
	show_debug_message("socket is defined");
	if (__obj_dsnet_container.is_html5) {
		show_debug_message("calling disconnect");
		dsnet_js_disconnect(socket);
	} else {
		network_destroy(socket);
	}
}
buffer_delete(send_buffer);
if (websocket) {
	buffer_delete(receive_buffer);
}
ds_map_destroy(clients);
show_debug_message("Cleanup event done");