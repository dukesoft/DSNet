///@param buffer
///@param size

show_error("This should not happen!", true);

var buffer = argument0;
var size = argument1;

debug_log("[EXAMPLE] [CLIENT] Data: " + string(size) + " bytes (minus 3 internal from DSNet)");

//Read out the entire buffer and drop it here
while (buffer_tell(buffer) != size) {
    debug_log("                              "+string(buffer_read(buffer, buffer_u8)));
}