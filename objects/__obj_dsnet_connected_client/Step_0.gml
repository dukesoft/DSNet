if (is_real(handshake_timer) && !handshake) {
	handshake_timer -= __obj_dsnet_container.frame_time;
	if (handshake_timer < 0) {
		debug_log("DSNET: Handshake failed within "+string(__obj_dsnet_container.handshake_timeout)+"ms - disconnecting");
		instance_destroy();
	}
}