///On clean we free memory we reserved
if (!is_undefined(server_socket)) {
	network_destroy(server_socket);
}
ds_map_destroy(clients);
buffer_delete(send_buffer);
buffer_delete(ws_buffer);