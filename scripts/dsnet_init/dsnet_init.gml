///initialize
enum dsnet_msg {
	s_ping,
	c_ping,
	s_handshake_challenge,
	c_handshake_answer,
	c_ready_for_handshake,
	s_disconnect,
	s_welcome,
}

instance_create_depth(0, 0, 0, __obj_dsnet_container);

network_set_config(network_config_connect_timeout, __obj_dsnet_container.network_timeout);
network_set_config(network_config_use_non_blocking_socket, true);

__dsnet_msghandle(dsnet_msg.s_disconnect, __dsnet_cr_disconnect);
__dsnet_msghandle(dsnet_msg.s_ping, __dsnet_cr_ping);
__dsnet_msghandle(dsnet_msg.c_ping, __dsnet_sr_ping);
__dsnet_msghandle(dsnet_msg.c_ready_for_handshake, __dsnet_sr_handshake_ready);
__dsnet_msghandle(dsnet_msg.s_handshake_challenge, __dsnet_cr_handshake_challenge);
__dsnet_msghandle(dsnet_msg.c_handshake_answer, __dsnet_sr_handshake_answer);
__dsnet_msghandle(dsnet_msg.s_welcome, __dsnet_cr_welcome);