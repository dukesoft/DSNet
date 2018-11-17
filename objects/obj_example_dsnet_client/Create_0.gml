username = "User " + string(round(random(8999)+1000));
hue = real(random(255));
mp_id = 0; //We receive this from the server

// A map to store all other players' instances
clients = ds_map_create();

//Start up DSNet
ds_client = dsnet_client_create(
	"127.0.0.1", 
	8000,

	//these functions are executed in context of this object once they happen
	__example_dsnet_client_onconnect, 
	__example_dsnet_client_ondisconnect,
	__example_dsnet_client_ondata 
);

// Map the messages
dsnet_msghandle(ex_netmsg.s_info, __example_cr_info);
dsnet_msghandle(ex_netmsg.s_joined, __example_cr_joined);
dsnet_msghandle(ex_netmsg.s_position, __example_cr_position);