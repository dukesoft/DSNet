buffer_seek(ws_buffer, buffer_seek_start, 0);

//Write the websocket header 
buffer_write(ws_buffer, buffer_u8, 130) // 10000010
//1 (fin)
//0 (reserved 1)
//0 (reserved 2)
//0 (reserved 3)
// 0010 (opcode, binary data)
		
var bLength = buffer_tell(send_buffer);
if (bLength < 126) {
	buffer_write(ws_buffer, buffer_u8, bLength); // The length
} else if (bLength < 65536) {
	buffer_write(ws_buffer, buffer_u8, 126);
	buffer_write(ws_buffer, buffer_u16, bLength);
} else {
	buffer_write(ws_buffer, buffer_u8, 127);
	buffer_write(ws_buffer, buffer_u64, bLength);
}

buffer_copy(send_buffer, 0, buffer_tell(send_buffer), ws_buffer, buffer_tell(ws_buffer));
buffer_seek(ws_buffer, buffer_seek_relative, buffer_tell(send_buffer));