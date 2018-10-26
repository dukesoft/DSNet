///@param inboundSocket
///@param socket
///@param size
var inboundSocket = argument0;
var socket = argument1;
var bufferSize = argument2;

with (__obj_dsnet_container) {
	return __dsnet_network_async(inboundSocket, network_type_data, socket, undefined, undefined, bufferSize); //Not sending buffer because its webgl, we know its the receive_buffer in the client
}