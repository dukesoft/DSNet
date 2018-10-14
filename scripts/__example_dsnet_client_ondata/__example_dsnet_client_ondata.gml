///@param buffer
///@param size

var buffer = argument0;
var size = argument1;

debug_log("DSNET: [CLIENT] Data received: " + string(size) + " bytes");

//Read out the entire buffer and drop it here
buffer_seek(buffer, buffer_seek_start, 0);
while (buffer_tell(buffer) != size) {
	debug_log("      "+string(buffer_read(buffer, buffer_u8)));
}

