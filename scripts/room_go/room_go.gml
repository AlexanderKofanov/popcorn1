function room_go(argument0)
{
	if instance_exists(obj_level_transition) exit;
	var o = instance_create_depth(0, 0, depth, obj_level_transition);
	if room_exists(argument0)
		o.r = argument0
	else
		o.r = room_level1;
}