///On destroy we clean up anything that links to us
if (!is_undefined(server_socket)) {
	ds_map_delete(__obj_dsnet_container.socketHandles, server_socket);
}

if (__obj_dsnet_container.is_html5 && !cleanedUp) {
    cleanedUp = true;
	event_user(0);
}