///@param msgid
///@param dsnet_instance[optional]
///@param internal[optional]
///@return buffer
///@description write a DSNET message

if (argument_count == 0) {
	show_error("DSNET: Missing required parameter for __dsnet_create_packet", true);
	return false;
}

var msgid = real(argument[0]);
var dsnet_instance = id;

if (argument_count >= 2) {
	dsnet_instance = argument[1];
}

var internal = true;
if (argument_count >= 3) {
	internal = argument[2];
}

if (__obj_dsnet_container.verbose) debug_log("DSNET: CREATE " + string((internal) ? "INTERNAL" : "EXTERNAL") + " PACKET ["+string(msgid)+"] ON " + object_get_name(dsnet_instance.object_index));

var packet = dsnet_instance.send_buffer;

buffer_seek(packet, buffer_seek_start, 0);
buffer_write(packet, buffer_u8, !internal); // 0 = internal, 1 = external (weird meaning there but ok)
buffer_write(packet, __obj_dsnet_container.custom_id_buffer_type, msgid);

return packet;