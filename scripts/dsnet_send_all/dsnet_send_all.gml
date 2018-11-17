///@param dsnet_server_instance(optional)

var dsnet_instance = id;
if (argument_count >= 1) {
	dsnet_instance = argument[0];
}

if (__obj_dsnet_container.debug) {
	if (dsnet_instance.object_index != __obj_dsnet_server) {
		debug_log("DSNET: Cannot call dsnet_send_all() to " + string(object_get_name(dsnet_instance.object_index) + " - only on __obj_dsnet_server"));
		return 0;
	}
}

var arr = [];
var arsize = 0;

with (dsnet_instance) {
	if (ds_map_size(clients) == 0) {
		return 0;
	}
	
	var key = ds_map_find_first(clients);
	while (!is_undefined(key)) {
		var _tosend_c = clients[? key];
		
		if (_tosend_c.handshake) { // Only if its handshaken
			arr[arsize] = _tosend_c;
			arsize++;
		}

		//Find next connected client
		key = ds_map_find_next(clients, key);
	}	
}

__dsnet_send_array(dsnet_instance, arr);