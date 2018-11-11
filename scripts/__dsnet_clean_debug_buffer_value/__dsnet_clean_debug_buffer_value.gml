///@param type
///@param val
///@description Clean the variable based on the buffer type, and return a cleaned, normalized value + debug info

var type = argument0;
var val = argument1;

switch (type) {
	case buffer_string:
	case buffer_text: //I don't recommend using this, as its hard for GM to read out a string thats not 0-byte terminated.
	    if ((!is_string(val)) && __obj_dsnet_container.verbose) debug_log("DSNET: Non-string type is being written as string ["+string(val)+"]");
	    return string(val);
		break;
	case buffer_bool:
		if (!is_bool(val) && __obj_dsnet_container.verbose) debug_log("DSNET: Non-bool type is being written as bool ["+string(val)+"]");
	    return !!(val);
		break;

	//FLOATS
	case buffer_f16:
	case buffer_f32:
	case buffer_f64:
		//@todo - make sure what exact values are allowed in here... Docs state 32bit int, but thats odd since there'd be 0 precision
	    return real(val);
		break;

	//UNSIGNED INTEGERS
	case buffer_u8:
		if ((!is_real(val)) && __obj_dsnet_container.verbose) debug_log("DSNET: Non-real type is being written as buffer_u8 ["+string(val)+"]");
		return __dsnet_clean_debug_clamp(val, 0, 255, "buffer_u8");
		break;
	case buffer_u16:
		if ((!is_real(val)) && __obj_dsnet_container.verbose) debug_log("DSNET: Non-real type is being written as buffer_u16 ["+string(val)+"]");
		return __dsnet_clean_debug_clamp(val, 0, 65535, "buffer_u16");
		break;
	case buffer_u32:
		if ((!is_real(val)) && __obj_dsnet_container.verbose) debug_log("DSNET: Non-real type is being written as buffer_u32 ["+string(val)+"]");
		return __dsnet_clean_debug_clamp(val, 0, 4294967295, "buffer_u32");
		break;
	case buffer_u64:
		if ((!is_real(val)) && __obj_dsnet_container.verbose) debug_log("DSNET: Non-real type is being written as buffer_u64 ["+string(val)+"]");
		return __dsnet_clean_debug_clamp(val, 0, 18446744073709551615, "buffer_u64"); //Thats a lot.
		break;
	
	//SIGNED INTEGERS
	case buffer_s8:
		if ((!is_real(val)) && __obj_dsnet_container.verbose) debug_log("DSNET: Non-real type is being written as buffer_s8 ["+string(val)+"]");
		return __dsnet_clean_debug_clamp(val, -128, 127, "buffer_s8");
		break;
	case buffer_s16:
		if ((!is_real(val)) && __obj_dsnet_container.verbose) debug_log("DSNET: Non-real type is being written as buffer_s16 ["+string(val)+"]");
		return __dsnet_clean_debug_clamp(val, -32768, 32767, "buffer_s16");
		break;
	case buffer_s32:
		if ((!is_real(val)) && __obj_dsnet_container.verbose) debug_log("DSNET: Non-real type is being written as buffer_s32 ["+string(val)+"]");
		return __dsnet_clean_debug_clamp(val, -2147483648, 2147483647, "buffer_s32");
		break;

	default:
		debug_log("DSNET: Unsupported type '"+string(type)+"' with value '"+string(val)+"'");
		return 0;
		break;
}