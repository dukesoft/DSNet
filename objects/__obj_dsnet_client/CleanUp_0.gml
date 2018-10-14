if (!is_undefined(socket)) {
	network_destroy(socket);
	ds_map_delete(__obj_dsnet_container.socketHandles, socket);	
}
buffer_delete(send_buffer);
ds_map_destroy(clients);