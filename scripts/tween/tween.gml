/// @description tween(ease,time,start,change,duration,ext(opt))
/// @param ease
/// @param time
/// @param start
/// @param change
/// @param duration
/// @param ext(opt
function tween() {

	var ease, time, start, eend, duration, t

	ease = argument0
	time = argument1
	start = argument2
	eend = argument3
	duration = argument4

	switch(argument_count)
	{
	    case 6:
	        var s  = argument5
	        t = script_execute(ease,time,start,eend,duration,s)
	    break
	    default:
	        t = script_execute(ease,time,start,eend,duration)
	    break
	}

	return t
}
