if (!is_undefined(server_socket)) {
	network_destroy(server_socket);
}
ds_map_destroy(clients);