///Handle all networking
// since the async event is triggered EVERYWHERE in EVERY object, this sends it to the proper ones
var inboundSocket = async_load[? "id"];
var type = async_load[? "type"];
var socket = async_load[? "socket"];
var ip = async_load[? "ip"];
var buffer = async_load[? "buffer"];
var size = async_load[? "size"];

if (is_undefined(buffer)) {
	buffer = false;
}

if (is_undefined(size)) {
	size = false;
}

show_debug_message("               ASYNC EVENT SOCKET"+string(inboundSocket) + "[type: "+string(type)+", socket:"+string(socket)+", ip:"+string(ip)+", buffer:"+string(buffer)+", size:"+string(size)+"]");
testfunction();
return __dsnet_network_async(inboundSocket, type, socket, ip, buffer, size);
show_debug_message("                   AFTER FUNCTION");