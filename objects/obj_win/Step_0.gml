if go
{
	scale = tween(ease_incub, time, 0, 1, 40)
	if time < 40
		time++
	image_angle += 0.2
	if text_shift_side
	{
		text_shift_time++
		if text_shift_time >= 60
			text_shift_side = false
	}
	else
	{
		text_shift_time--
		if text_shift_time <= 0
			text_shift_side = true
	}
	text_shift = tween(ease_inoutcub, text_shift_time, 0, 1, 60)
}	
