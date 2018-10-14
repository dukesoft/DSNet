///@param port
///@param maxplayers
///@param networktimeout (in ms)

///@param function_onConnect
///@param function_onDisconnect
///@param function_onData

if (__obj_dsnet_container.is_html5) {
	if __obj_dsnet_container.debug debug_log("DSNET: Server cannot be started from HTML5 mode!");
	return noone;
}

var instance = instance_create_depth(0, 0, 0, __obj_dsnet_server);

with (instance) {
	send_buffer = buffer_create(1500, buffer_fixed, 1);
	clients = ds_map_create();
	parent = other.id;
	port = argument0;
	maxplayers = argument1;
	network_timeout = argument2;

	func_connect = argument3;
	func_disconnect = argument4;
	func_data = argument5;

	server_socket = network_create_server_raw(network_socket_tcp, port, maxplayers+1);

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