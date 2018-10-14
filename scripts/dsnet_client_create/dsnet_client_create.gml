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
	
	if (__obj_dsnet_container.is_html5) {
		socket = dsnet_js_connect(ip, port);
		if __obj_dsnet_container.debug debug_log("DSNET: Starting WS connection to " + string(ip) + ":" + string(port));
		connected = false;
	} else {
		socket = network_create_socket(network_socket_tcp);
		if (network_connect_raw(socket, ip, port) < 0) {
			if __obj_dsnet_container.debug debug_log("DSNET: Client could not connect to " + string(ip) + ":" + string(port));
			socket = undefined;
		} else {
			if __obj_dsnet_container.debug debug_log("DSNET: Client connected to " + string(ip) + ":" + string(port));
			connected = true;
			ds_map_add(__obj_dsnet_container.socketHandles, socket, instance);
		}
	}
}

if (instance.socket == undefined) {
	instance_destroy(instance);
	return noone;
}
return instance;