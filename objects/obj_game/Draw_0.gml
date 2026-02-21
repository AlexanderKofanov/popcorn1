//if !surface_exists(surf_field)
//surf_field = surface_create(1100, 1600)

var c1 = merge_color(color, c_black, 0.65)
var c2 = merge_color(color, c_black, 0.15)
var s = current_time / 200

draw_rectangle_color(camera_get_view_x(view_camera), camera_get_view_y(view_camera), obs.camera_w, obs.camera_h, c2, c1, c2, c1, 0)
draw_sprite_tiled_ext(spr_back_pattern, 0, 0 - s, 0 + s, 1, 1, 0, 0.12)

//surface_set_target(surf_field)
//draw_clear_alpha(c_black, 0)
//with obj_hex
//	draw_sprite_ext(spr_hex_field, 0, x, y, image_xscale, image_yscale, image_angle, c_white, 1)
//surface_reset_target()
//draw_surface_ext(surf_field, 0, 0, 1, 1, 0, 0, 0.3)