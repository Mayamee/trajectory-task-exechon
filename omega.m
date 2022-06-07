clc; clear; close all;
addpath 'C:\Users\mew\Desktop\test\traj task\code'
display = "off";
init();
Time_vector_multiplicity = 60;
N = 60;
ci = 0;
T = 0:Time_vector_multiplicity / (N - 1):Time_vector_multiplicity;
w = 0.15;
R = 50;
x = R .* sin(w .* T);
y = 0 + R .* cos(w .* T);
z = 400 * ones(1, length(T));
% Graph
plot3(x, y, z)
set(get(gca, 'XLabel'), 'String', 'X');
set(get(gca, 'YLabel'), 'String', 'Y');
set(get(gca, 'ZLabel'), 'String', 'Z');
grid on;
% Graph
% Consts
K_stepsToDist = 0.037;
K_stepsToDeg = 1.8;
% acceleration_Q = [300 300 300 1200 1200];
acceleration_Q = [300 300 300 300 300];
deceleration_Q = [8000 8000 8000 8000 8000];
velocity_max_Q = [900 900 900 50 50];
Q0_home = [295; 355; 295; 0; 0];
% Consts

% Correct
acceleration_Q(1:3) = acceleration_Q(1:3) * K_stepsToDist;
acceleration_Q(4:5) = acceleration_Q(4:5) * K_stepsToDeg;

deceleration_Q(1:3) = deceleration_Q(1:3) * K_stepsToDist;
deceleration_Q(4:5) = deceleration_Q(4:5) * K_stepsToDeg;

velocity_max_Q(1:3) = velocity_max_Q(1:3) * K_stepsToDist;
velocity_max_Q(4:5) = velocity_max_Q(4:5) * K_stepsToDeg;
% Correct

%Решение обратной задачи о положениях в каждой точке траектории
for i = 1:N
    P = [x(i); y(i); z(i)];
    Q(:, i) = xoy_inverse(P, display)';
    i
end

% Prepare
Q(4:5, :) = rad2deg(Q(4:5, :));
Q = [Q0_home Q Q0_home];
% Prepare

% Расчет времени движения по траектории
accumulator_time = 0;
accumulator_vel = [];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%================================================================
% Q(4,:) = Q(4,:) - 180;
% Q(4,1) = Q(4,1) + 180;
% Q(4,62) = Q(4,62) + 180;
%================================================================
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i = 1:N + 1
    Q1 = Q(:, i + 1);
    Q0 = Q(:, i);
    [vel, max_time] = syncM5(Q1, Q0, velocity_max_Q, acceleration_Q, deceleration_Q);
    accumulator_time = accumulator_time + max_time;
    accumulator_vel = [accumulator_vel (vel / K_stepsToDist)'];
end

disp("Время движения по траектории")
accumulator_time

init_velocity_max_Q(1:3) = velocity_max_Q(1:3) / K_stepsToDist;
init_velocity_max_Q(4:5) = velocity_max_Q(4:5) / K_stepsToDeg;
accumulator_vel = [(init_velocity_max_Q)' accumulator_vel];
accumulator_vel = round(accumulator_vel, 2)';
Q = round(Q, 2)';

% Saturation
for i = 1:length(accumulator_vel(:, 4))
    accumulator_vel(i, 4) = min(velocity_max_Q(4) / K_stepsToDeg, max(0, accumulator_vel(i, 4)));
    accumulator_vel(i, 5) = min(velocity_max_Q(5) / K_stepsToDeg, max(0, accumulator_vel(i, 5)));
end
% Saturation
serialStm32 = serialport("COM3", 9600, "Timeout", 60);
% Init
serialStm32.writeline("/toggle_power");
serialStm32.readline();
pause(2);
serialStm32.writeline("/correct");
serialStm32.readline();
pause(2);
% Init

% Trajectory
for i = 1:N + 2
    velPacket = strrep(strrep(jsonencode(accumulator_vel(i, :)), "[", ""), "]", "")
    posPacket = strrep(strrep(jsonencode(Q(i, :)), "[", ""), "]", "")
    serialStm32.writeline("/set_pos")
    serialStm32.readline()
    serialStm32.writeline(posPacket)
    serialStm32.readline()
    serialStm32.writeline("/set_vel")
    serialStm32.readline()
    serialStm32.writeline(velPacket)
    serialStm32.readline()
    serialStm32.writeline("/move")
    serialStm32.readline()
end
% Trajectory
pause(2);
serialStm32.writeline("/uncorrect");
serialStm32.readline();
pause(2);
serialStm32.writeline("/toggle_power");
serialStm32.readline();