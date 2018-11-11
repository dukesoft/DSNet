///@param buffer
var buffer = argument0;

username = buffer_read(buffer, buffer_string);
hue = buffer_read(buffer, buffer_u8);

// Tell other people we've joined
dsnet_create_packet(server, ex_netmsg.s_joined);
dsnet_write(server, buffer_string, username);
dsnet_write(server, buffer_u8, hue);
dsnet_send(server);

// Send all current connected players to the person that joined
with () {
	
}
dsnet_create_packet(server, ex_netmsg.s_joined);
dsnet_write(server, buffer_string, username);
dsnet_write(server, buffer_u8, hue);
dsnet_send(server);