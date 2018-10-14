is_html5 = (os_browser != browser_not_a_browser);
debug = true;
verbose = true;
network_timeout = 10 * 1000; //10 seconds
handshake_timeout = 1; //1 second - if handshake doesn't properly happen within 1 second, kill the connection

custom_id_buffer_type = buffer_u8;

frame_time = 0;
delta = 1;

socketHandles = ds_map_create();

websocket_support = false;
if (is_html5) {
	websocket_support = dsnet_js_ws_supported();
}

messageMap_internal = ds_map_create();
messageMap = ds_map_create();

handshake_validation_method = __dsnet_default_handshake;