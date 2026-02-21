var p_ = p
var s = obj_settings.shift
var a = obj_settings.alpha
draw_sprite_ext(sprite_index, 0, x, y, s, s, 0, merge_color(color, c_black, 0.6), a)
draw_sprite_ext(sprite_index, 0, x, y - p_, s, s, 0, color, a)
