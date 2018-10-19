client = dsnet_client_create(
	"127.0.0.1", 
	8000, 
	__example_dsnet_client_onconnect,
	__example_dsnet_client_ondisconnect, 
	__example_dsnet_client_ondata
);