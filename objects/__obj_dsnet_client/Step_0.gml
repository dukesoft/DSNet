messageTimeout += __obj_dsnet_container.frame_time;
if (messageTimeout*1000 > __obj_dsnet_container.network_timeout) {
	debug_log("DSNET: Client timeout after " + string(__obj_dsnet_container.network_timeout) + "ms - disconnecting");
	instance_destroy();
}