///@param buffer
var buffer = argument0;

//Difference between when we sent the request, and when we got the response
var curTimer = (get_timer() - lastPingRequest)/1000; 
 
//We have to subtract AT LEAST 1 server frame because GM's async setup will always add 1 frame of latency
curTimer -= __obj_dsnet_container.frame_time*1000;

ping = curTimer;
if (ping < 0) {
	ping = 0;
}