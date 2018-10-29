///@param ds_server
if (!instance_exists(argument0) || argument0.object_index != __obj_dsnet_server) {
	if (__obj_dsnet_container.debug) debug_log("DSNET: " + string(argument0) + " is not a valid server.");
	return false;
}
with (argument0) {
	instance_destroy();
}
return true;