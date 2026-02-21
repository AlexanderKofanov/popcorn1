shift = 0
shift_time = 0
alpha = 0
ded = false
var xx = camera_get_view_x(view_camera)
var yy = camera_get_view_y(view_camera)
x = xx + obs.camera_w / 2
y = yy + obs.camera_h / 2
depth = -1000

instance_create_depth(x + 160, y - 110, depth - 1, obj_close_button)
instance_create_depth(x - 80, y, depth - 1, obj_music_button)
instance_create_depth(x + 80, y, depth - 1, obj_sound_button)
