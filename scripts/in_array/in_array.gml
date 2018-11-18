///@param needle
///@param haystack

var needle = argument0;
var haystack = argument1;

if (!is_array(haystack)) {
	return false;
}

var arsize = array_length_1d(haystack);

if (arsize == 0) {
	return false;
}

for (var i = 0; i < arsize; i++) {
	if (haystack[i] == needle) {
		return true;
	}
}

return false;