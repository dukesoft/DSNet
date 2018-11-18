///@param ds_client
if (!instance_exists(argument0) || argument0.object_index != __obj_dsnet_client) {
	if (__obj_dsnet_container.debug) debug_log("DSNET: " + string(argument0) + " is not a valid client.");
	return false;
}
with (argument0) {
	if (!destroying) { //This is just to prevent loops
		destroying = true;
		instance_destroy();
	}
}
return true;