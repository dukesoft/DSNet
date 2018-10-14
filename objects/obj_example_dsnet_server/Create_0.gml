server = dsnet_server_create(
	8000, 
	10, 
	10*1000, 
	__example_dsnet_server_onconnect, 
	__example_dsnet_server_ondisconnect, 
	__example_dsnet_server_ondata
);

if (server == noone) {
	show_debug_message("Server was not created.");
	instance_destroy();
}