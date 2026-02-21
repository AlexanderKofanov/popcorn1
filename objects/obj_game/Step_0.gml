var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);
var mouse_down = mouse_check_button(mb_left);

var panel_top = 0;
var panel_bottom = panel_h;
var col_w = room_width / 4;

function _item_def(_item_id)
{
	for (var ii = 0; ii < array_length(cfg.items); ii++)
	{
		if (cfg.items[ii].id == _item_id) return cfg.items[ii];
	}
	return cfg.items[0];
}

function _item_count(_item_id)
{
	var amount = 0;
	for (var ii = 0; ii < array_length(items); ii++)
	{
		if (items[ii].item_id == _item_id) amount += 1;
	}
	return amount;
}

function _buy_item(_item_id)
{
	for (var ii = 0; ii < array_length(cfg.items); ii++)
	{
		var def = cfg.items[ii];
		if (def.id == _item_id)
		{
			if (!def.unlocked) return;
			if (_item_count(_item_id) >= def.max_count) return;
			if (money < def.cost) return;
			money -= def.cost;
			array_push(items, {
				uid: next_item_uid,
				item_id: def.id,
				x: random_range(table_left + 60, table_right - 60),
				y: random_range(table_top + 60, table_bottom - 60),
				active: !def.hold_to_work,
				hold_alpha: def.hold_to_work ? 0 : 1,
				slot_x: room_width - 145,
				slot_y: 90,
				radius_pulse: random(100)
			});
			next_item_uid += 1;
			return;
		}
	}
}

if mouse_check_button_pressed(mb_left)
{
	if (point_in_rectangle(mx, my, col_w * 0 + 14, 18, col_w * 0 + btn_w + 14, 18 + btn_h))
	{
		var temp_cost = floor(cfg.temperature.cost_base * power(cfg.temperature.cost_growth, temp_level));
		if (money >= temp_cost && temp_current + cfg.temperature.step <= max_temperature)
		{
			money -= temp_cost;
			temp_level += 1;
			temp_current += cfg.temperature.step;
		}
	}

	if (point_in_rectangle(mx, my, col_w * 1 + 14, 18, col_w * 1 + btn_w + 14, 18 + btn_h))
	{
		_buy_item("matches");
	}
	if (point_in_rectangle(mx, my, col_w * 1 + 14, 54, col_w * 1 + btn_w + 14, 54 + btn_h))
	{
		_buy_item("candle");
	}
	if (point_in_rectangle(mx, my, col_w * 1 + 14, 90, col_w * 1 + btn_w + 14, 90 + btn_h))
	{
		_buy_item("lighter");
	}

	if (point_in_rectangle(mx, my, col_w * 2 + 14, 18, col_w * 2 + btn_w + 14, 18 + btn_h))
	{
		var t0 = cfg.popcorn_types[0];
		if (!t0.unlocked && money >= 45) { money -= 45; t0.unlocked = true; cfg.popcorn_types[0] = t0; }
		else if (t0.unlocked)
		{
			var c0 = floor(t0.spawn_rate_cost * power(1.34, t0.spawn_rate_lvl));
			if (money >= c0) { money -= c0; t0.spawn_rate_lvl += 1; cfg.popcorn_types[0] = t0; }
		}
	}
	if (point_in_rectangle(mx, my, col_w * 2 + 14, 54, col_w * 2 + btn_w + 14, 54 + btn_h))
	{
		var t1 = cfg.popcorn_types[1];
		if (!t1.unlocked && money >= 140) { money -= 140; t1.unlocked = true; cfg.popcorn_types[1] = t1; }
		else if (t1.unlocked)
		{
			var c1 = floor(t1.spawn_rate_cost * power(1.34, t1.spawn_rate_lvl));
			if (money >= c1) { money -= c1; t1.spawn_rate_lvl += 1; cfg.popcorn_types[1] = t1; }
		}
	}
	if (point_in_rectangle(mx, my, col_w * 2 + 14, 90, col_w * 2 + btn_w + 14, 90 + btn_h))
	{
		var t2 = cfg.popcorn_types[2];
		if (!t2.unlocked && money >= 300) { money -= 300; t2.unlocked = true; cfg.popcorn_types[2] = t2; }
		else if (t2.unlocked)
		{
			var c2 = floor(t2.spawn_rate_cost * power(1.34, t2.spawn_rate_lvl));
			if (money >= c2) { money -= c2; t2.spawn_rate_lvl += 1; cfg.popcorn_types[2] = t2; }
		}
	}

	if (point_in_rectangle(mx, my, col_w * 3 + 14, 18, col_w * 3 + btn_w + 14, 18 + btn_h))
	{
		show_prestige_window = !show_prestige_window;
	}

	if (point_in_rectangle(mx, my, col_w * 3 + 14, 54, col_w * 3 + btn_w + 14, 54 + btn_h))
	{
		if (prestige_bank >= cfg.prestige.need_points)
		{
			prestige_points += prestige_bank;
			prestige_bank = 0;
			money = 0;
			temp_level = 0;
			temp_current = cfg.temperature.start;
			kernels = [];
			popcorns = [];
			items = [];
			for (var pi = 0; pi < array_length(cfg.popcorn_types); pi++)
			{
				var ptt = cfg.popcorn_types[pi];
				ptt.unlocked = (pi == 0);
				ptt.spawn_rate_lvl = 0;
				cfg.popcorn_types[pi] = ptt;
			}
		}
	}

	if (show_prestige_window)
	{
		var sx = room_width * 0.5 - 290;
		var sy = room_height * 0.5 - 180;
		for (var up = 0; up < array_length(prestige_upgrades); up++)
		{
			var col = up mod 3;
			var row = up div 3;
			var rx1 = sx + col * 190;
			var ry1 = sy + row * 90;
			var rx2 = rx1 + 160;
			var ry2 = ry1 + 64;
			if (point_in_rectangle(mx, my, rx1, ry1, rx2, ry2))
			{
				var ug = prestige_upgrades[up];
				if (ug.level < ug.max_level && prestige_points >= ug.cost)
				{
					prestige_points -= ug.cost;
					ug.level += 1;
					prestige_upgrades[up] = ug;
					switch (ug.id)
					{
						case "max_temp": max_temperature += 15; break;
						case "unlock_items":
							for (var di = 0; di < array_length(cfg.items); di++)
							{
								var idf = cfg.items[di];
								if (!idf.unlocked)
								{
									idf.unlocked = true;
									cfg.items[di] = idf;
									break;
								}
							}
						break;
						case "item_radius": item_radius_mult += 0.08; break;
						case "item_power": item_power_mult += 0.08; break;
						case "special_rate": special_chance_bonus += 0.015; break;
						case "collect_radius": collect_radius_bonus += 8; break;
						case "hand_rate": hand_rate_mult += 0.12; break;
						case "hand_profit": hand_profit_mult += 0.25; break;
						case "profit_all": profit_mult += 0.2; break;
					}
					if (ug.id == "hand_rate" || ug.id == "hand_profit") hands_unlocked = true;
				}
			}
		}
	}

	for (var ii = array_length(items) - 1; ii >= 0; ii--)
	{
		var it = items[ii];
		if (point_in_rectangle(mx, my, it.x - 30, it.y - 30, it.x + 30, it.y + 30))
		{
			drag_item_uid = it.uid;
			drag_dx = it.x - mx;
			drag_dy = it.y - my;
			var def_h = _item_def(it.item_id);
			if (def_h.hold_to_work)
			{
				active_item_uid = it.uid;
			}
			break;
		}
	}
}

if mouse_check_button_released(mb_left)
{
	drag_item_uid = -1;
	active_item_uid = -1;
}

var collect_radius = cfg.kernels.collect_radius_start + collect_radius_bonus;
for (var i = array_length(popcorns) - 1; i >= 0; i--)
{
	var pp = popcorns[i];
	if (!pp.collected && point_distance(mx, my, pp.x, pp.y - pp.z) <= collect_radius)
	{
		pp.collected = true;
		pp.collect_timer = 16;
		if (pp.special)
		{
			prestige_bank += 1;
		}
		else
		{
			money += ceil(pp.value * profit_mult);
			part_particles_create(ps_table, pp.x, pp.y - pp.z - 6, pt_money, 18);
		}
		popcorns[i] = pp;
	}
}

for (var h = array_length(hands) - 1; h >= 0; h--)
{
	var hand = hands[h];
	hand.t += 1 / max(1, hand.dur);
	var tt = clamp(hand.t, 0, 1);
	hand.x = lerp(hand.sx, hand.tx, tt);
	hand.y = lerp(hand.sy, hand.ty, tt);
	if (!hand.done && tt >= 0.55)
	{
		for (var pi = array_length(popcorns) - 1; pi >= 0; pi--)
		{
			var pk = popcorns[pi];
			if (!pk.collected && point_distance(hand.tx, hand.ty, pk.x, pk.y) < 40)
			{
				pk.collected = true;
				pk.collect_timer = 2;
				popcorns[pi] = pk;
				money += ceil(pk.value * cfg.prestige.hand_profit_mult * hand_profit_mult);
				part_particles_create(ps_table, pk.x, pk.y - 4, pt_money, 8);
				hand.done = true;
				break;
			}
		}
	}
	if (tt >= 1)
	{
		array_delete(hands, h, 1);
		continue;
	}
	hands[h] = hand;
}

if (hands_unlocked)
{
	hand_spawn_timer -= 1;
	if (hand_spawn_timer <= 0)
	{
		hand_spawn_timer = max(room_speed * 1.4, cfg.prestige.hand_spawn_base / hand_rate_mult);
		if (array_length(popcorns) > 0)
		{
			var target = popcorns[irandom(array_length(popcorns) - 1)];
			var from_left = irandom(1) == 0;
			array_push(hands, {
				sx: from_left ? -40 : room_width + 40,
				sy: random_range(table_top + 40, table_bottom - 40),
				tx: target.x,
				ty: target.y,
				x: 0,
				y: 0,
				t: 0,
				dur: room_speed * 1.4,
				done: false
			});
		}
	}
}

for (var it_i = 0; it_i < array_length(items); it_i++)
{
	var it2 = items[it_i];
	var def2 = _item_def(it2.item_id);
	if (drag_item_uid == it2.uid)
	{
		it2.x = clamp(mx + drag_dx, table_left + 20, table_right - 20);
		it2.y = clamp(my + drag_dy, table_top + 20, table_bottom - 20);
	}
	if (def2.hold_to_work)
	{
		var target_alpha = (active_item_uid == it2.uid && mouse_down) ? 1 : 0;
		it2.hold_alpha = lerp(it2.hold_alpha, target_alpha, 0.2);
		it2.active = it2.hold_alpha > 0.2;
	}
	it2.radius_pulse += 0.05;
	items[it_i] = it2;
}

for (var ki = array_length(kernels) - 1; ki >= 0; ki--)
{
	var k = kernels[ki];

	k.z += k.vz;
	k.vz -= k.gravity;
	k.x += k.vx;
	k.y += k.vy;
	k.vx *= 0.992;
	k.vy *= 0.992;

	if (k.x < table_left + 10 || k.x > table_right - 10)
	{
		k.vx *= -0.5;
		k.x = clamp(k.x, table_left + 10, table_right - 10);
	}
	if (k.y < table_top + 10 || k.y > table_bottom - 10)
	{
		k.vy *= -0.5;
		k.y = clamp(k.y, table_top + 10, table_bottom - 10);
	}

	if (k.z <= 0)
	{
		k.z = 0;
		if (abs(k.vz) > 0.55)
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

	if (k.landed)
	{
		var heat = cfg.temperature.base_power + temp_current * cfg.temperature.power_per_degree;
		for (var ii2 = 0; ii2 < array_length(items); ii2++)
		{
			var obj = items[ii2];
			if (!obj.active) continue;
			var ddef = _item_def(obj.item_id);
			var rr = ddef.radius * item_radius_mult;
			if (point_distance(k.x, k.y, obj.x, obj.y) <= rr)
			{
				heat += ddef.power * item_power_mult;
				if (obj.item_id == "sun") part_particles_create(ps_table, obj.x + random_range(-5, 5), obj.y - 8, pt_special, 1);
			}
		}
		k.cook_progress += heat / room_speed;
		if (k.special) part_particles_create(ps_table, k.x + random_range(-2, 2), k.y - 6 + random_range(-2, 2), pt_special, 1);
		if (k.cook_progress >= k.cook_need)
		{
			array_push(popcorns, {
				x: k.x,
				y: k.y,
				z: 0,
				vx: random_range(-0.5, 0.5),
				vy: random_range(-0.5, 0.5),
				vz: random_range(4.6, 6.6),
				gravity: random_range(0.24, 0.33),
				image_angle: random(360),
				spin: random_range(-9, 9),
				hit_r: 34,
				burst_timer: 18,
				landed: false,
				collected: false,
				collect_timer: 0,
				value: k.value,
				special: k.special
			});
			part_particles_create(ps_table, k.x, k.y - 4, pt_pop_burst, irandom_range(30, 42));
			array_delete(kernels, ki, 1);
			continue;
		}
	}

	kernels[ki] = k;
}

for (var j = array_length(popcorns) - 1; j >= 0; j--)
{
	var pp2 = popcorns[j];

	if (!pp2.collected)
	{
		pp2.z += pp2.vz;
		pp2.vz -= pp2.gravity;
		pp2.x += pp2.vx;
		pp2.y += pp2.vy;
		pp2.vx *= 0.985;
		pp2.vy *= 0.985;
		pp2.image_angle += pp2.spin;
		pp2.spin *= 0.985;

		if (pp2.x < table_left + 12 || pp2.x > table_right - 12)
		{
			pp2.vx *= -0.45;
			pp2.x = clamp(pp2.x, table_left + 12, table_right - 12);
		}
		if (pp2.y < table_top + 12 || pp2.y > table_bottom - 12)
		{
			pp2.vy *= -0.45;
			pp2.y = clamp(pp2.y, table_top + 12, table_bottom - 12);
		}

		if (pp2.z <= 0)
		{
			pp2.z = 0;
			if (abs(pp2.vz) > 1.2)
			{
				pp2.vz = -pp2.vz * random_range(0.24, 0.36);
				pp2.vx *= 0.7;
				pp2.vy *= 0.7;
				part_particles_create(ps_table, pp2.x, pp2.y, pt_seed_hit, irandom_range(2, 4));
			}
			else
			{
				pp2.vz = 0;
				pp2.landed = true;
			}
		}
	}

	if (pp2.burst_timer > 0) pp2.burst_timer -= 1;
	if (pp2.collect_timer > 0)
	{
		pp2.collect_timer -= 1;
		pp2.z += 0.8;
	}
	if (pp2.collected && pp2.collect_timer <= 0)
	{
		array_delete(popcorns, j, 1);
		continue;
	}

	popcorns[j] = pp2;
}
