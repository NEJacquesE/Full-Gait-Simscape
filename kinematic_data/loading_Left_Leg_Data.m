% Export WinterKinematics data from excel and create mat file to be used
clear;
%% Load data from xlsx file

winter_data_L = readtable('WinterKinematics_Left.xlsx','Sheet',2, 'HeaderLines', 4);

t = winter_data_L.(3).';

% %Ankle Data
%     winter_theta_L(1,:) = winter_data_L.(13).';
%     winter_omega_L(1,:) = winter_data_L.(14).';
%     winter_alpha_L(1,:) = winter_data_L.(15).';
% 
% 
% %Hip  and Knee

for i = 1:4 
    winter_theta_L(i,:) = winter_data_L.(3*i+1).';
    winter_omega_L(i,:) = winter_data_L.(3*i+2).';
    winter_alpha_L(i,:) = winter_data_L.(3*i+3).';
    %winter_torques(i,:) = winter_data.(10*i-1).';
end

save('G:\.shortcut-targets-by-id\1YXV-SWkwjUwCHF0E-UodEuhZKomSyoO0\SU21_Collaboration\Full Gait Simscape\kinematic_data\winterKinematics_L.mat', 't', 'winter_theta_L', 'winter_omega_L', 'winter_alpha_L')