///@param dsnet_instance
///@param msgid
///@return buffer
///@description write a DSNET message

dsnet_instance = argument0;
var msgid = real(argument1);

return __dsnet_create_packet(msgid, dsnet_instance, false);