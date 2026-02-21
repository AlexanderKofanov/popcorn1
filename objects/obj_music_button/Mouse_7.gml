if !pressed exit
if obs.music = 1
{
	obs.music = 0
	on = false
	audio_stop_sound(music_main)
}
else
{
	obs.music = 1
	on = true
	audio_play_sound(music_main, 1, 1)
}

ini_open("game")
ini_write_real("settings", "music", obs.music)
ini_close()
alarm[0] = 1