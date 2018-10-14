///@description Disconnect a client from the server instance
///@param connected_client_instance
var connected_client = argument0;

if (!instance_exists(connected_client)) {
	if __obj_dsnet_container.debug debug_log("DSNET: dsnet_server_client_disconnect("+string(connected_client)+") failed, instance not found.");
	return false;
}

with (connected_client) {
	network_destroy(socket);
	ds_map_delete(parent.clients, socket);
	if __obj_dsnet_container.debug debug_log("DSNET: Disconnected socket and destroyed instance");
	instance_destroy(id, false);
}
return true;