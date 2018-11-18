is_html5 = (os_browser != browser_not_a_browser);
draw_debug = true;
debug = true;
verbose = false;
msglog = false;

nonblocking = true;

network_timeout = 10 * 1000; //10 seconds
handshake_timeout = 1; //1 second - if handshake doesn't properly happen within 1 second, kill the connection
ping_time = 1; //1 ping per second
packetsize = 1500; //Max packet size, try to stay under 1600 for internet usage - 15000 is OK for LAN. (Fragmentation and all that)

custom_id_buffer_type = buffer_u8; // If you have more than 254 different messages, you should step up to the next (buffer_u16)

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
