var cam_x = camera_get_view_x(view_camera);
var cam_y = camera_get_view_y(view_camera);
var cam_w = camera_get_view_width(view_camera);
var cam_h = camera_get_view_height(view_camera);

var bg_c1 = make_color_rgb(48, 37, 28);
var bg_c2 = make_color_rgb(92, 66, 42);
draw_rectangle_color(cam_x, cam_y, cam_x + cam_w, cam_y + cam_h, bg_c1, bg_c2, bg_c1, bg_c2, false);

draw_sprite(spr_table, 0, room_width * 0.5, room_height * 0.5);

// Панель управления сверху
draw_set_alpha(0.88);
draw_set_color(make_color_rgb(28, 20, 15));
draw_roundrect(8, 8, room_width - 8, panel_h, false);
draw_set_alpha(1);

var col_w = room_width / 4;
for (var c = 1; c < 4; c++)
{
	draw_set_alpha(0.3);
	draw_line_width(col_w * c, 16, col_w * c, panel_h - 8, 2);
	draw_set_alpha(1);
}

var temp_ratio = (temp_current - cfg.temperature.start) / max(1, max_temperature - cfg.temperature.start);
var dial_x = col_w * 0.5;
var dial_y = 65;
draw_set_alpha(0.7);
draw_set_color(make_color_rgb(55, 55, 55));
draw_circle(dial_x, dial_y, 38, false);
draw_set_alpha(0.25);
draw_circle(dial_x, dial_y, 30, false);
draw_set_alpha(1);
var ang = lerp(-130, 130, clamp(temp_ratio, 0, 1));
draw_set_color(make_color_rgb(255, 172, 96));
draw_line_width(dial_x, dial_y, dial_x + lengthdir_x(30, ang), dial_y + lengthdir_y(30, ang), 4);

var temp_cost = floor(cfg.temperature.cost_base * power(cfg.temperature.cost_growth, temp_level));
draw_set_color(make_color_rgb(87, 130, 72));
draw_roundrect(col_w * 0 + 14, 18, col_w * 0 + btn_w + 14, 18 + btn_h, false);
draw_set_color(c_white);
draw_text(col_w * 0 + 20, 24, "TEMP +  ($" + string(temp_cost) + ")");

// Предметы
var item_rows = ["matches", "candle", "lighter"];
for (var i = 0; i < 3; i++)
{
	var item_key = item_rows[i];
	var can = false;
	var cost = 0;
	for (var k = 0; k < array_length(cfg.items); k++)
	{
		if (cfg.items[k].id == item_key)
		{
			can = cfg.items[k].unlocked;
			cost = cfg.items[k].cost;
		}
	}
	draw_set_color(can ? make_color_rgb(93, 97, 150) : make_color_rgb(50, 50, 60));
	draw_roundrect(col_w * 1 + 14, 18 + i * 36, col_w * 1 + btn_w + 14, 18 + i * 36 + btn_h, false);
	draw_set_color(c_white);
	draw_text(col_w * 1 + 20, 24 + i * 36, item_key + "  $" + string(cost));
}

// Попкорн типы
for (var p = 0; p < 3; p++)
{
	var tp = cfg.popcorn_types[p];
	var by = 18 + p * 36;
	draw_set_color(tp.unlocked ? make_color_rgb(145, 101, 67) : make_color_rgb(60, 45, 38));
	draw_roundrect(col_w * 2 + 14, by, col_w * 2 + btn_w + 14, by + btn_h, false);
	draw_set_color(c_white);
	if (tp.unlocked)
	{
		var up_cost = floor(tp.spawn_rate_cost * power(1.34, tp.spawn_rate_lvl));
		draw_text(col_w * 2 + 20, by + 6, tp.name + " UP $" + string(up_cost));
	}
	else
	{
		draw_text(col_w * 2 + 20, by + 6, tp.name + " BUY");
	}
}

// Престиж
var can_prestige = prestige_bank >= cfg.prestige.need_points;
draw_set_color(make_color_rgb(83, 70, 112));
draw_roundrect(col_w * 3 + 14, 18, col_w * 3 + btn_w + 14, 18 + btn_h, false);
draw_set_color(c_white);
draw_text(col_w * 3 + 20, 24, "PRESTIGE TREE");
draw_set_color(can_prestige ? make_color_rgb(82, 145, 90) : make_color_rgb(70, 80, 70));
draw_roundrect(col_w * 3 + 14, 54, col_w * 3 + btn_w + 14, 54 + btn_h, false);
draw_set_color(c_white);
draw_text(col_w * 3 + 20, 60, "RESET (" + string(prestige_bank) + ")");

// Объекты с сортировкой depth = -y
var draw_items = [];
for (var i2 = 0; i2 < array_length(kernels); i2++)
{
	array_push(draw_items, { kind: 0, y: kernels[i2].y, idx: i2 });
}
for (var j = 0; j < array_length(popcorns); j++)
{
	array_push(draw_items, { kind: 1, y: popcorns[j].y, idx: j });
}
for (var ii = 0; ii < array_length(items); ii++)
{
	array_push(draw_items, { kind: 2, y: items[ii].y, idx: ii });
}

array_sort(draw_items, function(a, b) { return a.y - b.y; });

for (var d = 0; d < array_length(draw_items); d++)
{
	var item = draw_items[d];
	switch (item.kind)
	{
		case 0:
			var kx = kernels[item.idx];
			draw_set_alpha(0.2);
			draw_sprite_ext(spr_shine, 0, kx.x, kx.y + 4, 0.08, 0.03, 0, c_black, 1);
			draw_set_alpha(1);
			var tint = kx.special ? make_color_rgb(174, 225, 255) : c_white;
			draw_sprite_ext(spr_seed, 0, kx.x, kx.y - kx.z, 1, 1, kx.image_angle, tint, 1);
		break;

		case 1:
			var p2 = popcorns[item.idx];
			var burst_k = 1 + p2.burst_timer / 24;
			var alpha = p2.collected ? p2.collect_timer / 16 : 1;
			draw_set_alpha(alpha * 0.22);
			draw_sprite_ext(spr_shine, 0, p2.x, p2.y + 8, 0.15 * burst_k, 0.05 * burst_k, 0, c_black, 1);
			draw_set_alpha(alpha);
			var tint2 = p2.special ? make_color_rgb(180, 235, 255) : c_white;
			draw_sprite_ext(spr_popcorn, 0, p2.x, p2.y - p2.z, burst_k, burst_k, p2.image_angle, tint2, 1);
			draw_set_alpha(1);
		break;

		case 2:
			var it = items[item.idx];
			var def = cfg.items[0];
			for (var fd = 0; fd < array_length(cfg.items); fd++) if (cfg.items[fd].id == it.item_id) def = cfg.items[fd];
			if (it.active)
			{
				var rr = def.radius * item_radius_mult;
				var pulse = 1 + sin(it.radius_pulse) * 0.06;
				draw_set_alpha(0.09 + 0.05 * pulse);
				draw_set_color(make_color_rgb(255, 180, 80));
				draw_circle(it.x, it.y, rr * pulse, false);
				draw_set_alpha(1);
			}
			draw_set_alpha(0.25);
			draw_sprite_ext(spr_shine, 0, it.x, it.y + 12, 0.15, 0.05, 0, c_black, 1);
			draw_set_alpha(0.7 + 0.3 * it.hold_alpha);
			draw_sprite_ext(spr_candle, 0, it.x, it.y, 0.85, 0.85, 0, c_white, 1);
			draw_set_alpha(1);
			if (it.active)
			{
				gpu_set_blendmode(bm_add);
				draw_sprite_ext(spr_shine, 0, it.x, it.y - 18, 0.18, 0.18, 0, make_color_rgb(255, 170, 90), 0.65);
				gpu_set_blendmode(bm_normal);
				part_particles_create(ps_table, it.x + random_range(-2, 2), it.y - 20, pt_flame, 1);
			}
		break;
	}
}

for (var hh = 0; hh < array_length(hands); hh++)
{
	var hand = hands[hh];
	draw_set_alpha(0.85);
	draw_set_color(make_color_rgb(235, 198, 162));
	draw_roundrect(hand.x - 20, hand.y - 12, hand.x + 20, hand.y + 12, false);
	draw_set_alpha(1);
}

if (show_prestige_window)
{
	var sx = room_width * 0.5 - 310;
	var sy = room_height * 0.5 - 210;
	draw_set_alpha(0.9);
	draw_set_color(make_color_rgb(18, 16, 28));
	draw_roundrect(sx, sy, sx + 620, sy + 420, false);
	draw_set_alpha(1);
	draw_set_color(c_white);
	draw_text(sx + 18, sy + 12, "Prestige points: " + string(prestige_points));
	for (var up = 0; up < array_length(prestige_upgrades); up++)
	{
		var ug = prestige_upgrades[up];
		var col = up mod 3;
		var row = up div 3;
		var bx = sx + 20 + col * 190;
		var by = sy + 50 + row * 90;
		draw_set_alpha(0.25);
		if (col > 0) draw_line_width(bx - 30, by + 24, bx, by + 24, 2);
		if (row > 0) draw_line_width(bx + 78, by - 30, bx + 78, by, 2);
		draw_set_alpha(1);
		draw_set_color(ug.level < ug.max_level ? make_color_rgb(86, 98, 144) : make_color_rgb(58, 58, 58));
		draw_roundrect(bx, by, bx + 160, by + 64, false);
		draw_set_color(c_white);
		draw_text(bx + 8, by + 8, ug.id);
		draw_text(bx + 8, by + 30, "Lv " + string(ug.level) + " / " + string(ug.max_level) + "  -" + string(ug.cost) + "P");
	}
}

// HUD: только доллары сверху по центру
draw_set_halign(fa_center);
draw_set_valign(fa_top);
draw_set_color(c_white);
draw_text(room_width * 0.5, 8, "$" + string(money));
draw_set_halign(fa_left);
