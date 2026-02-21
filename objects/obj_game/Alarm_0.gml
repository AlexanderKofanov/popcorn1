var spawn_x = random_range(table_left + 30, table_right - 30);
var spawn_y = random_range(table_top + 30, table_bottom - 30);

var kernel = {
	x: spawn_x,
	y: spawn_y,
	z: random_range(16, 20), // ~1 см над столом в масштабе сцены
	vx: random_range(-0.2, 0.2),
	vy: random_range(-0.2, 0.2),
	vz: random_range(-0.1, 0.15),
	gravity: random_range(0.22, 0.3),
	spin: random_range(-7, 7),
	image_angle: random(360),
	landed: false
};

array_push(kernels, kernel);
alarm[0] = spawn_interval;
