//server_ip = "145.131.24.156"; //it hurts when IP
server_ip = "127.0.0.1"; //it hurts when IP
server_port = 8000;

username = "User " + string(round(random(8999)+1000));
hue = real(random(255));
mp_id = 0; //We receive this from the server

// A map to store all other players' instances
clients = ds_map_create();

// To potentially display information to the user (Connecting...)
connected = false;

//Start up DSNet
ds_client = noone; //In case of a blocking connect, the function call can immediately destroy the client after creating. To prevent "unknown instance" errors, we set this to noone first.
ds_client = dsnet_client_create(
	server_ip, 
	server_port,

	//these functions are executed in context of this object once they happen
	example_client_onconnect, 
	example_client_ondisconnect
);

// Map the messages
dsnet_msghandle(ex_netmsg.s_info, example_cr_info);
dsnet_msghandle(ex_netmsg.s_joined, example_cr_joined);
dsnet_msghandle(ex_netmsg.s_left, example_cr_left);
dsnet_msghandle(ex_netmsg.s_position, example_cr_position);