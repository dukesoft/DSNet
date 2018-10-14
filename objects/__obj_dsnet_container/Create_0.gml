is_html5 = (os_browser != browser_not_a_browser);
debug = true;
verbose = true;
network_timeout = 10 * 1000; //10 seconds

handshake_timeout = 1000; //1 second - if handshake doesn't properly happen within 1 second, kill the connection

socketHandles = ds_map_create();

websocket_support = false;
if (is_html5) {
	websocket_support = dsnet_js_ws_supported();
}