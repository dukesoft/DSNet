///@param buffer_type
///@param value

var type = argument0;
var val = argument1;

if (__obj_dsnet_container.debug) {
	val = __dsnet_clean_debug_buffer_value(type, val); //This does extra checks and outputs debug info
} else {
	val = __dsnet_clean_buffer_value(type, val); //This only sanitizes based on value
}

buffer_write(send_buffer, type, val);
