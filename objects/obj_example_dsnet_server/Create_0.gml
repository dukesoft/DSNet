server = dsnet_server_create(
	
	8000,  //Port
	10, //Max players
	
	//Handling functions
	__example_dsnet_server_onconnect, 
	__example_dsnet_server_ondisconnect,
	__example_dsnet_server_ondata,
	
	//The instance that will be spawned for a connected client
	obj_example_dsnet_server_client
);

if (server == noone) {
	debug_log("[EXAMPLE] [SERVER] Server could not be started!");
	instance_destroy();
}

debug_log("[EXAMPLE] [SERVER] Server started!");

//Hook up custom events to the clients
dsnet_msghandle(ex_netmsg.c_info, __example_sr_info);