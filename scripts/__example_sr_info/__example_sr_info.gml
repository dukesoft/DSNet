///@param buffer
var buffer = argument0;

username = buffer_read(buffer, buffer_string);

debug_log("Received info from client: " + string(username));