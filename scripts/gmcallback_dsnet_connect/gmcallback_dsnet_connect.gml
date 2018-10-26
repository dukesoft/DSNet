///@param socket
///@param ip
show_debug_message("CALLBACK CONNECT CALLED: " + string(argument0) + "&"+string(argument1));
with (__obj_dsnet_container) {
	show_debug_message("INSIDE WITH");
	return __dsnet_network_async(argument0, network_type_non_blocking_connect, argument0, argument1, undefined, undefined);
	//@todo SUBMIT BUG, NO RETURN AND IT EXECUTES THE WITH LOOP TWICE!
}