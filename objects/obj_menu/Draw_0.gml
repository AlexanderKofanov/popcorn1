var c1 = merge_color(#667BC6, c_black, 0.65)
var c2 = merge_color(#667BC6, c_black, 0.15)
var s = current_time / 200
var xx = camera_get_view_x(view_camera)
var yy = camera_get_view_y(view_camera)
var w = camera_get_view_width(view_camera)

draw_rectangle_color(xx, yy, w, camera_get_view_height(view_camera), c2, c1, c2, c1, 0)
draw_sprite_tiled_ext(spr_back_pattern, 0, 0 - s, 0 + s, 1, 1, 0, 0.12)
