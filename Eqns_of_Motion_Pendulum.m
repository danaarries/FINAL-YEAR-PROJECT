%% Obtaining Equations of Motion for Periodic Pendulum- in 2Dimensions
syms m a g theta(t)
eqn = m*a == -m*g*sin(theta); % according to Newtons Second Law  

syms r
eqn = subs(eqn,a,r*diff(theta,2));% pendulum with length r- angular acceleration times r is equal to mass*acceleration
eqn = isolate(eqn,diff(theta,2)); %equation for theta 'double dot'

syms omega_0
eqn = subs(eqn,g/r,omega_0^2); % omega_0=sqrt(g/r)


%% Linearising Equation-The equation of motion is nonlinear, so it is difficult to solve analytically. 
% Assume the angles are small and linearize the equation by using the
% Taylor expansion of sin(theta)
syms x
approx = taylor(sin(x),x,'Order',2);
approx = subs(approx,x,theta(t));
eqnLinear = subs(eqn,sin(theta(t)),approx);
syms theta_0 theta_t0


%% Solve Equation of Motion Analytically
theta_t = diff(theta);
cond = [theta(0) == theta_0, theta_t(0) == theta_t0];
assume(omega_0,'real'); %assume omega is real
thetaSol(t) = dsolve(eqnLinear,cond);

% Setting physical parameters
gValue = 9.81;
rValue = 0.5; %length in metres
omega_0Value = sqrt(gValue/rValue);

% Setting intial conditions
theta_0Value  = 0.1*pi; % Solution only valid for small angles.
theta_t0Value = 0;      % Initially at rest.

% Substitute the physical parameters and initial conditions into the general solution
vars   = [omega_0      theta_0      theta_t0];
values = [omega_0Value theta_0Value theta_t0Value];
thetaSolPlot = subs(thetaSol,vars,values);

% Equation solutions in each direction describing the motion of the pendulum
x_pos = sin(thetaSolPlot)
y_pos = -cos(thetaSolPlot)

