///@param port
///@param maxplayers

///@param function_onConnect
///@param function_onDisconnect
///@param function_onData

if (__obj_dsnet_container.is_html5) {
	if __obj_dsnet_container.debug debug_log("DSNET: Server cannot be started from HTML5 mode!");
	return noone;
}
show_debug_message("1");
var instance = instance_create_depth(0, 0, 0, __obj_dsnet_server);
show_debug_message("2");
with (instance) {
	//A buffer for broadcasting messages to all clients
	parent = other.id;
	port = argument0;
	maxplayers = argument1;

	func_connect = argument2;
	func_disconnect = argument3;
	func_data = argument4;
show_debug_message("3");
	server_socket = network_create_server_raw(network_socket_tcp, port, maxplayers+1);
show_debug_message("4");
	if (server < 0) {
		if __obj_dsnet_container.debug debug_log("DSNET: Server could not be started on port " + string(port));
	} else {
		if __obj_dsnet_container.debug debug_log("DSNET: Server started on port " + string(port));
		ds_map_add(__obj_dsnet_container.socketHandles, server_socket, instance);
		connected = true;
	}

}

if (instance.server < 0) {
	instance_destroy(instance);
	return noone;
}
return instance;