depth = 100;

// Границы плиты
var table_margin_x = 210;
var table_margin_top = 190;
var table_margin_bottom = 130;

table_left = table_margin_x;
table_top = table_margin_top;
table_right = room_width - table_margin_x;
table_bottom = room_height - table_margin_bottom;

// Конфиг баланса
cfg = {
	temperature: {
		start: 110,
		step: 15,
		max_base: 260,
		base_power: 0.22,
		power_per_degree: 0.003,
		cost_base: 15,
		cost_growth: 1.38
	},
	kernels: {
		spawn_interval: room_speed,
		drop_height_min: 15,
		drop_height_max: 22,
		collect_radius_start: 30,
		special_spawn_chance: 0.06
	},
	popcorn_types: [
		{ name: "classic", cook_time: 3.4, value: 1, weight: 70, unlocked: true, spawn_rate_lvl: 0, spawn_rate_cost: 25 },
		{ name: "caramel", cook_time: 5.5, value: 4, weight: 20, unlocked: false, spawn_rate_lvl: 0, spawn_rate_cost: 90 },
		{ name: "cheese", cook_time: 7.8, value: 8, weight: 10, unlocked: false, spawn_rate_lvl: 0, spawn_rate_cost: 260 }
	],
	items: [
		{ id: "matches", power: 0.95, radius: 84, cost: 40, unlocked: true, hold_to_work: true, max_count: 1 },
		{ id: "candle", power: 0.4, radius: 92, cost: 60, unlocked: true, hold_to_work: false, max_count: 6 },
		{ id: "lighter", power: 1.25, radius: 76, cost: 120, unlocked: false, hold_to_work: true, max_count: 1 },
		{ id: "dryer", power: 1.9, radius: 118, cost: 220, unlocked: false, hold_to_work: true, max_count: 1 },
		{ id: "flamethrower", power: 3.6, radius: 142, cost: 500, unlocked: false, hold_to_work: true, max_count: 1 },
		{ id: "sun", power: 5.3, radius: 188, cost: 1200, unlocked: false, hold_to_work: false, max_count: 1 }
	],
	prestige: {
		need_points: 2,
		hand_spawn_base: room_speed * 9,
		hand_profit_mult: 0.55
	}
};

kernels = [];
popcorns = [];
items = [];
hands = [];

money = 0;
prestige_points = 0;
prestige_bank = 0;

temp_level = 0;
temp_current = cfg.temperature.start;
max_temperature = cfg.temperature.max_base;

collect_radius_bonus = 0;
special_chance_bonus = 0;
item_radius_mult = 1;
item_power_mult = 1;
profit_mult = 1;

hands_unlocked = false;
hand_rate_mult = 1;
hand_profit_mult = 1;

panel_h = 122;
btn_h = 30;
btn_w = 148;

active_item_uid = -1;
drag_item_uid = -1;
drag_dx = 0;
drag_dy = 0;

spawn_interval = cfg.kernels.spawn_interval;
alarm[0] = spawn_interval;
hand_spawn_timer = cfg.prestige.hand_spawn_base;

// Базовые предметы
var uid_seed = 0;
for (var i = 0; i < array_length(cfg.items); i++)
{
	var def = cfg.items[i];
	if (def.unlocked)
	{
		var count = (def.id == "candle") ? 1 : 0;
		for (var c = 0; c < count; c++)
		{
			array_push(items, {
				uid: uid_seed,
				item_id: def.id,
				x: random_range(table_left + 60, table_right - 60),
				y: random_range(table_top + 60, table_bottom - 60),
				active: true,
				hold_alpha: 1,
				slot_x: room_width - 160,
				slot_y: 72 + i * 4,
				radius_pulse: random(100)
			});
			uid_seed += 1;
		}
	}
}
next_item_uid = uid_seed;

prestige_upgrades = [
	{ id: "max_temp", cost: 2, level: 0, max_level: 5 },
	{ id: "unlock_items", cost: 2, level: 0, max_level: 5 },
	{ id: "item_radius", cost: 1, level: 0, max_level: 8 },
	{ id: "item_power", cost: 1, level: 0, max_level: 8 },
	{ id: "special_rate", cost: 1, level: 0, max_level: 8 },
	{ id: "collect_radius", cost: 1, level: 0, max_level: 8 },
	{ id: "hand_rate", cost: 1, level: 0, max_level: 8 },
	{ id: "hand_profit", cost: 1, level: 0, max_level: 8 },
	{ id: "profit_all", cost: 1, level: 0, max_level: 8 }
];
show_prestige_window = false;

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

pt_special = part_type_create();
part_type_shape(pt_special, pt_shape_spark);
part_type_size(pt_special, 0.18, 0.35, 0, 0);
part_type_alpha2(pt_special, 0.95, 0);
part_type_color3(pt_special, make_color_rgb(120, 235, 255), make_color_rgb(255, 255, 255), make_color_rgb(181, 125, 255));
part_type_speed(pt_special, 0.4, 1.2, 0, 0);
part_type_direction(pt_special, 0, 360, 0, 0);
part_type_life(pt_special, 12, 26);

var xx = camera_get_view_x(view_camera);
var yy = camera_get_view_y(view_camera);
instance_create_depth(xx + obs.camera_w - 60, yy + 60, -100, obj_restart_button);
instance_create_depth(xx + 60, yy + 60, -100, obj_settings_button);
