///@param msgid
///@description write an internal DSNET message

var packet = buffer_create(__obj_dsnet_container.packetsize, buffer_fixed, 1);
buffer_write(packet, buffer_u8, 0); // To tell DSNET its an internal message
buffer_write(packet, __obj_dsnet_container.custom_id_buffer_type, real(argument0));

return packet;