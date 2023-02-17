/*****************************************************************************
 * Module 'algbrcurves.asy'
 *
 * algebraic curves
 *
 * path arc(real, real)
 * path parabola(real, real)
 * path catenary(real, real)
 * path hyperbola(real, real, real)
 *
 * Authors: ARAI Kohei
 * Version: 0.0
 *****************************************************************************/

/*************************************************************
 * Function 'arc'
 *
 *
 *
 * Returns:
 *  single path (0 ≤ t ≤ 1)
 *
 * Params:
 *  r= radius
 *  alpha= center angle in radians
 *************************************************************/
path arc(real r, real alpha){
	real beta= (pi-alpha)/2;
	real len= 4.0*(2*cos(alpha/2)-cos(alpha)-1.0)/(3.0*sin(alpha))*r;
	pair[] p= new pair[4];

	p[0]= r*(cos(beta), sin(beta));
	p[1]= p[0]+len*unit((-sin(beta), cos(beta)));
	p[2]= (-p[1].x, p[1].y);
	p[3]= (-p[0].x, p[0].y);

	return p[0]..controls p[1] and p[2]..p[3];
}

/*************************************************************
 * Function 'parabola'
 *
 * y= a*x^2
 *
 * Returns:
 *  single path (0 ≤ t ≤ 1)
 *
 * Params:
 *  a= coefficient
 *  hwid= half width of x-range
 *************************************************************/
path parabola(real a, real hwid){
	pair[] p= new pair[4];
	p[0]= (-hwid, a*hwid^2);
	p[1]= (-hwid, -p[0].y)/3;
	p[2]= (-p[1].x, p[1].y);
	p[3]= (-p[0].x, p[0].y);

	return p[0]..controls p[1] and p[2]..p[3];
}

/*************************************************************
 * Function 'catenary'
 *
 * y= a*cosh(x/a)
 *
 * Returns:
 *  single path (0 ≤ t ≤ 1)
 *
 *
 * Params:
 *  a= coefficient
 *  hwid= half width of x-range
 *************************************************************/
path catenary(real a, real hwid){
	real b= -a;
	pair[] p= new pair[4];
	p[0]= (-hwid, a*cosh(-hwid/a)+b);
	p[1]= (4*(a+b-p[0].y)/(3*sinh(-hwid/a))-hwid,
		(4*(a+b)-p[0].y)/3);
	p[2]= (-p[1].x, p[1].y);
	p[3]= (-p[0].x, p[0].y);

	return p[0]..controls p[1] and p[2]..p[3];
}

/*************************************************************
 * Function 'hyperbola'
 *
 * (x/a)^2 -(y/b)^2= -1
 *
 * y= b*sqrt((x/a)^2+1)
 *
 * Returns:
 *  single path (0 ≤ t ≤ 1)
 *
 * Params:
 *
 *************************************************************/
path hyperbola(real a, real b, real hwid){
	pair[] p= new pair[4];

	p[0]= (-hwid, sqrt(hwid^2+1));
	p[1]= (
		4*a^2/(3b) *((b-p[0].y)*sqrt(hwid^2+1))/p[0].x +p[0].x,
		4b-p[0].y
	)/3;
	p[2]= (-p[1].x, p[1].y);
	p[3]= (-p[0].x, p[0].y);

	return shift(0, -b)*(p[0]..controls p[1] and p[2]..p[3]);
}
