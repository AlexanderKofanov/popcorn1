var spawn_x = random_range(table_left + 40, table_right - 40);
var spawn_y = table_top - random_range(110, 180);

var kernel = {
	x: spawn_x,
	y: spawn_y,
	vx: random_range(-2.2, 2.2),
	vy: random_range(1.4, 3.0),
	grav: random_range(0.12, 0.2),
	ang: random(360),
	ang_spd: random_range(-8, 8),
	r: random_range(6, 10),
	landed: false
};

array_push(kernels, kernel);
alarm[0] = spawn_interval;
