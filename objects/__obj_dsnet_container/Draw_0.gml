if (!debug) {
	return;
}

draw_set_color(c_white);
draw_set_font(fnt_dsnet_debug);

socketstring = "";
var key = ds_map_find_first(socketHandles);
while (!is_undefined(key)) {
	socketstring += string(key) + ": ["+string(socketHandles[? key])+"] " + string((socketHandles[? key].server) ? "SERVER" : "CLIENT") + " - " + string((socketHandles[? key].connected) ? "CONNECTED" : "NOT CONNECTED") + "\n";
	key = ds_map_find_next(socketHandles, key);
}

draw_text(500, 20, "Open sockets: " + string(ds_map_size(socketHandles)) + "\n" + socketstring);