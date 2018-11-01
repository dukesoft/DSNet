///On destroy we clean up anything that links to us


// Clean up all clients and instances that are bound to this server
var connectedList = [];
var key = ds_map_find_first(clients);
var i = 0;
while (!is_undefined(key)) {
	connectedList[i] = clients[? key];
	i++;
	key = ds_map_find_next(clients, key);
}

// Stored in an array because the dsnet_server_client_destroy removes itself from the list
for (var i = 0; i < array_length_1d(connectedList); i++) {
	dsnet_server_client_destroy(connectedList[i], "Server quit");
}

// Remove our handling socket
if (!is_undefined(server_socket)) {
	ds_map_delete(__obj_dsnet_container.socketHandles, server_socket);
}
