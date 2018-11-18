///@param buffer

// This is happening in obj_example_dsnet_client
var buffer = argument0;

var pid = buffer_read(buffer, buffer_u8);

if (clients[? pid] == undefined) {
	return 0;
}

clients[? pid].x = buffer_read(buffer, buffer_u16);
clients[? pid].y = buffer_read(buffer, buffer_u16);