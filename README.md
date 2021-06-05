# Fick's 2nd Law
This project is describing a few various methods for solutions to the Wave Equation that can model Fick's 2nd Law of Diffusion and the Heat Equation. Finding code for solving generic forms of these problems has been difficult, so I am making this project for this reason.

∂C/∂t=D∇^2 C

The equation is a 2nd Order, nonlinear partial differential equation. Three approaches are compared.  An exact analytical solution, a finite difference approach, and solution using a convolution kernel.

# Exact Analytical Approach. kwave_diff.m
This approach uses k-Wave bioHeatExact() function to solve the wave equation for oxygen diffusion in water.  The concept is to simulate oxygen diffusion from a Perfluorocarbon microdroplet, though this is a bit simplified generalize the method.  The solution is described in detail here.

Initial Condition.  Single droplet with radius of 1 micrometer that is saturated with oxygen.

![image](https://user-images.githubusercontent.com/53169576/120907106-3e0a7e80-c65f-11eb-991f-0f8fc36d07af.png)

This image illustrates the results of the simulation after various diffusion times. 
![kwave_diffusion_radial](https://user-images.githubusercontent.com/53169576/120907005-38606900-c65e-11eb-8bf6-6b533309aed1.png)


