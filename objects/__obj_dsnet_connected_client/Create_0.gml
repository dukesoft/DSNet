ip = undefined;
ping = 0;
pingTimer = 0;
websocket = false;
handshake = false;
handshake_challenge = undefined;
socket = undefined;
parent = noone;
handshake_timer = undefined;

send_buffer = buffer_create(1500, buffer_fixed, 1);

messageTimeout = 0;

cleanedUp = false