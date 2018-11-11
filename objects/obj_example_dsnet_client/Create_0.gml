username = "User " + string(round(random(8999)+1000));
hue = random(255);
image_blend = make_color_hsv(hue, 192, 192);

// Put our player somewhere in the room
x = 200+random(room_width-200);
y = 200+random(room_height-200);

//Our speed
player_speed = 4; //4*room_speed pixels per frame (so usually 4*60 per second)

//Make ourselves invisible first, because we only want to show ourselves once we've sucessfully connected
visible = false;

ds_client = dsnet_client_create(
	"127.0.0.1", 
	8000,

	//these functions are executed in context of this object once they happen
	__example_dsnet_client_onconnect, 
	__example_dsnet_client_ondisconnect,
	__example_dsnet_client_ondata 
);