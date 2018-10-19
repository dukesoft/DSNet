///@description Disconnect a client from the server instance
///@param connected_client_instance
///@param reason
var connected_client = argument0;
var reason = argument1;

if (!instance_exists(connected_client)) {
	if __obj_dsnet_container.debug debug_log("DSNET: dsnet_server_client_disconnect("+string(connected_client)+") failed, instance not found.");
	return false;
}

with (connected_client) {
	//Send one last packet - being that we will disconnect
	if (socket != undefined) {
		var b = __dsnet_create_packet(dsnet_msg.s_disconnect);
		buffer_write(b, buffer_string, reason);
		dsnet_send();
	
		network_destroy(socket);
		ds_map_delete(parent.clients, socket);
	}
	if __obj_dsnet_container.debug debug_log("DSNET: Disconnected socket and destroyed instance");
	instance_destroy(id, false);
}
return true;