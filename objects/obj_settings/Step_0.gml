shift = tween(ease_outbounce, shift_time, 0.6, 1, 30)

if ded
{
	alpha -= 0.1
	if alpha <= 0
	{
		instance_destroy()
		with obj_close_button instance_destroy()
		with obj_button_parent_settings instance_destroy()
	}
}
else
{
	if shift_time < 30 shift_time++
	if alpha < 1 alpha += 0.1
}