///@param buffer

// This is happening in obj_example_dsnet_client
var buffer = argument0;

var pid = buffer_read(buffer, buffer_u8);
var pfound = clients[? pid];

if (!is_undefined(pfound)) {
	//Remove the obj_example_dsnet_other_player and remove the client from the list
	instance_destroy(pfound);
	ds_map_delete(clients, pid);
}