application_surface_enable(false)
randomize()

//window_set_size(400, 1000)

draw_set_valign(fa_middle)
draw_set_halign(fa_center)
draw_set_font(font_text)
room_w = 1920
room_h = 1080
alarm[0] = 1
alpha = 1

if !file_exists("game") 
{
	language = os_get_language()
	ini_open("game")
	ini_write_string("settings", "language", language)
	ini_close()
}
ini_open("game")
language = ini_read_string("settings", "language", "en")
highscore = ini_read_real("settings", "highscore", 0)
music = ini_read_real("settings", "music", 1)
soun = ini_read_real("settings", "sound", 1)
level = ini_read_real("settings", "level", room_level1)
lang()
ini_close()

//if music
//	audio_play_sound(music_main, 1, 1);