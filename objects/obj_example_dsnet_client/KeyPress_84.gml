//Read out the entire buffer and drop it here
buffer_seek(dsnet_send_buffer, buffer_seek_start, 0);
buffer_write(dsnet_send_buffer, buffer_u8, get_integer("Byte to send: ", 20));
dsnet_send(dsnet_socket);