///@param key
var shabuffer = buffer_create(20, buffer_fast, 1);
var sha1 = sha1_string_utf8(argument0 + "258EAFA5-E914-47DA-95CA-C5AB0DC85B11");
while (string_length(sha1)>0) {
	buffer_write(shabuffer,buffer_u8, hextodec(string_copy(sha1, 0, 2))); //Write all bytes from the SHA1 string (its hex formatted)
	sha1 = string_copy(sha1, 3, string_length(sha1)-1);
}
var result = buffer_base64_encode(shabuffer, 0, 20); //This is the way websocket does the handshake.
buffer_delete(shabuffer);
return result;