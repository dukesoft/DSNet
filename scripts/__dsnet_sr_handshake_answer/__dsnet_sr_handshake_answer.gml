///@param buffer
var buffer = argument0;

var answer = buffer_read(buffer, buffer_string);

if (answer == script_execute(__obj_dsnet_container.handshake_validation_method, handshake_challenge)) {
	handshake = true;
	handshake_timer = undefined;
	
	//Send back a welcome message
	__dsnet_create_packet(dsnet_msg.s_welcome);
	dsnet_send();
	
	//Trigger the connect event, all is good now
	with (parent.parent) { //clients' parent (server)'s parent (user's server)
		script_execute(other.parent.func_connect, other.id);
	}
	
	return;
}

if (__obj_dsnet_container.debug) debug_log("DSNET: Handshake failed - wrong answer (received "+string(answer)+", expected "+string(script_execute(__obj_dsnet_container.handshake_validation_method, handshake_challenge))+").");
instance_destroy(); //disconnect the client