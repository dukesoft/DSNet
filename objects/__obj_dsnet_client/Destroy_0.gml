///On destroy we clean up anything that links to us
destroying = true;
with (parent) {
	script_execute(other.func_disconnect);
}

if (!is_undefined(socket)) {
	ds_map_delete(__obj_dsnet_container.socketHandles, socket);	
}