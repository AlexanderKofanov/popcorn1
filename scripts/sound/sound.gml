/// @param id 
/// @param can_multiple 
/// @param need_random_pitch 
function sound(argument0, argument1, argument2) 
{
	if obs.soun = 0 exit
	var i = argument0
	if argument1 = false
	{
		if !audio_is_playing(i)
			audio_play_sound(i, 1, 0)
	}
	else
		audio_play_sound(i, 1, 0)
	if argument2 = true
		audio_sound_pitch(i, 0.9 + random(0.2))

}
