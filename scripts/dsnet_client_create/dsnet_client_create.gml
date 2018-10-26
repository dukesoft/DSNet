///@param ip
///@param port

///@param function_onConnect
///@param function_onDisconnect
///@param function_onData


var instance = instance_create_depth(0, 0, 0, __obj_dsnet_client);

with (instance) {
	ip = argument0;
	port = argument1;
	
	parent = other.id;
	
	func_connect = argument2;
	func_disconnect = argument3;
	func_data = argument4;
	
	connected = false;
	
	if (__obj_dsnet_container.is_html5) {
		receive_buffer = buffer_create(1500, buffer_fast, 1);
		socket = dsnet_js_connect(ip, port, buffer_get_address(receive_buffer));
		if __obj_dsnet_container.debug debug_log("DSNET: Starting WS connection to " + string(ip) + ":" + string(port) + " Socket: " + string(socket));
	} else {
		socket = network_create_socket(network_socket_tcp);
		if __obj_dsnet_container.debug debug_log("DSNET: Starting TCP connection to " + string(ip) + ":" + string(port) + " Socket: " + string(socket));
		network_set_timeout(socket, __obj_dsnet_container.network_timeout, __obj_dsnet_container.network_timeout);
		var result = network_connect_raw(socket, ip, port);
	}
}

ds_map_add(__obj_dsnet_container.socketHandles, instance.socket, instance);
return instance;