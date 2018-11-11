///@param dsnet_instance
///@param msgid
///@description write a DSNET internal message
buffer_seek(argument0.send_buffer, buffer_seek_start, 0);
buffer_write(argument0.send_buffer, buffer_u8, 1); // To tell DSNET its a custom message
buffer_write(argument0.send_buffer, __obj_dsnet_container.custom_id_buffer_type, real(argument1));

return argument0.send_buffer;