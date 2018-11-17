///@param buffer

// This is happening in obj_example_dsnet_server_client
var buffer = argument0;

username = buffer_read(buffer, buffer_string);
hue = buffer_read(buffer, buffer_u8);

// Send the ID of this player back
show_debug_message("WRITING ON " + string(object_get_name(dsnet_client.object_index)));
dsnet_create_packet(dsnet_client, ex_netmsg.s_info);
dsnet_write(dsnet_client, buffer_u8, dsnet_client.socket);
dsnet_send(dsnet_client);

// Tell other people this client has joined
show_debug_message("WRITING ON " + string(object_get_name(server.object_index)));
dsnet_create_packet(server, ex_netmsg.s_joined);
dsnet_write(server, buffer_u8, dsnet_client.socket);
dsnet_write(server, buffer_string, username);
dsnet_write(server, buffer_u8, hue);
show_debug_message("Going to send to all but" + string(dsnet_client) + " on " + string(server));
dsnet_send_all_but(dsnet_client, server);
show_debug_message("done but");

show_debug_message("Going to write to other clients");
// Send all current connected players to the person that joined
with (obj_example_dsnet_server_client) {
	show_debug_message("With obj_example_dsnet_server_client: " + object_get_name(other.object_index) + "["+string(other)+"] vs " + object_get_name(id.object_index) + "["+string(id)+"]");
	if (other == id) {
		continue; //Skip ourselves, we don't need to tell ourselves that we joined :)
	}
	show_debug_message("WRITING ON " + string(object_get_name(other.dsnet_client)));
	dsnet_create_packet(other.dsnet_client, ex_netmsg.s_joined);
	dsnet_write(other.dsnet_client, buffer_u8, dsnet_client.socket);
	dsnet_write(other.dsnet_client, buffer_string, username);
	dsnet_write(other.dsnet_client, buffer_u8, hue);
	dsnet_send(other.dsnet_client);
}