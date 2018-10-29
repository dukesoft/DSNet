instance_destroy(__obj_dsnet_server);
instance_destroy(__obj_dsnet_client);

if (__obj_dsnet_container.is_html5 && !cleanedUp) {
    cleanedUp = true;
	event_user(0);
}