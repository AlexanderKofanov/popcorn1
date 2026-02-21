var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);

if mouse_check_button_pressed(mb_left)
{
	if point_distance(mx, my, candle_x, candle_y) <= candle_r + 14
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
			if !p.collected && point_distance(mx, my, p.x, p.y) <= p.r + 6
			{
				p.collected = true;
				p.collect_timer = 15;
				popcorns[i] = p;
				score += 1;
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
	candle_x = clamp(mx + drag_dx, table_left + 20, table_right - 20);
	candle_y = clamp(my + drag_dy, table_top + 20, table_bottom - 20);
}

for (var i = array_length(kernels) - 1; i >= 0; i--)
{
	var k = kernels[i];
	if !k.landed
	{
		k.x += k.vx;
		k.y += k.vy;
		k.vy += k.grav;
		k.ang += k.ang_spd;
		
		if k.y >= table_bottom - 8
		{
			k.y = table_bottom - 8;
			k.landed = true;
			k.vx = 0;
			k.vy = 0;
		}
		else if k.x <= table_left + 8 || k.x >= table_right - 8
		{
			k.vx *= -0.6;
		}
	}
	
	// Взрыв семечки в попкорн возле свечки
	var near_flame = point_distance(k.x, k.y, candle_x, candle_y - candle_r - 10) <= flame_r + 8;
	if near_flame
	{
		var p = {
			x: k.x,
			y: k.y,
			r: random_range(16, 22),
			burst_timer: 18,
			collected: false,
			collect_timer: 0,
			wiggle: random(360)
		};
		array_push(popcorns, p);
		array_delete(kernels, i, 1);
		continue;
	}
	
	kernels[i] = k;
}

for (var j = array_length(popcorns) - 1; j >= 0; j--)
{
	var pp = popcorns[j];
	pp.wiggle += 8;
	if pp.burst_timer > 0 pp.burst_timer -= 1;
	if pp.collect_timer > 0
	{
		pp.collect_timer -= 1;
		pp.y -= 1.2;
	}
	if pp.collect_timer <= 0 && pp.collected
	{
		array_delete(popcorns, j, 1);
		continue;
	}
	popcorns[j] = pp;
}
