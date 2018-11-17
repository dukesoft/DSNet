///@param buffer

// This is happening in obj_example_dsnet_client
var buffer = argument0;

var pid = buffer_read(buffer, buffer_u8);
show_debug_message("CR POS PID " + string(pid));

if (clients[? pid] == undefined) {
	show_debug_message("PID " + string(pid) + " is not known..");
	return 0;
}

clients[? pid].x = buffer_read(buffer, buffer_u16);
clients[? pid].y = buffer_read(buffer, buffer_u16);