ip = undefined;
ping = 0;
pingTimer = 0;
websocket = false;
handshake = false;
handshake_challenge = undefined;
socket = undefined;
parent = noone;
handshake_timer = undefined;

send_buffer = buffer_create(__obj_dsnet_container.packetsize, buffer_fixed, 1);
ws_buffer = undefined; // Only gets set if the client is a websocket one
messageTimeout = 0;

subclient = noone;