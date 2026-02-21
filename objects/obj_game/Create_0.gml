depth = 100;
color = c_gray;

// Игровое поле (стол)
table_left = 220;
table_top = 200;
table_right = room_width - 220;
table_bottom = room_height - 120;

kernels = [];
popcorns = [];
score = 0;

// Свечка (перетаскивается мышкой)
candle_x = room_width * 0.5;
candle_y = room_height * 0.65;
candle_r = 26;
flame_r = 18;
dragging_candle = false;
drag_dx = 0;
drag_dy = 0;

spawn_interval = room_speed div 2; // ~0.5 сек
alarm[0] = spawn_interval;

var xx = camera_get_view_x(view_camera);
var yy = camera_get_view_y(view_camera);
instance_create_depth(xx + obs.camera_w - 60, yy + 60, -100, obj_restart_button);
instance_create_depth(xx + 60, yy + 60, -100, obj_settings_button);
