buffer = buffer_create(4096, buffer_fixed, 1);

for (var i = 0; i < 16; i++) {
	buffer_write(buffer, buffer_u8, i);
}

buffer_write(buffer, buffer_u16, 1337);
buffer_write(buffer, buffer_u32, 13371337);
buffer_write(buffer, buffer_string, "and A string!");

dsnet_test_buffer(buffer);
dsnet_test_buffer(buffer_get_address(buffer));