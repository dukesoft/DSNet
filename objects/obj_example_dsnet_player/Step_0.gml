///Movement
x += (keyboard_check(vk_right) - keyboard_check(vk_left))*obj_example_dsnet_main.player_speed*__obj_dsnet_container.delta;
y += (keyboard_check(vk_down) - keyboard_check(vk_up))*obj_example_dsnet_main.player_speed*__obj_dsnet_container.delta;

//Clamp to room
x = clamp(x, 200, room_width-200);
y = clamp(y, 200, room_height-200);

// Send our new position to the server if it changed
// Please note that this is a bad example - there is no server-side validation or lag compensation.
// I'm still working on a tick-based system (like the Source engine uses (Left 4 Dead, Counter Strike etc.)), but thats far from done :)
if (x != xprevious || y != yprevious) {
	dsnet_create_packet(ds, ex_netmsg.c_position);
	dsnet_write(ds, buffer_u16, x);
	dsnet_write(ds, buffer_u16, y);
	dsnet_send(ds);
}