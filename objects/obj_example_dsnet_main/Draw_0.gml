draw_set_color(c_white);
draw_set_font(fnt_dsnet_debug);
draw_text(20, 20, "Press Q to create server on port 8000\nPress W to join server on 127.0.0.1:8000\nE to destroy all\nR to destroy all clients");

if (keyboard_check_pressed(ord("Q"))) {
	if (!instance_exists(obj_example_dsnet_server)) {
		instance_create_depth(0, 0, 0, obj_example_dsnet_server);
	}
}

if (!instance_exists(obj_example_dsnet_client) && keyboard_check_pressed(ord("W"))) {
	instance_create_depth(0, 0, 0, obj_example_dsnet_client);
}

if (keyboard_check_pressed(ord("E"))) {
	instance_destroy(obj_example_dsnet_server);
	instance_destroy(obj_example_dsnet_client);
}

if (keyboard_check_pressed(ord("R"))) {
	instance_destroy(obj_example_dsnet_client);
}