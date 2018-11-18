///On clean we free memory we reserved
if (!is_undefined(socket)) {
	if (__obj_dsnet_container.is_html5) {
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