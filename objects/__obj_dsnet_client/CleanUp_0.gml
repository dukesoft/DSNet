///On clean we free memory we reserved
if (!is_undefined(socket)) {
	network_destroy(socket);
}
buffer_delete(send_buffer);
buffer_delete(receive_buffer);
ds_map_destroy(clients);