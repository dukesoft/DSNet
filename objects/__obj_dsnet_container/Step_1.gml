delta = (room_speed/1000000)*delta_time; //60 being default FPS
frame_time = delta/room_speed;

//show_debug_message(" =================== FRAME " + string(get_timer()) + " =========================");