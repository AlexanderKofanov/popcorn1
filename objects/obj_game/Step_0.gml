var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);

if mouse_check_button_pressed(mb_left)
{
	if point_in_rectangle(mx, my, candle_x - candle_half_w, candle_y - candle_half_h, candle_x + candle_half_w, candle_y + candle_half_h)
	{
		dragging_candle = true;
		drag_dx = candle_x - mx;
		drag_dy = candle_y - my;
	}
	else
	{
		for (var i = array_length(popcorns) - 1; i >= 0; i--)
		{
			var p = popcorns[i];
			if !p.collected && point_distance(mx, my, p.x, p.y - p.z) <= p.hit_r
			{
				p.collected = true;
				p.collect_timer = 16;
				popcorns[i] = p;
				score += 1;
				part_particles_create(ps_table, p.x, p.y - p.z - 6, pt_money, 18);
				break;
			}
		}
	}
}

if mouse_check_button_released(mb_left)
{
	dragging_candle = false;
}

if dragging_candle
{
	candle_x = clamp(mx + drag_dx, table_left + candle_half_w, table_right - candle_half_w);
	candle_y = clamp(my + drag_dy, table_top + candle_half_h, table_bottom - candle_half_h);
}

var flame_x = candle_x;
var flame_y = candle_y - candle_half_h * 0.75;
part_particles_create(ps_table, flame_x + random_range(-2, 2), flame_y + random_range(-3, 1), pt_flame, 1);

for (var i = array_length(kernels) - 1; i >= 0; i--)
{
	var k = kernels[i];

	k.z += k.vz;
	k.vz -= k.gravity;
	k.x += k.vx;
	k.y += k.vy;
	k.vx *= 0.992;
	k.vy *= 0.992;

	if k.x < table_left + 10 || k.x > table_right - 10
	{
		k.vx *= -0.5;
		k.x = clamp(k.x, table_left + 10, table_right - 10);
	}
	if k.y < table_top + 10 || k.y > table_bottom - 10
	{
		k.vy *= -0.5;
		k.y = clamp(k.y, table_top + 10, table_bottom - 10);
	}

	if k.z <= 0
	{
		k.z = 0;
		if abs(k.vz) > 0.55
		{
			k.vz = -k.vz * random_range(0.25, 0.42);
			k.vx += random_range(-0.28, 0.28);
			k.vy += random_range(-0.28, 0.28);
			k.image_angle += random_range(-45, 45);
			part_particles_create(ps_table, k.x, k.y, pt_seed_hit, irandom_range(4, 7));
		}
		else
		{
			k.vz = 0;
			k.landed = true;
		}
	}

	k.image_angle += k.spin;
	k.spin *= 0.98;

	var near_flame = point_distance(k.x, k.y, flame_x, flame_y) < candle_flame_radius;
	if near_flame && k.z <= 4
	{
		var burst_dir = random(360);
		var p = {
			x: k.x,
			y: k.y,
			z: 0,
			vx: lengthdir_x(random_range(2.6, 4.2), burst_dir),
			vy: lengthdir_y(random_range(2.6, 4.2), burst_dir),
			vz: random_range(5.4, 7.2),
			gravity: random_range(0.26, 0.34),
			image_angle: random(360),
			spin: random_range(-10, 10),
			hit_r: 34,
			burst_timer: 18,
			landed: false,
			collected: false,
			collect_timer: 0
		};
		array_push(popcorns, p);
		part_particles_create(ps_table, k.x, k.y - 4, pt_pop_burst, irandom_range(30, 42));
		array_delete(kernels, i, 1);
		continue;
	}

	kernels[i] = k;
}

for (var j = array_length(popcorns) - 1; j >= 0; j--)
{
	var pp = popcorns[j];

	if !pp.collected
	{
		pp.z += pp.vz;
		pp.vz -= pp.gravity;
		pp.x += pp.vx;
		pp.y += pp.vy;
		pp.vx *= 0.985;
		pp.vy *= 0.985;
		pp.image_angle += pp.spin;
		pp.spin *= 0.985;

		if pp.x < table_left + 12 || pp.x > table_right - 12
		{
			pp.vx *= -0.45;
			pp.x = clamp(pp.x, table_left + 12, table_right - 12);
		}
		if pp.y < table_top + 12 || pp.y > table_bottom - 12
		{
			pp.vy *= -0.45;
			pp.y = clamp(pp.y, table_top + 12, table_bottom - 12);
		}

		if pp.z <= 0
		{
			pp.z = 0;
			if abs(pp.vz) > 1.2
			{
				pp.vz = -pp.vz * random_range(0.24, 0.36);
				pp.vx *= 0.7;
				pp.vy *= 0.7;
				part_particles_create(ps_table, pp.x, pp.y, pt_seed_hit, irandom_range(2, 4));
			}
			else
			{
				pp.vz = 0;
				pp.landed = true;
			}
		}
	}

	if pp.burst_timer > 0 pp.burst_timer -= 1;
	if pp.collect_timer > 0
	{
		pp.collect_timer -= 1;
		pp.z += 0.8;
	}
	if pp.collected && pp.collect_timer <= 0
	{
		array_delete(popcorns, j, 1);
		continue;
	}

	popcorns[j] = pp;
}
