if (!draw_debug) {
	return;
}

draw_set_color(c_white);
draw_set_valign(fa_top);
draw_set_halign(fa_left);
draw_set_font(fnt_dsnet_debug);

socketstring = "";
var key = ds_map_find_first(socketHandles);
while (!is_undefined(key)) {
	var obj = socketHandles[? key];
	if (obj.server) {
		socketstring += string(key) + ": ["+string(obj)+"] SERVER | Clients: " +string(ds_map_size(obj.clients)) + "\n";
	} else {
		socketstring += string(key) + ": ["+string(obj)+"] CLIENT | " + string((obj.connected) ? "CONNECTED" : "NOT CONNECTED") + " | Ping: " +string(obj.ping) + "\n";
	}
	
	
	if (obj.server) {
		var ckey = ds_map_find_first(obj.clients);
		while (!is_undefined(ckey)) {
			var cobj = obj.clients[? ckey];
			socketstring += "    " + string(ckey) + ": ["+string(cobj)+"] " + string((cobj.websocket) ? "WS" : "TCP") + " | " + string((cobj.handshake) ? "HANDSHAKE" : "NO HANDSHAKE") + " | Ping: " + string(cobj.ping) + "\n";
			ckey = ds_map_find_next(obj.clients, ckey);
		}
	}
	key = ds_map_find_next(socketHandles, key);
}

draw_text(500, 20, "Open sockets: " + string(ds_map_size(socketHandles)) + "\n" + socketstring);