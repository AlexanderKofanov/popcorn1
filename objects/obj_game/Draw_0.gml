var cam_x = camera_get_view_x(view_camera);
var cam_y = camera_get_view_y(view_camera);
var cam_w = camera_get_view_width(view_camera);
var cam_h = camera_get_view_height(view_camera);

var bg_c1 = make_color_rgb(48, 37, 28);
var bg_c2 = make_color_rgb(92, 66, 42);
draw_rectangle_color(cam_x, cam_y, cam_x + cam_w, cam_y + cam_h, bg_c1, bg_c2, bg_c1, bg_c2, false);

// Стол отдельным спрайтом 1:1
draw_sprite(spr_table, 0, room_width * 0.5, room_height * 0.5);

// Общий список объектов на столе. Эквивалент depth = -y.
var draw_items = [];
for (var i = 0; i < array_length(kernels); i++)
{
	var k = kernels[i];
	array_push(draw_items, { kind: 0, y: k.y, idx: i });
}
for (var j = 0; j < array_length(popcorns); j++)
{
	var p = popcorns[j];
	array_push(draw_items, { kind: 1, y: p.y, idx: j });
}
array_push(draw_items, { kind: 2, y: candle_y, idx: -1 });

array_sort(draw_items, function(a, b) { return a.y - b.y; });

for (var d = 0; d < array_length(draw_items); d++)
{
	var item = draw_items[d];
	switch (item.kind)
	{
		case 0:
			var k = kernels[item.idx];
			draw_set_alpha(0.2);
			draw_sprite_ext(spr_shine, 0, k.x, k.y + 4, 0.08, 0.03, 0, c_black, 1);
			draw_set_alpha(1);
			draw_sprite_ext(spr_seed, 0, k.x, k.y - k.z, 1, 1, k.image_angle, c_white, 1);
		break;

		case 1:
			var p = popcorns[item.idx];
			var burst_k = 1 + p.burst_timer / 24;
			var alpha = p.collected ? p.collect_timer / 16 : 1;
			draw_set_alpha(alpha * 0.22);
			draw_sprite_ext(spr_shine, 0, p.x, p.y + 8, 0.15 * burst_k, 0.05 * burst_k, 0, c_black, 1);
			draw_set_alpha(alpha);
			draw_sprite_ext(spr_popcorn, 0, p.x, p.y - p.z, burst_k, burst_k, p.image_angle, c_white, 1);
			draw_set_alpha(1);
		break;

		case 2:
			draw_set_alpha(0.24);
			draw_sprite_ext(spr_shine, 0, candle_x, candle_y + 14, 0.2, 0.07, 0, c_black, 1);
			draw_set_alpha(1);
			draw_sprite(spr_candle, 0, candle_x, candle_y);

			var flame_x = candle_x;
			var flame_y = candle_y - candle_half_h * 0.75;
			var flicker = 1 + sin(current_time * 0.02) * 0.08;
			gpu_set_blendmode(bm_add);
			draw_sprite_ext(spr_shine, 0, flame_x, flame_y, 0.24 * flicker, 0.24 * flicker, 0, make_color_rgb(255, 169, 80), 0.65);
			draw_sprite_ext(spr_shine, 0, flame_x, flame_y, 0.12 * flicker, 0.12 * flicker, 0, make_color_rgb(255, 238, 170), 0.9);
			gpu_set_blendmode(bm_normal);
		break;
	}
}

// HUD: только доллары сверху по центру
draw_set_halign(fa_center);
draw_set_valign(fa_top);
draw_set_color(c_white);
draw_text(room_width * 0.5, 32, "$" + string(score));
