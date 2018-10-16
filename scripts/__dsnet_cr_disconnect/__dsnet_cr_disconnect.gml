///@param buffer
var buffer = argument0;

var reason = buffer_read(buffer, buffer_string);
if __obj_dsnet_container.debug debug_log("DSNET: The server disconnected this client. Reason: " + string(reason));
instance_destroy();