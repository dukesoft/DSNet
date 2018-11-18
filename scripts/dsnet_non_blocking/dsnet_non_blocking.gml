///@param non_blocking_sockets_enabled
if (!instance_exists(__obj_dsnet_container)) {
	debug_log("DSNet not initialized!");
	return false;
}

__obj_dsnet_container.nonblocking = !!argument0;

network_set_config(network_config_use_non_blocking_socket, !!argument0);