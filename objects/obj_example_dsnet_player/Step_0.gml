///Movement
x += (keyboard_check(vk_right) - keyboard_check(vk_left))*obj_example_dsnet_main.player_speed*__obj_dsnet_container.delta;
y += (keyboard_check(vk_down) - keyboard_check(vk_up))*obj_example_dsnet_main.player_speed*__obj_dsnet_container.delta;

//Clamp to room
x = clamp(x, 200, room_width-200);
y = clamp(y, 200, room_height-200);

//Send our new position to the server if it changed
if (x != xprevious || y != yprevious) {
	dsnet_create_packet(ds, ex_netmsg.c_position);
	dsnet_write(ds, buffer_u16, x);
	dsnet_write(ds, buffer_u16, y);
	dsnet_send(ds);
}