///@param buffer

// This is happening in obj_example_dsnet_server_client
var buffer = argument0;

x = buffer_read(buffer, buffer_u16);
y = buffer_read(buffer, buffer_u16);

// Forward the received position to everyone else
dsnet_create_packet(server, ex_netmsg.s_position);
dsnet_write(server, buffer_u8, dsnet_client.socket); //This is an identifier, so all receiving clients know which one to update
dsnet_write(server, buffer_u16, x);
dsnet_write(server, buffer_u16, y);
dsnet_send_all_but(dsnet_client, server);
