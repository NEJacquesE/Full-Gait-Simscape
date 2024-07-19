% This is a script to read in data from Excel files containing Winter gait
% data and recreate the input kinematics used in the original Gharini
% model.

%% Read in Input Data from Gharini Model
load(['P:\Shared folders\MattL\SwingPhaseControlEvaluation\GhariniModel\Gait simulation\winterKinematics.mat']);

% interpolate onto an evenly spaced dataseries
t1 = linspace(t(1),t(end),500); dt = t1(2)-t1(1);
winter_theta2 = zeros(6,500); winter_omega2 = zeros(6,500);
for i = 1:6
    winter_theta2(i,:) = interp1(t,winter_theta(i,:),t1);
    winter_omega2(i,:) = interp1(t,winter_omega(i,:),t1);
end
HAT_theta2 = interp1(t,HAT_theta,t1);
HAT_omega2 = interp1(t,HAT_omega,t1);

clear HAT_theta HAT_omega winter_theta t i

%% Define into a Gait Cycle
% Establish a gait cycle for each variable, starting at toe-off of right
% leg

% start and stop indices using visual inspection
startInd1 = 317;    stopInd1 = 420;
startInd2 = 1;      stopInd2 = 316;

newInds  = [startInd1:stopInd1 startInd2:stopInd2];

% define new time variable: t2
ta = t1(startInd1:stopInd1) - t1(startInd1);
tb = t1(startInd2:stopInd2) + t1(stopInd1) - t1(startInd1) + dt;

t2 = [ta(:);tb(:)]';    clear ta tb;

% define new kinematic variables
for i = 1:6
    winter_theta3(i,:) = winter_theta2(i,newInds);
    winter_omega3(i,:) = winter_omega2(i,newInds);
end
HAT_theta3 = HAT_theta2(newInds);
HAT_omega3 = HAT_omega2(newInds);

% define right and left leg variables
rAnkleTheta = winter_theta3(1,:);        rAnkleOmega = winter_omega3(1,:);
rKneeTheta = winter_theta3(2,:);         rKneeOmega = winter_omega3(2,:);
rHipTheta = winter_theta3(3,:);          rHipOmega = winter_omega3(3,:);

lAnkleTheta = winter_theta3(4,:);        lAnkleOmega = winter_omega3(4,:);
lKneeTheta = winter_theta3(5,:);         lKneeOmega = winter_omega3(5,:);
lHipTheta = winter_theta3(6,:);          lHipOmega = winter_omega3(6,:);

hatTheta = HAT_theta3;
hatOmega = HAT_omega3;

clear winter_theta2 winter_omega2 i t1
clear HAT_theta2 HAT_omega2

%% Define Right Swing Phase Subsection of data
rHeelStrikeInd = 179;

tSwing = t2(1:rHeelStrikeInd);

rAnkleThetaS = winter_theta3(1,1:rHeelStrikeInd);        rAnkleOmegaS = winter_omega3(1,1:rHeelStrikeInd);
rKneeThetaS = winter_theta3(2,1:rHeelStrikeInd);         rKneeOmegaS = winter_omega3(2,1:rHeelStrikeInd);
rHipThetaS = winter_theta3(3,1:rHeelStrikeInd);          rHipOmegaS = winter_omega3(3,1:rHeelStrikeInd);

lAnkleThetaS = winter_theta3(4,1:rHeelStrikeInd);        lAnkleOmegaS = winter_omega3(4,1:rHeelStrikeInd);
lKneeThetaS = winter_theta3(5,1:rHeelStrikeInd);         lKneeOmegaS = winter_omega3(5,1:rHeelStrikeInd);
lHipThetaS = winter_theta3(6,1:rHeelStrikeInd);          lHipOmegaS = winter_omega3(6,1:rHeelStrikeInd);

hatThetaS = HAT_theta3;
hatOmegaS = HAT_omega3;

%% CALCULATE INDEPENDENT VARIABLE t2 AS A PERCENT GAIT CYCLE
pctGC = t2./max(t2);
%% Create Fourier Coefficients
% RIGHT LEG
% Hip Angle
f2 = fit(pctGC',rHipTheta','fourier8');
p = coeffvalues(f2);
CRhT = p;

% Knee Angle
f2 = fit(pctGC',rKneeTheta','fourier8');
p = coeffvalues(f2);
CRkT = p;
% Ankle Angle
f2 = fit(pctGC',rAnkleTheta','fourier8');
p = coeffvalues(f2);
CRaT = p;

% LEFT LEG
% Hip Angle
f2 = fit(pctGC',lHipTheta','fourier8');
p = coeffvalues(f2);
CLhT = p;

% Knee Angle
f2 = fit(pctGC',lKneeTheta','fourier8');
p = coeffvalues(f2);
CLkT = p;
% Ankle Angle
f2 = fit(pctGC',lAnkleTheta','fourier8');
p = coeffvalues(f2);
CLaT = p;

% HAT
f2 = fit(pctGC',hatTheta','fourier8');
p = coeffvalues(f2);
CHAT = p;

f2 = fit(pctGC',hatOmega','fourier8');
p = coeffvalues(f2);
hatOmegaCoeffs = p;
