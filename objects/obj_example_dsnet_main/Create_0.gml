//Setup DSNET
dsnet_init();
dsnet_draw_debug(true); // Draws information about connections
dsnet_debug(false); // Debug logs
dsnet_verbose(false); // Verbose debug logs

// Now we set up our custom messages. As this can differ per server / client, we hook them up in the actual server and client.
// But to keep things simple (1 single ENUM), we create that here :)

enum ex_netmsg {
	c_info, //Client sends info to server
	s_info, //Server sends info to client
	
	// Since DSNET is setup very abstract, (e.g. multi-level servers etc.) we setup clients joining and hosting on our own
	s_joined, // Server tells that someone joined
	s_left, // Server tells that someone left
	
	c_position, //Client sends its position
	s_position, //Server sends a positional update
}