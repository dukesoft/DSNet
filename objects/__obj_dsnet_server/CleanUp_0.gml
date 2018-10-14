ds_map_delete(__obj_dsnet_container.socketHandles, server_socket);
network_destroy(server_socket);
ds_map_destroy(clients);