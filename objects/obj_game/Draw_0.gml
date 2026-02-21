var c1 = merge_color(color, c_black, 0.65);
var c2 = merge_color(color, c_black, 0.15);
var s = current_time / 200;

draw_rectangle_color(camera_get_view_x(view_camera), camera_get_view_y(view_camera), obs.camera_w, obs.camera_h, c2, c1, c2, c1, false);
draw_sprite_tiled_ext(spr_back_pattern, 0, 0 - s, 0 + s, 1, 1, 0, 0.12);

// Стол
draw_set_alpha(0.95);
draw_set_color(make_color_rgb(99, 62, 38));
draw_roundrect(table_left, table_top, table_right, table_bottom, false);
draw_set_alpha(1);

// Семечки
for (var i = 0; i < array_length(kernels); i++)
{
	var k = kernels[i];
	draw_set_color(make_color_rgb(245, 220, 140));
	draw_ellipse(k.x - k.r, k.y - k.r * 0.6, k.x + k.r, k.y + k.r * 0.6, false);
	draw_set_color(make_color_rgb(205, 170, 90));
	draw_line_width(k.x - k.r * 0.6, k.y, k.x + k.r * 0.6, k.y, 1.5);
}

// Попкорн
for (var j = 0; j < array_length(popcorns); j++)
{
	var p = popcorns[j];
	var burst_k = 1 + (p.burst_timer / 18);
	var rr = p.r * burst_k;
	var a = 1;
	if p.collected a = p.collect_timer / 15;
	draw_set_alpha(a);
	draw_set_color(make_color_rgb(255, 245, 225));
	draw_circle(p.x, p.y, rr, false);
	draw_set_color(make_color_rgb(255, 232, 180));
	draw_circle(p.x + lengthdir_x(rr * 0.35, p.wiggle), p.y + lengthdir_y(rr * 0.35, p.wiggle), rr * 0.55, false);
	draw_set_color(make_color_rgb(250, 220, 165));
	draw_circle(p.x + lengthdir_x(rr * 0.28, p.wiggle + 120), p.y + lengthdir_y(rr * 0.28, p.wiggle + 120), rr * 0.45, false);
	draw_set_alpha(1);
}

// Свечка
draw_set_color(make_color_rgb(248, 240, 210));
draw_roundrect(candle_x - candle_r * 0.6, candle_y - candle_r, candle_x + candle_r * 0.6, candle_y + candle_r, false);
draw_set_color(make_color_rgb(80, 65, 50));
draw_line_width(candle_x, candle_y - candle_r, candle_x, candle_y - candle_r - 12, 2);

draw_set_color(make_color_rgb(255, 184, 66));
draw_circle(candle_x, candle_y - candle_r - 14, flame_r * 0.55 + sin(current_time / 90) * 2, false);
draw_set_color(make_color_rgb(255, 245, 170));
draw_circle(candle_x, candle_y - candle_r - 14, flame_r * 0.3 + cos(current_time / 70) * 1.5, false);

// HUD
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);
draw_text(40, 34, "$ " + string(score));
draw_text(40, 76, "Перетаскивай свечку и поджигай семечки");
