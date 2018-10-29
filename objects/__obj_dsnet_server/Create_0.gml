server = true;

clients = ds_map_create();

port = undefined;
maxplayers = undefined;

func_connect = undefined;
func_disconnect = undefined;
func_data = undefined;

server_socket = undefined;

connected = false;

parent = noone;

cleanedUp = false;

send_buffer = buffer_create(1500, buffer_fixed, 1);