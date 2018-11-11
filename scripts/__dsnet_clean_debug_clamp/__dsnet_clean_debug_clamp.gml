///@param value
///@param min
///@param max
///@param name
///@description clamps a value between min and max, and if debug is enabled, shows debug info.
var _val = argument0;
var _min = argument1;
var _max = argument2;
var _name = argument3;

_val = real(_val);

if (_val < _min || _val > _max) {
	debug_log("DSNET: Value '"+string(_val)+"' is not a valid " + string(_name) + " - should be between " + string(_min) + " and " + string(_max));
	return clamp(_val, _min, _max);
}

return _val;