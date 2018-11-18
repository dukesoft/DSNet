///@param buffer

// This is happening in obj_example_dsnet_server_client
var buffer = argument0;

username = buffer_read(buffer, buffer_string);
hue = buffer_read(buffer, buffer_u8);

// Send the ID of this player back
dsnet_create_packet(dsnet_client, ex_netmsg.s_info);
dsnet_write(dsnet_client, buffer_u8, dsnet_client.socket);
dsnet_send(dsnet_client);

// Tell other people this client has joined
dsnet_create_packet(server, ex_netmsg.s_joined);
dsnet_write(server, buffer_u8, dsnet_client.socket);
dsnet_write(server, buffer_string, username);
dsnet_write(server, buffer_u8, hue);
dsnet_send_all_but(dsnet_client, server);

// Send all current connected players to the person that joined
with (obj_example_dsnet_server_client) {
	if (other == id) {
		continue; //Skip ourselves, we don't need to tell ourselves that we joined :)
	}

	dsnet_create_packet(other.dsnet_client, ex_netmsg.s_joined);
	dsnet_write(other.dsnet_client, buffer_u8, dsnet_client.socket);
	dsnet_write(other.dsnet_client, buffer_string, username);
	dsnet_write(other.dsnet_client, buffer_u8, hue);
	dsnet_send(other.dsnet_client);
}