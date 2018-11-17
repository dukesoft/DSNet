debug_log("[EXAMPLE] [SERVER] Server started!");

server = dsnet_server_create(
	8000,  //Port
	10, //Max connections
	
	//Handling functions
	example_server_onconnect, 
	example_server_ondisconnect,
	
	//The instance that will be spawned for a connected client
	obj_example_dsnet_server_client
);

if (server == noone) {
	debug_log("[EXAMPLE] [SERVER] Server could not be started!");
	instance_destroy();
}

//Hook up custom events to the clients
dsnet_msghandle(ex_netmsg.c_info, example_sr_info);
dsnet_msghandle(ex_netmsg.c_position, example_sr_position);