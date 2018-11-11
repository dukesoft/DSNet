buffer_delete(send_buffer);
if (websocket) {
	buffer_delete(ws_buffer);
}
if (!is_undefined(socket)) {
	network_destroy(socket);
}
if (instance_exists(subclient)) {
	instance_destroy(subclient);
}