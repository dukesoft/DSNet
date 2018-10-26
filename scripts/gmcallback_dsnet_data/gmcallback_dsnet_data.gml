///@param inboundSocket
///@param socket
///@param buffer
show_debug_message("JS Callback buffer: " + string(argument2));

debug_log("[EXAMPLE GAME] [CLIENT] Data: " + string(buffer_get_size(argument2)) + " bytes (minus 3 internal from DSNet)");

buffer_seek(argument2, buffer_seek_start, 0);

//Read out the entire buffer and drop it here
while (buffer_tell(argument2) != buffer_get_size(argument2)) {
    debug_log("                              "+string(buffer_read(argument2, buffer_u8)));
}

with (__obj_dsnet_container) {
	__dsnet_network_async(argument0, network_type_data, argument1, undefined, argument2, buffer_get_size(argument2));
}