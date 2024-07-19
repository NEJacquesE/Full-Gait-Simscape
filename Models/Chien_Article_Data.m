%Displacement from Chien's article

%% Load data from xlsx file
load('C:\Users\nejac\Google Drive\SU21_Collaboration\Swing_phase_project\kinematic_data\winterKinematics.mat');

%end of swing phase index 27
stride_begining = 1;
swing_end = 106;
t = t(stride_begining:swing_end);
t_0 = t(1);
t_f = t(end); %for swing only 27
dt = t(2)-t(1);
winter_theta = winter_theta(:,stride_begining:swing_end);
%knee
winter_theta_c(2,:) = -winter_theta(2,:)+winter_theta(3,:);


figure;plot(t,winter_theta_c(2,:));

%% Piston displacement
ac = 0.0247;
ab = 0.1603;

bc = sqrt(ac^2+ab^2-2*ac*ab*cosd(90-winter_theta_c(2,:)));
figure;plot(t,bc-bc_o);
