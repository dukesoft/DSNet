///On destroy we clean up anything that links to us
if (!is_undefined(server_socket)) {
	ds_map_delete(__obj_dsnet_container.socketHandles, server_socket);
}