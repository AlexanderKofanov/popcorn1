if instance_exists(obj_game)
	color = obj_game.color
else
	color = obj_menu.color
var c = color
color_icon = merge_color(c, c_white, 0.9)
color_bottom = merge_color(c, c_black, 0.5)