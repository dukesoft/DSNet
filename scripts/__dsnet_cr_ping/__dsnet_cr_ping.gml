///@param buffer
var buffer = argument0;

ping = buffer_read(buffer, buffer_u16);

//Send back our answer
var packet = __dsnet_create_packet(dsnet_msg.c_ping);
dsnet_send();