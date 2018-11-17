///@param buffer

// This is happening in obj_example_dsnet_client
var buffer = argument0;

var pid = buffer_read(buffer, buffer_u8);
show_debug_message("CR JOIN PID " + string(pid));
player = instance_create_depth(x, y, 0, obj_example_dsnet_other_player);
with (player) {
	mp_id = pid;
	username = buffer_read(buffer, buffer_string);
	hue = buffer_read(buffer, buffer_u8);
}

// And store it in our map so we always have a reference to this player
ds_map_add(clients, pid, player);