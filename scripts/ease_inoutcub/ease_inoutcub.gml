function ease_inoutcub(argument0, argument1, argument2, argument3) {
	var t,b,e,d;

	t = argument0;
	b = argument1;
	e = argument2;
	d = argument3;

	c = e-b;

	t/=d/2;

	if(t < 1) return c/2*t*t*t+b;
	t-=2;
	return c/2*((t)*t*t+2)+b;


}
