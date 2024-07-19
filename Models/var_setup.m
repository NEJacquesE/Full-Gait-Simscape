%% Model Set Up Variables
% clc;clear;
%Body
L = 1.6;
M = 50;
d = .025;

%Thigh
T_L = 0.245*L;
T_M = 0.1*M;

%Shank
S_L = 0.285*L;
S_M = 0.0465*M;

%Foot
F_L = 0.152*L;
F_M = 0.0145*M;


%pros. knee variables
ab = 0.1603; ac = 0.0247;
bc_o = sqrt(ab^2+ac^2);
k_knee = 50e3; c_knee = 0.1;