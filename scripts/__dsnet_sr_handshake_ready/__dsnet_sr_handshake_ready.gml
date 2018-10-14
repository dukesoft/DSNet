///@param buffer
var buffer = argument0;

//Generate a challenge
handshake_challenge = string(random_range(100000000, 999999999)) + string(get_timer());
					
//And send it back to the client
var b = __dsnet_create_packet(dsnet_msg.s_handshake_challenge);
buffer_write(b, buffer_string, handshake_challenge);
dsnet_send();