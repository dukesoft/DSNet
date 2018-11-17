if (!connected) {
	//This means the connection attempt failed
	show_message("Could not connect to server.");
} else {
	//This means we were connected, but now are not anymore
	debug_log("[EXAMPLE] [CLIENT] Disconnected!");
}
instance_destroy();