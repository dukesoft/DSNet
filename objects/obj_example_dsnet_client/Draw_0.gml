if (!connected) {
	draw_text(room_width/2, room_height/2, "Trying to connect to " + server_ip + ":" + string(server_port) + string_repeat(".", get_timer()/200000 % 3));
} 