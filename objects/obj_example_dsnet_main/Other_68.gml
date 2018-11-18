var inboundSocket = async_load[? "id"];
var type = async_load[? "type"];
var socket = async_load[? "socket"];
var ip = async_load[? "ip"];
var buffer = async_load[? "buffer"];
var size = async_load[? "size"];

show_debug_message("                      SECOND TEST ASYNC EVENT SOCKET"+string(inboundSocket) + "[type: "+string(type)+", socket:"+string(socket)+", ip:"+string(ip)+", buffer:"+string(buffer)+", size:"+string(size)+"]");