var xx = camera_get_view_x(view_camera)
var yy = camera_get_view_y(view_camera)
instance_create_depth(xx + obs.camera_w - 60, yy + 60, -100, obj_restart_button)
instance_create_depth(xx + 60, yy + 60, -100, obj_settings_button)