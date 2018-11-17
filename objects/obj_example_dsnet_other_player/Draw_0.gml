draw_sprite_ext(sprite_index, 0, x, y, 1, 1, 0, image_blend, 1);
draw_set_valign(fa_top);
draw_set_halign(fa_center);
draw_text(x, y+16, username + "\n" + string(mp_id));