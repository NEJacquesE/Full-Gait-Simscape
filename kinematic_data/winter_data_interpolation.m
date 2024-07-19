%% Load data from xlsx file
%load('C:\Users\nejac\Google Drive\SU21_Collaboration\Swing_phase_project\kinematic_data\winterKinematics.mat');
load('kinematic_data\winterKinematics.mat');
load('kinematic_data\winterHipJointKinematics.mat')

%end of swing phase index 27
trial_end = 69; %End of 1st complete gait cycle r_leg
t = t(1:trial_end);
t_0 = t(1);
t_f = t(trial_end); %for swing only 27
dt = t(2)-t(1);
winter_theta = winter_theta(:,1:trial_end);
winter_omega = winter_omega(:,1:trial_end);
winter_alpha = winter_alpha(:,1:trial_end);

%adding hip translation coord.
winter_hip_x = x_hip(:,1:trial_end);
winter_hip_y = y_hip(:,1:trial_end);
winter_hip_vx = vx_hip(:,1:trial_end);
winter_hip_vy = vy_hip(:,1:trial_end);
winter_hip_ax = ax_hip(:,1:trial_end);
winter_hip_ay = ay_hip(:,1:trial_end);

%% Prep data for sim
%hat
winter_theta_1(4,:) = -winter_theta(4,:)+90; %convention of winter is using horizontal for global

%hip
winter_theta_1(3,:) = winter_theta(3,:);

%knee
winter_theta_1(2,:) = -winter_theta(2,:);
% chien's article data change 
%winter_theta_1(2,30:86) = winter_theta_1(2,30:86)+7.6;

%Ankle
%winter_theta_1(1,:) = winter_theta(1,:)-winter_theta(2,:);
%winter_theta_1(1,:) = -winter_theta(1,:)+90; %for swing phase
winter_theta_1(1,:) = -winter_theta(1,:); %for hat

%Convert in radians
winter_theta_1 = deg2rad(winter_theta_1);

%% Interpolation of angles vs time 
int_n = 500;
t1 = linspace(t(1),t(end),int_n); dt = t1(2)-t1(1);
winter_theta_2 = zeros(4,int_n);
% figure(1);clf;hold on;
for i = 1:4
    winter_theta_2(i,:) = interp1(t,winter_theta_1(i,:),t1);
    %Interpolation for angular velocity
    winter_omega_1(i,:) = interp1(t,winter_omega(i,:),t1);
    %Interpolation for angular acc
    winter_alpha_1(i,:) = interp1(t,winter_alpha(i,:),t1);
%     plot(t,winter_theta_1(i,:),'*');
%     plot(t1,winter_theta_2(i,:));
end

%HIP COORD
%adding hip translation coord.
winter_hip_x = interp1(t,winter_hip_x,t1);
winter_hip_y = interp1(t,winter_hip_y,t1);
winter_hip_vx = interp1(t,winter_hip_vx,t1);
winter_hip_vy = interp1(t,winter_hip_vy,t1);
winter_hip_ax = interp1(t,winter_hip_ax,t1);
winter_hip_ay = interp1(t,winter_hip_ay,t1);

%% Fourier series and derivatives
%Might not be needed in the future if interpolation is what we use for all
%the data. The need to calculate derivatives is eliminated.
for i = 1:4
    winter_theta_3{i} = fit(t1',winter_theta_2(i,:)','fourier8');
    winter_omega_2{i} = fit(t1',winter_omega_1(i,:)','fourier8');
    winter_alpha_2{i} = fit(t1',winter_alpha_1(i,:)','fourier8');
%    [winter_omega_1{i},winter_alpha_1{i}] = differentiate(winter_theta_3{i},t1);
%     figure(i);clf;
%     subplot(3,1,1);hold on;
%     plot(t1,winter_theta_2(i,:),'*');
%     plot(winter_theta_3{i});
%     subplot(3,1,2);
%     plot(t1,winter_omega_1{i});
%     subplot(3,1,3);
%     plot(t1,winter_alpha_1{i});
end

%HIP COORD
%adding hip translation coord.
winter_hip_x = fit(t1',winter_hip_x','fourier8');
winter_hip_y = fit(t1',winter_hip_y','fourier8');
winter_hip_vx = fit(t1',winter_hip_vx','fourier8');
winter_hip_vy = fit(t1',winter_hip_vy','fourier8');
winter_hip_ax = fit(t1',winter_hip_ax','fourier8');
winter_hip_ay = fit(t1',winter_hip_ay','fourier8');

%% Data points
%hat
theta_hat_R = feval(winter_theta_3{4},t1);
omega_hat_R = -feval(winter_omega_2{4},t1); %took opposite of angle
alpha_hat_R = -feval(winter_alpha_2{4},t1); %took opposite of angle

%hip
theta_hip_R = feval(winter_theta_3{3},t1);
omega_hip_R = feval(winter_omega_2{3},t1);
alpha_hip_R = feval(winter_alpha_2{3},t1);

%knee
theta_knee_R = feval(winter_theta_3{2},t1);
omega_knee_R = -feval(winter_omega_2{2},t1); %took opposite of angle
alpha_knee_R = -feval(winter_alpha_2{2},t1); %took opposite of angle

%ankle
theta_ankle_R = feval(winter_theta_3{1},t1);
omega_ankle_R = -feval(winter_omega_2{1},t1); %took opposite of angle
alpha_ankle_R = -feval(winter_alpha_2{1},t1); %took opposite of angle

% omega_ankle = -feval(winter_omega_2{1},t1)-feval(winter_omega_2{2},t1)-feval(winter_omega_2{3},t1);
% alpha_ankle = -feval(winter_alpha_2{1},t1)-feval(winter_alpha_2{2},t1)-feval(winter_alpha_2{3},t1);

%Hip Trans.
x_hip = feval(winter_hip_x,t1);
y_hip = feval(winter_hip_y,t1);
vx_hip = feval(winter_hip_vx,t1);
vy_hip = feval(winter_hip_vy,t1);
ax_hip = feval(winter_hip_ax,t1);
ay_hip = feval(winter_hip_ay,t1);

%clear variable
clear winter_alpha_2 winter_alpha_1 winter_alpha 
clear winter_omega_2 winter_omega_1 winter_omega 
clear winter_theta_3 winter_theta_2 winter_theta_1 winter_theta