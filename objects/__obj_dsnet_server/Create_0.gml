server = true;

clients = ds_map_create();

port = undefined;
maxplayers = undefined;

func_connect = undefined;
func_disconnect = undefined;

server_socket = undefined;

connected = false;

parent = noone;

send_buffer = buffer_create(__obj_dsnet_container.packetsize, buffer_fixed, 1);
ws_buffer = buffer_create(__obj_dsnet_container.packetsize + 32, buffer_fixed, 1);
