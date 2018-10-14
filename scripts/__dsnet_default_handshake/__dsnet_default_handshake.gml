///@param challenge
///@description returns an answer to the challenge. Should be done by both server and client.

var challenge = argument0;
return sha1_string_utf8(string(game_id) + "-" + string(challenge));