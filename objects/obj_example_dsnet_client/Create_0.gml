client = dsnet_client_create(
	"127.0.0.1", 
	8000, 
	
	//these functions are executed in context of this object once they happen
	__example_dsnet_client_onconnect, 
	__example_dsnet_client_ondisconnect,
	__example_dsnet_client_ondata 
);

username = get_string("Please enter your username", "Username");