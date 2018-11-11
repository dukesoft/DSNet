///Movement
x += (keyboard_check(vk_right) - keyboard_check(vk_left))*player_speed*__obj_dsnet_container.delta;
y += (keyboard_check(vk_down) - keyboard_check(vk_up))*player_speed*__obj_dsnet_container.delta;

//Clamp to room
x = clamp(x, 200, room_width-200);
y = clamp(y, 200, room_height-200);