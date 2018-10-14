///@param bufferdatatype

switch (argument0) {
	case buffer_bool:
	case buffer_u8:
	case buffer_s8:
		return 1;
	case buffer_u16:
	case buffer_s16:
	case buffer_f16:
		return 2;
	case buffer_u32:
	case buffer_s32:
	case buffer_f32:
		return 4;
	case buffer_u64:
	case buffer_f64:
		return 8;
	case buffer_string:
	default:
		return 0;
}