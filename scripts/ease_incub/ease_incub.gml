function ease_incub(argument0, argument1, argument2, argument3) {
	var t, b, e, d;

	t = argument0;
	b = argument1;
	e = argument2;
	d = argument3;

	c = e - b;

	t /= d;
	return c * t * t * t + b;


}
