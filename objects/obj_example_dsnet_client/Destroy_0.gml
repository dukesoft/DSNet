//Loop through the spawned players and remove them
var key = ds_map_find_first(clients);
while (is_string(key)) {
	instance_destroy(clients[? key]);
	key = ds_map_find_next(clients, key);
}

//Clean up
ds_map_destroy(clients);

dsnet_client_destroy(ds_client);

debug_log("[EXAMPLE] [CLIENT] Client destroyed");