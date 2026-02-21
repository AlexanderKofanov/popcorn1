if !pressed exit
if obs.soun = 1
{
	obs.soun  = 0
	on = false
}
else
{
	obs.soun = 1
	on = true
}

ini_open("game")
ini_write_real("settings", "sound", obs.soun)
ini_close()
alarm[0] = 1