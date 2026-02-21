/// @param x 
/// @param y
/// @param string
/// @param string scale
/// @param angle
function pretty_text(argument0, argument1, argument2, argument3, argument4) 
{
	var xx = argument0
	var yy = argument1 + 2
	var c = c_white
	if instance_exists(obj_game)
		c = obj_game.color
	var s = argument2
	var scale = argument3
	var a = argument4
	var l = string_length(s)
	var w = string_width(s) * scale
	var char_l = w / l
	var x_start = w / 2
	var i = l
	var b_c = merge_color(c, c_black, 0.7)
	var c1 = c_white
	c = merge_color(c, c_white, 0.9)
	draw_set_halign(fa_right)
	var ss = 3 * scale
	if scale < 0.5
		ss = 2
	repeat l
	{
		var n = string_char_at(s, i)
		draw_text_transformed_color(xx - x_start + char_l * i - ss, yy, n, scale, scale, a, b_c, b_c, b_c, b_c, 1)
		draw_text_transformed_color(xx - x_start + char_l * i + ss, yy, n, scale * 0.9, scale * 0.9, a, c1, c1, c, c, 1)
		i--;
	}
	draw_set_halign(fa_center)
}
