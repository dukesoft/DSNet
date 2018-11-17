// Store the DSNET Client instance for easy access
ds = obj_example_dsnet_client.ds_client;

// Set out colour
image_blend = make_color_hsv(obj_example_dsnet_client.hue, 192, 192);

// Put our player somewhere in the room
x = 200+random(room_width-200);
y = 200+random(room_height-200);
