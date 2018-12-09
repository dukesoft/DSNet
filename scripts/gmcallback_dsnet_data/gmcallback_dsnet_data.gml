///@param inboundSocket
///@param socket
///@param size
var inboundSocket = argument0;
var socket = argument1;
var bufferSize = argument2;

with (__obj_dsnet_container) {
	//We're not sending the buffer itself (undefined) because we know this is JS in the event - we extract the data there from a shared buffer.
	return __dsnet_network_async(inboundSocket, network_type_data, socket, undefined, undefined, bufferSize);
}