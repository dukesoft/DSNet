///@param ip
///@param port

///@param function_onDisconnect
///@param function_onData


var instance = instance_create_depth(0, 0, 0, __obj_dsnet_client);

with (instance) {
	ip = argument0;
	port = argument1;
	
	parent = other.id;
	
	func_disconnect = argument2;
	func_data = argument3;
	
	connected = false;
	
	if (__obj_dsnet_container.is_html5) {
		if __obj_dsnet_container.debug debug_log("DSNET: Starting WS connection to " + string(ip) + ":" + string(port));
		socket = dsnet_js_connect(ip, port);
	} else {
		if __obj_dsnet_container.debug debug_log("DSNET: Starting TCP connection to " + string(ip) + ":" + string(port));
		socket = network_create_socket(network_socket_tcp);
		network_set_timeout(socket, __obj_dsnet_container.network_timeout, __obj_dsnet_container.network_timeout);
		var result = network_connect_raw(socket, ip, port);
	}
}

ds_map_add(__obj_dsnet_container.socketHandles, instance.socket, instance);
return instance;