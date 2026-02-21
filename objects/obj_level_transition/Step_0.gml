if !ded
{
	time++
	alpha += 0.1
	if time = 11
	{
		room_goto(r)
		ded = true
	}
}

if ded
{
	time--
	alpha -= 0.1
	if time <= 0
		instance_destroy()
}