var xxx = camera_get_view_x(view_camera)
var xx = obs.camera_w / 2
var yy = obs.camera_h / 2 - 100
var s = scale
var c = merge_color(#FFB733, c_white, 0.8)

draw_sprite_ext(spr_shine, 0, xxx + xx, yy, s * 1.1, s * 1.1, image_angle, c, s)
draw_sprite_ext(spr_shine, 0, xxx + xx, yy, s * 0.9, s * 0.9, -image_angle, #FFB733, s)