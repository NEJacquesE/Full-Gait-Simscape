%% Load data from xlsx file

data = readtable('\team_3_project\MBD_DATA.xlsx');
data = data(1:106,:);
time = table2array(data(:,1));
t_0 = time(1);
t_f = time(end);
dt = time(2)-time(1);
theta_1 = table2array(data(:,2))-(3*pi/2);
theta_2 = table2array(data(:,5));
theta_3 = table2array(data(:,8))-(1-pi/2);

dtheta_1 = table2array(data(:,3));
dtheta_2 = table2array(data(:,6));
dtheta_3 = table2array(data(:,9));

ddtheta_1 = table2array(data(:,4));
ddtheta_2 = table2array(data(:,7));
ddtheta_3 = table2array(data(:,10));

x_hip = table2array(data(:,12));
y_hip = table2array(data(:,13));