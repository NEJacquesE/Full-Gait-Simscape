% Export WinterKinematics data from excel and create mat file to be used
clear;
%% Load data from xlsx file
% Swing phase 1-27
% Stance Phase 28-68
winter_data = readtable('Winter_Appendix_data.xlsx','Sheet',3, 'HeaderLines', 4);
%ankle angle
winter_rel = readtable('Winter_Appendix_data.xlsx','Sheet',4, 'HeaderLines', 4);
t = winter_data.(3).';
%For hip-knee-ankle
for i = 1:3
    winter_theta(i,:) = winter_rel.(3*i+1).';
    winter_omega(i,:) = winter_rel.(3*i+2).';
    winter_alpha(i,:) = winter_rel.(3*i+3).';
end
%For hat 1/2 hat segment
    winter_theta(4,:) = winter_data.(34).';
    winter_omega(4,:) = winter_data.(35).';
    winter_alpha(4,:) = winter_data.(36).';

save('G:\.shortcut-targets-by-id\1YXV-SWkwjUwCHF0E-UodEuhZKomSyoO0\SU21_Collaboration\Full Gait Simscape\kinematic_data\winterKinematics.mat', 't', 'winter_theta', 'winter_omega', 'winter_alpha')
