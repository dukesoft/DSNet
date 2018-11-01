///On destroy we clean up anything that links to us

// Clean up all clients and instances that are bound to this server
var key = ds_map_find_first(clients);
while (!is_undefined(key)) {
	dsnet_server_client_destroy(clients[? key], "Server quit");
	key = ds_map_find_next(clients, key);
}

// Remove our handling socket
if (!is_undefined(server_socket)) {
	ds_map_delete(__obj_dsnet_container.socketHandles, server_socket);
}
