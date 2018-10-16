if (!is_undefined(socket)) {
	network_destroy(socket);
}
buffer_delete(send_buffer);
ds_map_destroy(clients);