///@param buffer
var buffer = argument0;

var answer = buffer_read(buffer, buffer_string);

if (answer == script_execute(__obj_dsnet_container.handshake_validation_method, handshake_challenge)) {
	handshake = true;
	handshake_timer = undefined;
	
	//Send back a welcome message
	__dsnet_create_packet(dsnet_msg.s_welcome);
	dsnet_send();
	
	return;
}

if (__obj_dsnet_container.debug) debug_log("DSNET: Handshake failed - wrong answer.");
instance_destroy(); //disconnect the client