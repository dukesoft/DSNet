//Loop through the spawned players and remove them
show_debug_message("obj_example_dsnet_client:destroy");
var key = ds_map_find_first(clients);
while (is_string(key)) {
	instance_destroy(clients[? key]); //Destroys all [obj_example_dsnet_player_other]
	key = ds_map_find_next(clients, key);
}

// Delete our player
instance_destroy(obj_example_dsnet_player);

// Delete the client
dsnet_client_destroy(ds_client);

// Clean up
ds_map_destroy(clients);

debug_log("[EXAMPLE] [CLIENT] Client destroyed");