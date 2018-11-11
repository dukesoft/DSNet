///@param type
///@param val
///@description Clean the variable based on the buffer type, and return a cleaned, normalized value

var type = argument0;
var val = argument1;

switch (type) {
	case buffer_string:
	case buffer_text: //I don't recommend using this, as its hard for GM to read out a string thats not 0-byte terminated.
	    return string(val);
		break;
	case buffer_bool:
	    return !!(val);
		break;

	//FLOATS
	case buffer_f16:
	case buffer_f32:
	case buffer_f64:
	    return real(val);
		break;

	//UNSIGNED INTEGERS
	case buffer_u8:
		return clamp(val, 0, 255);
		break;
	case buffer_u16:
		return clamp(val, 0, 65535);
		break;
	case buffer_u32:
		return clamp(val, 0, 4294967295);
		break;
	case buffer_u64:
		return clamp(val, 0, 18446744073709551615); //Thats a lot.
		break;
	
	//SIGNED INTEGERS
	case buffer_s8:
		return clamp(val, -128, 127);
		break;
	case buffer_s16:
		return clamp(val, -32768, 32767);
		break;
	case buffer_s32:
		return clamp(val, -2147483648, 2147483647);
		break;

	default:
		debug_log("DSNET: Unsupported type '"+string(type)+"' with value '"+string(val)+"'");
		return 0;
		break;
}