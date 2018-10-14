///@param socket
var socket = argument0;
if (os_browser == browser_not_a_browser) {
	network_send_raw(socket, dsnet_send_buffer, buffer_tell(dsnet_send_buffer));
} else {
	dsnet_js_send_buffer(socket, buffer_get_address(dsnet_send_buffer));
}