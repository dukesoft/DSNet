///@param inboundSocket

var inboundSocket = argument0;

var obj = socketHandles[? inboundSocket];

if (obj == undefined) {
	//Its not a server / direct client - it might now be a connected client sending data. Search through our servers
	var skey = ds_map_find_first(socketHandles);
	while (!is_undefined(skey)) {
		var sobj = socketHandles[? skey];
		if (sobj.server) {
			if (sobj.clients[? inboundSocket] != undefined) {
				obj = sobj.clients[? inboundSocket];
				break;
			}
		}
		skey = ds_map_find_next(socketHandles, skey);
	}
}

if (verbose) {
	if (obj != undefined) {
		debug_log("DSNET: Socket #" + string(inboundSocket) + " is bound to " + object_get_name(obj.object_index));
	} else {
		debug_log("DSNET: Socket #" + string(inboundSocket) + " is not bound to an object.");
	}	
}


return obj;