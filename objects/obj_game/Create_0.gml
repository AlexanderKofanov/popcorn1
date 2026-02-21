depth = 100;

// Границы столешницы
var table_margin_x = 210;
var table_margin_top = 190;
var table_margin_bottom = 130;

table_left = table_margin_x;
table_top = table_margin_top;
table_right = room_width - table_margin_x;
table_bottom = room_height - table_margin_bottom;

kernels = [];
popcorns = [];
score = 0;

// Свечка в углу стола
candle_half_w = sprite_get_width(spr_candle) * 0.5;
candle_half_h = sprite_get_height(spr_candle) * 0.5;
candle_flame_radius = 78;
candle_x = table_left + candle_half_w + 22;
candle_y = table_top + candle_half_h + 22;
dragging_candle = false;
drag_dx = 0;
drag_dy = 0;

spawn_interval = max(1, room_speed div 2); // каждые 0.5 сек
alarm[0] = spawn_interval;

// Партиклы
ps_table = part_system_create_layer("normal", false);
pt_seed_hit = part_type_create();
part_type_shape(pt_seed_hit, pt_shape_flare);
part_type_size(pt_seed_hit, 0.12, 0.35, 0, 0);
part_type_alpha2(pt_seed_hit, 0.95, 0);
part_type_color2(pt_seed_hit, make_color_rgb(245, 208, 94), make_color_rgb(202, 118, 52));
part_type_speed(pt_seed_hit, 1.4, 2.8, 0, 0);
part_type_direction(pt_seed_hit, 0, 360, 0, 0);
part_type_life(pt_seed_hit, 12, 22);
part_type_gravity(pt_seed_hit, 0.1, 270);

pt_pop_burst = part_type_create();
part_type_shape(pt_pop_burst, pt_shape_cloud);
part_type_size(pt_pop_burst, 0.2, 0.6, 0, 0);
part_type_alpha2(pt_pop_burst, 0.9, 0);
part_type_color3(pt_pop_burst, c_white, make_color_rgb(255, 236, 176), make_color_rgb(255, 172, 106));
part_type_speed(pt_pop_burst, 2.2, 4.8, 0, 0);
part_type_direction(pt_pop_burst, 0, 360, 0, 0);
part_type_life(pt_pop_burst, 18, 34);
part_type_gravity(pt_pop_burst, 0.07, 270);

pt_money = part_type_create();
part_type_shape(pt_money, pt_shape_pixel);
part_type_size(pt_money, 0.3, 0.5, 0, 0);
part_type_alpha2(pt_money, 1, 0);
part_type_color2(pt_money, make_color_rgb(170, 255, 120), make_color_rgb(83, 196, 89));
part_type_speed(pt_money, 1.3, 3.0, 0, 0);
part_type_direction(pt_money, 210, 330, 0, 0);
part_type_life(pt_money, 14, 26);
part_type_gravity(pt_money, 0.06, 270);

pt_flame = part_type_create();
part_type_shape(pt_flame, pt_shape_circle);
part_type_size(pt_flame, 0.08, 0.22, -0.003, 0);
part_type_alpha2(pt_flame, 0.8, 0);
part_type_color3(pt_flame, make_color_rgb(255, 200, 90), make_color_rgb(255, 130, 55), make_color_rgb(255, 240, 180));
part_type_speed(pt_flame, 0.1, 0.45, 0, 0);
part_type_direction(pt_flame, 70, 110, 0, 0);
part_type_life(pt_flame, 10, 18);
part_type_gravity(pt_flame, 0.03, 90);

var xx = camera_get_view_x(view_camera);
var yy = camera_get_view_y(view_camera);
instance_create_depth(xx + obs.camera_w - 60, yy + 60, -100, obj_restart_button);
instance_create_depth(xx + 60, yy + 60, -100, obj_settings_button);
