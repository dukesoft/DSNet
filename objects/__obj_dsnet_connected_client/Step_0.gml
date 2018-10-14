if (is_real(handshake_timer) && !handshake) {
	handshake_timer -= __obj_dsnet_container.frame_time;
	if (handshake_timer < 0) {
		debug_log("DSNET: Handshake failed within "+string(__obj_dsnet_container.handshake_timeout)+" seconds - disconnecting");
		instance_destroy();
	}
}

messageTimeout += __obj_dsnet_container.frame_time;
if (messageTimeout*1000 > __obj_dsnet_container.network_timeout) {
	debug_log("DSNET: Connected client timeout after " + string(__obj_dsnet_container.network_timeout) + "ms - disconnecting");
	instance_destroy();
}