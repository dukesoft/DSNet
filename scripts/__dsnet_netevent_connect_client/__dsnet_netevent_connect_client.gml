//Happening in a real client
//We send the fact that we're ready for the handshake
__dsnet_create_packet(dsnet_msg.c_ready_for_handshake);
dsnet_send();
return true;