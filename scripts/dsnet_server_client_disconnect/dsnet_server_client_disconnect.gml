///@description Disconnect a client from the server instance
///@param connected_client_instance
var connected_client = argument0;

if (!instance_exists(connected_client)) {
	if (__obj_dsnet_container.debug) {
		debug_log("DSNET: dsnet_server_client_disconnect("+string(connected_client)+") failed, instance not found.");
	}
	return false;
}