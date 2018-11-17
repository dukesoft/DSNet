debug_log("[EXAMPLE] [CLIENT] Connected!");

connected = true;

dsnet_create_packet(ds_client, ex_netmsg.c_info);
dsnet_write(ds_client, buffer_string, username);
dsnet_write(ds_client, buffer_u8, hue);
dsnet_send(ds_client);