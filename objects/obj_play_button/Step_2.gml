if go
{
	text_scale = tween(ease_outcub, text_scale_time, 0, 1, 50)
	if !go_after
	{
		if text_scale_time < 50
			text_scale_time++
		if text_scale_time = 50
			go_after = true
	}
	if go_after
	{
		if text_scale_time > 30
			text_scale_time--
		if text_scale_time = 30
			go_after = false
	}
}