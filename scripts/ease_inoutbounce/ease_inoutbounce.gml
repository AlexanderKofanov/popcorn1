function ease_inoutbounce(argument0, argument1, argument2, argument3) {
	var t,b,e,d;

	t = argument0;
	b = argument1;
	e = argument2;
	d = argument3;

	c = e-b;

	if(t<d/2) return ease_inbounce(t*2,0,c,d)*0.5+b;
	    return ease_outbounce(t*2-d,0,c,d)*0.5+c*0.5+b;


}
