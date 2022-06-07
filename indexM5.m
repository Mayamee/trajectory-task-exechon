clc; clear; close all;
addpath 'C:\Users\mew\Desktop\test\traj task\syncM5'
% Поправочные константы
K_Q_VIRTUAL = 0.745;
% K_stepsToDist = 0.08;
% de facto
K_stepsToDist = 0.037;
K_stepsToDeg = 1.8;

acceleration_Q = [300 300 300 1200 1200];
deceleration_Q = [8000 8000 8000 8000 8000];
velocity_max_Q = [900 900 900 1500 1500];
% acceleration_Q = [300 300 300 600 600];
% deceleration_Q = [7000 7000 7000 1500 1500];
% velocity_max_Q = [900 900 900 900 900];
Q0 = [295 355 295 0 0];
Q1 = [250 300 250 90 90];

Q0(1) = Q0(1) * K_Q_VIRTUAL;
Q0(3) = Q0(3) * K_Q_VIRTUAL;

Q1(1) = Q1(1) * K_Q_VIRTUAL;
Q1(3) = Q1(3) * K_Q_VIRTUAL;

acceleration_Q(1:3) = acceleration_Q(1:3) * K_stepsToDist;
acceleration_Q(4:5) = acceleration_Q(4:5) * K_stepsToDeg;

deceleration_Q(1:3) = deceleration_Q(1:3) * K_stepsToDist;
deceleration_Q(4:5) = deceleration_Q(4:5) * K_stepsToDeg;

velocity_max_Q(1:3) = velocity_max_Q(1:3) * K_stepsToDist;
velocity_max_Q(4:5) = velocity_max_Q(4:5) * K_stepsToDeg;

[vel max_time] = syncM5(Q1, Q0, velocity_max_Q, acceleration_Q, deceleration_Q);
vel(1:3) = vel(1:3) / K_stepsToDist;
vel(4:5) = vel(4:5);
disp("Скорости")
vel
disp("Максимальное время")
max_time
