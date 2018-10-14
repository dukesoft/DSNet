///@param socket
///@param buffer
///@param size

var socket = argument0;
var buffer = argument1;
var size = argument2;

//Read out the entire buffer and drop it here
buffer_seek(buffer, buffer_seek_start, 0);

var out = dsnet_start

buffer_seek(send_buffer, buffer_seek_start, 0);
while (buffer_tell(buffer) != size) {
	var read = buffer_read(buffer, buffer_u8);
	debug_log("      "+string(read));
	//And send it back
	//buffer_write(dsnet_send_buffer, buffer_u8, read);
}

dsnet_send(socket);