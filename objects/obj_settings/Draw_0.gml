var s = shift
var a = alpha
var xx = camera_get_view_x(view_camera)
var yy = camera_get_view_y(view_camera)

draw_set_alpha(a * 0.3)
draw_rectangle_color(xx, yy, obs.camera_w, obs.camera_h, 0, 0, 0, 0, 0)
draw_set_alpha(1)

draw_sprite_ext(sprite_index, 0, x, y, s, s, 0, c_white, a)
