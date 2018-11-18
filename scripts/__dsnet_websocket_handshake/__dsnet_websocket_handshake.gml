//if (live_call(argument0)) return live_result;
///@param request
///@description This validates a string to be a valid websocket handshake, and if it is, returns the response. Otherwise returns false.
var response = argument0;
show_debug_message("\n====" + string(response) + "\n===");
requestSet = string_explode("\r\n", response);

/*
Example request from a browser looks like this - this is the minimum info required as per RFC6455, v13.

GET /chat HTTP/1.1
Host: server.example.com
Upgrade: websocket
Connection: Upgrade
Sec-WebSocket-Key: x3JJHMbDL1EzLkh9GBhXDw==
Sec-WebSocket-Protocol: dsnet
Sec-WebSocket-Version: 13
Origin: http://example.com

*/

if (array_length_1d(requestSet) < 8) {
	return false; //Early return - its not a valid response
}

//Ignore if the first is not what we're looking for
if (requestSet[0] != "GET / HTTP/1.1") {
	if (verbose) debug_log("DSNET: Websocket request denied, URL has to be '/'. Requested was " + string(requestSet[0]));
	return false;
}

// Read out the headers
var h_host = undefined;
var h_upgrade = undefined;
var h_connection = undefined;
var h_sec_websocket_key = undefined;
var h_sec_websocket_protocol = undefined;
var h_sec_websocket_version = undefined;
var h_origin = undefined;


for (var i = 0; i < array_length_1d(requestSet)-2; i++) {
	var value = extract_header_from_string(requestSet[i]);
	if (is_array(value) && value[0] == "Host") { h_host = value[1]; }
	if (is_array(value) && value[0] == "Upgrade") { h_upgrade = value[1]; }
	if (is_array(value) && value[0] == "Connection") { h_connection = value[1]; }
	if (is_array(value) && value[0] == "Sec-WebSocket-Key") { h_sec_websocket_key = value[1]; }
	if (is_array(value) && value[0] == "Sec-WebSocket-Protocol") { h_sec_websocket_protocol = value[1]; }
	if (is_array(value) && value[0] == "Sec-WebSocket-Version") { h_sec_websocket_version = value[1]; }
	if (is_array(value) && value[0] == "Origin") { h_origin = value[1]; }
}

h_connection = string_explode(", ", h_connection);

if (!in_array("Upgrade", h_connection)) {
	if (verbose) debug_log("DSNET: Websocket request denied: Connection must contain 'Upgrade'");
	return false;
}

if (h_upgrade != "websocket") {
	if (verbose) debug_log("DSNET: Websocket request denied: Upgrade must be 'websocket'");
	return false;
}

if (h_sec_websocket_version != "13") {
	if (verbose) debug_log("DSNET: Websocket request denied: Only Websocket version 13 is supported.");
	return false;
}

if (h_sec_websocket_protocol != "dsnet") {
	if (verbose) debug_log("DSNET: Websocket request denied: Only 1 protocol is supported, and thats 'dsnet'");
	return false;
}

/* Todo: Origin check
if (h_origin != allowed) {
	if (verbose) debug_log("DSNET: Websocket request denied: Origin '" + +"' is not allowed.");
	return false;
}
*/

//Create a temporary buffer for proper base64 encoding
return "HTTP/1.1 101 Switching Protocols" + "\r\n" +
"Upgrade: websocket" + "\r\n" +
"Connection: Upgrade" + "\r\n" +
"Sec-WebSocket-Accept: " + __dsnet_websocket_digest(h_sec_websocket_key) + "\r\n" +
"Sec-WebSocket-Protocol: dsnet" + "\r\n" + "\r\n";
//"Sec-WebSocket-Origin: " + h_origin + "\r\n" +
//"Sec-WebSocket-Location: ws://" + h_host + "/" + "\r\n";