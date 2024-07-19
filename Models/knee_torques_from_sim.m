%Calculate torque about knee joint from spring/damper force

%Position vectors
%S1 knee_joint to spring origin
s1 = [out.x1.data out.y1.data out.z1.data];
%S2 knee_joint to spring end
s2 = [out.x2.data out.y2.data out.z2.data];
%S vector along length of spring
S = s2-s1;
%Calculate unit vector
piston_unit = S./vecnorm(S,2,2);
%Force vector, uses force mag and sign to define force and direction
piston_fvec = out.piston_f.data.*piston_unit;

%Calculating toques using cross product
knee_torque = zeros(length(piston_fvec),3);
for i = 1:length(piston_fvec)
    knee_torque(i,:) = cross(s1(i,:),piston_fvec(i,:));
end
%Plot torque values
figure(1); clf;
plot(out.tout,knee_torque(:,3));
xlabel('Time (s)');ylabel('Toque (Nm)'); 