function ease_outbounce(argument0, argument1, argument2, argument3) {
	var t,b,e,d;

	t = argument0;
	b = argument1;
	e = argument2;
	d = argument3;

	c = e-b;

	t/=d;
	if(t < (1/2.75))
	    return c*(7.5625*t*t)+b;
	else if(t < (2/2.75))
	{
	    t-=(1.5/2.75);
	    return c*(7.5625*(t)*t+0.75)+b;
	}
	else if(t < (2.5/2.75))
	{
	    t-=(2.25/2.75);
	    return c*(7.5625*(t)*t+0.9375)+b;
	}
	else
	{
	    t-=(2.625/2.75);
	    return c*(7.5625*(t)*t+0.984375)+b;
	}


}
