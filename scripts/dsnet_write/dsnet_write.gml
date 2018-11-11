///@param dsnet_instance
///@param buffer_type
///@param value

var ds_instance = argument0;
var type = argument1;
var val = argument2;

if (__obj_dsnet_container.debug) {
	val = __dsnet_clean_debug_buffer_value(type, val); //This does extra checks and outputs debug info
} else {
	val = __dsnet_clean_buffer_value(type, val); //This only sanitizes based on value
}

buffer_write(ds_instance.send_buffer, type, val);
