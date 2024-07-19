%% Load data from xlsx file
%load('C:\Users\nejac\Google Drive\SU21_Collaboration\Swing_phase_project\kinematic_data\winterKinematics.mat');
load('kinematic_data/winterKinematics_L.mat');

%end of swing phase index 27
trial_end = 69; %End of 1st complete gait cycle r_leg
t = t(1:trial_end);
t_0 = t(1);
t_f = t(trial_end); %for swing only 27
dt = t(2)-t(1);
winter_theta_L = winter_theta_L(:,1:trial_end);
winter_omega_L = winter_omega_L(:,1:trial_end);
winter_alpha_L = winter_alpha_L(:,1:trial_end);

%% Prep data for sim
%hat
winter_theta_1_L(4,:) = -winter_theta_L(4,:)+90; %convention of winter is using horizontal for global

%hip
winter_theta_1_L(3,:) = winter_theta_L(3,:);

%knee
winter_theta_1_L(2,:) = -winter_theta_L(2,:);

%Ankle
%winter_theta_1(1,:) = winter_theta(1,:)-winter_theta(2,:);
%winter_theta_1_L(1,:) = -winter_theta_L(1,:)+90;
winter_theta_1_L(1,:) = -winter_theta_L(1,:);

%Convert in radians
winter_theta_1_L = deg2rad(winter_theta_1_L);

%% Interpolation of angles vs time 
int_n = 500;
t1 = linspace(t(1),t(end),int_n); dt = t1(2)-t1(1);
winter_theta_2_L = zeros(3,int_n);
% figure(1);clf;hold on;
for i = 1:4
    winter_theta_2_L(i,:) = interp1(t,winter_theta_1_L(i,:),t1);
    %Interpolation for angular velocity
    winter_omega_1_L(i,:) = interp1(t,winter_omega_L(i,:),t1);
    %Interpolation for angular acc
    winter_alpha_1_L(i,:) = interp1(t,winter_alpha_L(i,:),t1);
%     plot(t,winter_theta_1(i,:),'*');
%     plot(t1,winter_theta_2(i,:));
end

%% Fourier series and derivatives
%Might not be needed in the future if interpolation is what we use for all
%the data. The need to calculate derivatives is eliminated.
for i = 1:4
    winter_theta_3_L{i} = fit(t1',winter_theta_2_L(i,:)','fourier8');
    winter_omega_2_L{i} = fit(t1',winter_omega_1_L(i,:)','fourier8');
    winter_alpha_2_L{i} = fit(t1',winter_alpha_1_L(i,:)','fourier8');
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

%% Data points
%hat
theta_hat_L = feval(winter_theta_3_L{4},t1);
omega_hat_L = -feval(winter_omega_2_L{4},t1); %took opposite of angle
alpha_hat_L = -feval(winter_alpha_2_L{4},t1); %took opposite of angle

%hip
theta_hip_L = feval(winter_theta_3_L{3},t1);
omega_hip_L = feval(winter_omega_2_L{3},t1);
alpha_hip_L = feval(winter_alpha_2_L{3},t1);

%knee
theta_knee_L = feval(winter_theta_3_L{2},t1);
omega_knee_L = feval(winter_omega_2_L{2},t1); %took opposite of angle
alpha_knee_L = feval(winter_alpha_2_L{2},t1); %took opposite of angle

%ankle
theta_ankle_L = feval(winter_theta_3_L{1},t1);
omega_ankle_L = -feval(winter_omega_2_L{1},t1); %took opposite of angle
alpha_ankle_L = -feval(winter_alpha_2_L{1},t1); %took opposite of angle

%omega_ankle_L = feval(winter_omega_2_L{1},t1)-feval(winter_omega_2_L{2},t1);
%alpha_ankle_L = feval(winter_alpha_2_L{1},t1)-feval(winter_alpha_2_L{2},t1);

%clear variable
clear winter_alpha_2_L winter_alpha_1_L winter_alpha_L 
clear winter_omega_2_L winter_omega_1_L winter_omega_L 
clear winter_theta_3_L winter_theta_2_L winter_theta_1_L winter_theta_L