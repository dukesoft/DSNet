if (is_real(handshake_timer) && !handshake) {
	handshake_timer -= __obj_dsnet_container.frame_time;
	if (handshake_timer < 0) {
		debug_log("DSNET: Handshake failed within "+string(__obj_dsnet_container.handshake_timeout)+" seconds - disconnecting");
		instance_destroy();
		return 0;
	}
}

messageTimeout += __obj_dsnet_container.frame_time;
if (messageTimeout*1000 > __obj_dsnet_container.network_timeout) {
	debug_log("DSNET: Connected client timeout after " + string(__obj_dsnet_container.network_timeout) + "ms - disconnecting");
	dsnet_server_client_destroy(id, "Connection timeout to server");
	return 0;
}

pingTimer += __obj_dsnet_container.frame_time;
if (pingTimer > __obj_dsnet_container.ping_time) {
	//Send a ping request
	lastPingRequest = get_timer();
	var b = __dsnet_create_packet(dsnet_msg.s_ping);
	buffer_write(b, buffer_u16, round(clamp(ping, 0, 65535))); //Write the current ping. Clamp to u16 limit, just in case.
	dsnet_send();
	pingTimer = 0;
}