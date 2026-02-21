var yy = camera_get_view_y(view_camera)
var xx = camera_get_view_x(view_camera)
var w = camera_get_view_width(view_camera)
var s = logo_scale

draw_sprite_ext(spr_logo, 0, xx + w / 2, yy + 300, s, s, 0, c_white, s + 0.8)