///@param message_logging_enabled
if (!instance_exists(__obj_dsnet_container)) {
	debug_log("DSNet not initialized!");
	return false;
}

__obj_dsnet_container.msglog = !!argument0;