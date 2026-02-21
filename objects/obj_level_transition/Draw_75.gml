var c = cc
var c1 = merge_color(c, c_black, 0.65)
var c2 = merge_color(c, c_black, 0.15)

draw_set_alpha(alpha)
draw_rectangle_color(0, 0, display_get_gui_width(), display_get_gui_height(), c2, c1, c2, c1, 0)
draw_set_alpha(1)