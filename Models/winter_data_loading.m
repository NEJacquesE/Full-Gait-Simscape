%% Load data from xlsx file
load('C:\Users\nejac\Google Drive\SU21_Collaboration\Swing_phase_project\kinematic_data\winterKinematics.mat');
% load('G:\.shortcut-targets-by-id\1P2PZuEj8zgmr_5ZkWSy-nJFsTOMq2rdz\SU21_Collaboration\Swing_phase_project\kinematic_data\winterKinematics.mat');
%end of swing phase index 27
swing_end = 106;
t = t(1:swing_end);
t_0 = t(1);
t_f = t(swing_end); %for swing only 27
dt = t(2)-t(1);
winter_theta = winter_theta(:,1:swing_end);
winter_omega = winter_omega(:,1:swing_end);
winter_alpha = winter_alpha(:,1:swing_end);

%% Prep data for sim

%hip
winter_theta_1(3,:) = winter_theta(3,:)-90;
plot(t,winter_theta_1(3,:)); hold on;
%knee
winter_theta_1(2,:) = winter_theta(2,:)-winter_theta(3,:);
plot(t,winter_theta_1(2,:));
%Ankle
winter_theta_1(1,:) = winter_theta(1,:)-winter_theta(2,:);
plot(t,winter_theta_1(1,:));
%% Angular Motion

%hip
theta_hip = winter_theta_1(3,:);
%Convert in radians
theta_hip = deg2rad(theta_hip);
omega_hip = winter_omega(3,:);
alpha_hip = winter_alpha(3,:);

%knee
theta_knee = winter_theta_1(2,:);
%Convert in radians
theta_knee = deg2rad(theta_knee);
omega_knee = winter_omega(2,:)-winter_omega(3,:);
alpha_knee = winter_alpha(2,:)-winter_alpha(3,:);

%ankle
theta_ankle = winter_theta_1(1,:);
%Convert in radians
theta_ankle = deg2rad(theta_ankle);
omega_ankle = winter_omega(1,:)-winter_omega(2,:);
alpha_ankle = winter_alpha(1,:)-winter_alpha(2,:);

clear winter_theta_1;