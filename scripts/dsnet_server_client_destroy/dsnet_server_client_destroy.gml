///@description Disconnect a client from the server instance
///@param connected_client_instance
///@param reason
var connected_client = argument0;
var reason = argument1;

if (!instance_exists(argument0) || argument0.object_index != __obj_dsnet_connected_client) {
	if (__obj_dsnet_container.debug) debug_log("DSNET: " + string(argument0) + " is not a valid connected client.");
	return false;
}

with (connected_client) {
	//Send one last packet - being that we will disconnect
	if (socket != undefined) {
		var b = __dsnet_create_packet(dsnet_msg.s_disconnect);
		buffer_write(b, buffer_string, reason);
		dsnet_send();
		
		if (instance_exists(parent)) { //Might be that the upper body has already left us in the void of cyberspace
		    ds_map_delete(parent.clients, socket);
		}
	}
	if __obj_dsnet_container.debug debug_log("DSNET: Disconnected socket and destroyed instance");
	
	//Trigger the disconnect event in our object (), so that we can handle the disconnect there (if anything needs to happen)
	with (subclient) { //The spawned [obj_example_dsnet_server_client] telling that he's leaving
		script_execute(other.parent.func_disconnect);
	}
	
	
	
	instance_destroy(id, false);
}
return true;