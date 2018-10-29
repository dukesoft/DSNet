show_debug_message("D5");
if (!is_undefined(server_socket)) {
	show_debug_message("D5.1");
	network_destroy(server_socket);
}
show_debug_message("D6");
ds_map_destroy(clients);
show_debug_message("D7");
buffer_delete(send_buffer);
show_debug_message("D8");