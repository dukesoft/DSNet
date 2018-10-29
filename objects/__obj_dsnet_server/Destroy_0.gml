///On destroy we clean up anything that links to us

// Clean up all clients and instances that are bound to this server
show_debug_message("D1");
var key = ds_map_find_first(clients);
while (!is_undefined(key)) {
	dsnet_server_client_destroy(clients[? key], "Server quit");
	key = ds_map_find_next(clients, key);
}
show_debug_message("D2");
// Remove our handling socket
if (!is_undefined(server_socket)) {
	show_debug_message("D2.1");
	ds_map_delete(__obj_dsnet_container.socketHandles, server_socket);
}
show_debug_message("D3");
if (__obj_dsnet_container.is_html5 && !cleanedUp) {
    cleanedUp = true;
	event_user(0);
}