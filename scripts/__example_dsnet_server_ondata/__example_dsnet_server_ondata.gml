///@param dsnet_connected_client
///@param buffer
///@param size

var dsnet_connected_client = argument0;
var buffer = argument1;
var size = argument2;

debug_log("[EXAMPLE] [SERVER] Client ("+string(dsnet_connected_client)+") received data: " + string(size) + " bytes (minus 3 internal from DSNet)");

//Read out the entire buffer and drop it here
while (buffer_tell(buffer) != size) {
    debug_log("                              "+string(buffer_read(buffer, buffer_u8)));
}