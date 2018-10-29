///Remove ourselves from the server
//We give it a default reason - if you want to disconnect a connected client with a reason, use dsnet_server_client_disconnect, 
// as it will also destroy the instance.
dsnet_server_client_destroy(id, "Server disconnected you.");

if (__obj_dsnet_container.is_html5 && !cleanedUp) {
    cleanedUp = true;
	event_user(0);
}