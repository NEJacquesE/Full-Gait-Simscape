%Force from Chien's article

%load piston displacement and velocity
x_pist = load('piston_pose.mat');
t_a = x_pist.ans.time;
x_pist = x_pist.ans.data-bc_o;
dx_pist = load('piston_vel.mat');
dx_pist = dx_pist.ans.data;

%Applying formula
f_a = -189.91;
F = c_knee.*dx_pist+k_knee.*x_pist+f_a;

plot(t_a,F);