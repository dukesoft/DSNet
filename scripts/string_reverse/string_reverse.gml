/// @description string_reverse(string);
/// @param string
/**
 * Reverse a string
 * @param string argument0 String to reverse
 * @return string
 */
var output = "";

var length = string_length(argument0);
for (i=0; i<length; i++) {
    output += string_char_at(argument0, length-i);
}
return output;