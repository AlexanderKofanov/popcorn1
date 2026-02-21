var spawn_x = random_range(table_left + 30, table_right - 30);
var spawn_y = random_range(table_top + 30, table_bottom - 30);

var kernel = {
	x: spawn_x,
	y: spawn_y,
	z: random_range(20, 30), // ~1 см над столом в масштабе сцены
	vx: random_range(-0.35, 0.35),
	vy: random_range(-0.35, 0.35),
	vz: random_range(0.2, 0.6),
	gravity: random_range(0.22, 0.3),
	spin: random_range(-7, 7),
	image_angle: random(360),
	landed: false,
	draw_y: spawn_y
};

array_push(kernels, kernel);
alarm[0] = spawn_interval;
