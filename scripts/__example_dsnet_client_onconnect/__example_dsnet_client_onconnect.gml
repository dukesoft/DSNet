debug_log("[EXAMPLE] [CLIENT] Connected!");

dsnet_create_packet(ds_client, ex_netmsg.c_info);
dsnet_write(ds_client, buffer_string, username);
dsnet_send(ds_client);