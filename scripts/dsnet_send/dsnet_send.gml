///@param dsnet_instance[optional]

var dsnet_instance = id;
if (argument_count >= 1) {
	dsnet_instance = argument[0];
}

if (__obj_dsnet_container.verbose) debug_log("DSNET: SEND PACKET ON " + object_get_name(dsnet_instance.object_index));

if (__obj_dsnet_container.debug) {
	if (dsnet_instance.object_index != __obj_dsnet_connected_client && dsnet_instance.object_index != __obj_dsnet_client) {
		debug_log("DSNET: Cannot call dsnet_send() to " + string(object_get_name(dsnet_instance.object_index) + " - only on __obj_dsnet_connected_client or __obj_dsnet_client"));
		return 0;
	}
}

with (dsnet_instance) {
	if (__obj_dsnet_container.is_html5) {
		// We're in the browser - send the packet through the JS extension
		dsnet_js_send(socket, buffer_get_address(send_buffer), buffer_tell(send_buffer));
	} else {
		//Note: This code also resides in __dsnet_send_array
		if (websocket) { 
			//If the client is a websocket, we have to add a websocket header to the packet
			__dsnet_send_buffer_to_ws_buffer();

			// We can use send raw since its a WS packed message - WS Client will turn it into seperate packets
			network_send_raw(socket, ws_buffer, buffer_tell(ws_buffer)); 
		} else {
			// @todo
			// Now that we know we're not in the browser, and the client is not a websocket client.. It might be so that this client is actually ourselves (or a bot) - 
			// in this case we don't need to send the message over the network interface, but we can just call the async event as if its called from a network async event.
			// This saves overhead.
			
			// We send this as a packet so that every message triggers an async event in GM
			network_send_packet(socket, send_buffer, buffer_tell(send_buffer));
		}
	}
}