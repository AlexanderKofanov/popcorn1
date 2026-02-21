function ease_inbounce(argument0, argument1, argument2, argument3) {
	var t,b,e,d;

	t = argument0;
	b = argument1;
	e = argument2;
	d = argument3;

	c = e-b;

	return c-ease_outbounce(d-t,0,c,d)+b;


}
