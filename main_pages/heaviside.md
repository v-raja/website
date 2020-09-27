When I did MIT's introductory Electrical Engineering course
([6.002](https://ocw.mit.edu/courses/electrical-engineering-and-computer-science/6-002-circuits-and-electronics-spring-2007/)),
everything made sense until the course touched on frequency analysis using the Laplace Transform. I could understand why
it was useful and how to apply it, but I found its "out of the blue" origin perplexing. My curiosity brought me to
Caltech's [EE44](https://www.youtube.com/playlist?list=PLc7Gz02Znph_HU1I9STgC4Nv0aG_jdb8Z) which used the Heaviside
operator to analyse first and second order systems, and then coherently explained how the Laplace Transform is a special
case of the Heaviside operator.

The Heaviside operator is a powerful and more general method than the Laplace Transform to analyse electrical systems,
but unfortunately Oliver Heaviside wasn't in the business of proving things and got into fights with those who were in
that business. Thus, people could never bring themselves to use the Heaviside operator even though it was a good method.

I couldn't find much information online relating to the Heaviside operator when going through the lectures so I typed up
notes of the course as I went through it.

[heaviside-1](https://drive.google.com/file/d/1BVm-XR6JOKqjw47pG57yZffvgtrNPvMB/view?usp=sharing) contains notes from
lectures 16 to 24 which explains:
- The assumptions we make when we analyze linear, time-invariant systems
- How the Heaviside operator comes about
- Examples of using the Heaviside operator
- The motivation to develop a catalog for the operator
- The derivation of the complete catalog through examples
- Time delay and how that's factored into equations that use the Heaviside operator

[heaviside-2](https://drive.google.com/file/d/100HG7fy54eDx_NDcvRPJb8_g6vgZvc_y/view?usp=sharing) contains notes from
lectures 25 to 27 which explains:
- What to do with initial conditions on a system
- How to analyse the frequency response of a system with the Heaviside operator and how the operator relates to the
Laplace Transform
