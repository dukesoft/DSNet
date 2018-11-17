// This is happening in a connected client [obj_example_dsnet_server_client]
debug_log("[EXAMPLE] [SERVER] Client "+string(id)+" disconnected");

// Tell other people this client has left the building
dsnet_create_packet(server, ex_netmsg.s_left);
dsnet_write(server, buffer_u8, dsnet_client.socket);
dsnet_send_all(server);