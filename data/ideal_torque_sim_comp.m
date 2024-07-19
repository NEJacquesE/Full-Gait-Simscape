figure;
subplot(2,1,1); hold on;
plot(t1(1:124).',ideal_hip_torques(1:124));
plot(healthy_torque.time(1:124),healthy_torque.Data(1:124,1));
legend('Ideal Prosthetic Model','Able Body Model');
title('Hip Torque vs Time');

subplot(2,1,2); hold on;
plot(t1(1:124).',ideal_knee_torques(1:124));
plot(healthy_torque.time(1:124),healthy_torque.Data(1:124,2));
legend('Ideal Prosthetic Model','Able Body Model');
title('Knee Torque vs Time');