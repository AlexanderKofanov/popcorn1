function ease_outcub(argument0, argument1, argument2, argument3) {
	var t,b,e,d;

	t = argument0;
	b = argument1;
	e = argument2;
	d = argument3;

	c = e-b;
	t=t/d-1
	return c*(t*t*t+1)+b


}
