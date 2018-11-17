///@param buffer
var buffer = argument0;

var answer = buffer_read(buffer, buffer_string);

if (answer == script_execute(__obj_dsnet_container.handshake_validation_method, handshake_challenge)) {
	handshake = true;
	handshake_timer = undefined;
	
	//Send back a welcome message
	var packet = __dsnet_create_packet(dsnet_msg.s_welcome);
	dsnet_send();
	
	//Create a connected client for the server using DSNET
	subclient = instance_create_depth(0, 0, 0, parent.connected_client_object); //[obj_example_dsnet_server_client]
	subclient.server = parent;
	subclient.dsnet_client = id; //Link __obj_dsnet_connected_client to the users' one [obj_example_dsnet_server_client]
	
	//Trigger the connect event on the users' server, all is good now
	with (parent.parent) { //clients' parent (server)'s parent (user's server) [obj_example_dsnet_server]
		script_execute(other.parent.func_connect, other.subclient);
	}
	
	return;
}

if (__obj_dsnet_container.debug) debug_log("DSNET: Handshake failed - wrong answer (received "+string(answer)+", expected "+string(script_execute(__obj_dsnet_container.handshake_validation_method, handshake_challenge))+").");
instance_destroy(); //disconnect the client