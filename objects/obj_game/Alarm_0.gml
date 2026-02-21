var spawn_x = random_range(table_left + 30, table_right - 30);
var spawn_y = random_range(table_top + 30, table_bottom - 30);

var total_weight = 0;
for (var i = 0; i < array_length(cfg.popcorn_types); i++)
{
	var t = cfg.popcorn_types[i];
	if (!t.unlocked) continue;
	total_weight += t.weight + t.spawn_rate_lvl * 12;
}

var pick = random(max(1, total_weight));
var acc = 0;
var pick_type = cfg.popcorn_types[0];
for (var j = 0; j < array_length(cfg.popcorn_types); j++)
{
	var tt = cfg.popcorn_types[j];
	if (!tt.unlocked) continue;
	acc += tt.weight + tt.spawn_rate_lvl * 12;
	if (pick <= acc)
	{
		pick_type = tt;
		break;
	}
}

var is_special = random(1) < (cfg.kernels.special_spawn_chance + special_chance_bonus);

var kernel = {
	x: spawn_x,
	y: spawn_y,
	z: random_range(cfg.kernels.drop_height_min, cfg.kernels.drop_height_max),
	vx: random_range(-0.2, 0.2),
	vy: random_range(-0.2, 0.2),
	vz: random_range(-0.1, 0.15),
	gravity: random_range(0.22, 0.3),
	spin: random_range(-7, 7),
	image_angle: random(360),
	landed: false,
	cook_progress: 0,
	cook_need: pick_type.cook_time,
	value: pick_type.value,
	special: is_special
};

array_push(kernels, kernel);
alarm[0] = spawn_interval;
