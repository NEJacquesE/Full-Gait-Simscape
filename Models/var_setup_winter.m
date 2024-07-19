%% Model Set Up Variables
clc;clear;
%Body
L = 1.6;
M = 56.7;
d = .025;

%Thigh
T_L = 0.246*L;
T_M = 0.1*M;
T_c_g = 0.5*T_L - 0.433*T_L;
T_I = T_M * (0.323*T_L)^2;

%Shank
S_L = 0.246*L;
S_M = 0.0465*M;
S_c_g = 0.5*S_L - 0.433*S_L;
S_I = S_M * (0.302*S_L)^2;

%pros. knee variables
ab = 0.1603; ac = 0.0247;
bc_o = sqrt(ab^2+ac^2);
k_knee = 14116; c_knee = 1415.05; mass_knee = 1.14;
k_c_g = ab/2-0.062975;
p_k_i = 0.00251656;

shank_L = 26.47e-2;
stud_L = S_L-ab;
stud_M = 0.25; %stud_L*0.105/(127e-3); %105 ref for weight at 127mm %For 5mm thick alum tube mass ~= 0.25kg

%Ideal model Shank
I_S_L = 0.246*L;
I_S_M = mass_knee + stud_M;
I_S_c_g = 0.5*I_S_L - 0.433*I_S_L;
I_S_I = I_S_M * (0.323*I_S_L)^2;

%Foot
F_L = 0.152*L;
F_M = 0.0145*M;
F_c_g = 0.5*F_L - 0.5*F_L;
F_I = F_M * (0.475*F_L)^2;

P_foot_M =0.960;

%Floor
floor = 0.530*L;
k_floor = 1.5e4;
c_floor = 1500;


%For optimization of standalone knee
k_opt = 7.929794549614810e+03;% 9.301267342693307e+03; 
c_opt = 3.204631753188825e+03;%3.545384165287931e+03;


%Hip torque optimization
%k_h = 10;c_h = 10;


%Loading ideal torques
idt = load('ideal_prosthetic_torques.mat');
ideal_hip_torques = idt.ans.data(:,1);
ideal_knee_torques = idt.ans.data(:,2);

%trajectories gains

%hat segment
k_hat = rand(1);
c_hat = rand(1);

%right leg
k_hip_r = rand(1);
c_hip_r = rand(1);
k_knee_r = rand(1);
c_knee_r = rand(1);
k_ankle_r = rand(1);
c_ankle_r = rand(1);

%left leg
k_hip_l = rand(1);
c_hip_l = rand(1);
k_knee_l = rand(1);
c_knee_l = rand(1);
k_ankle_l = rand(1);
c_ankle_l = rand(1);

%same vars for both legs hat_3_1
k_ankle = rand(1);
c_ankle = rand(1);
k_hip = rand(1);
c_hip = rand(1);
k_knee = rand(1);
c_knee = rand(1);