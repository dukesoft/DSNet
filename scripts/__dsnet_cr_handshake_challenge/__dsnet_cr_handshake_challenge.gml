///@param buffer
var buffer = argument0;

var challenge = buffer_read(buffer, buffer_string);

var b = __dsnet_create_packet(dsnet_msg.c_handshake_answer);
buffer_write(b, buffer_string,  script_execute(__obj_dsnet_container.handshake_validation_method, challenge));
dsnet_send();