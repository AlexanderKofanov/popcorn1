var xxx = camera_get_view_x(view_camera)
var xx = obs.camera_w / 2
var yy = obs.camera_h / 2 - 100
var s = scale - text_shift / 20
var a = scale

draw_sprite_ext(spr_complete, 0, xxx + xx, yy, s, s, -10 + text_shift * 20, c_white, a)