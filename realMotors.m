clc; clear; close all;
% Поправочные константы
K_Q_VIRTUAL = 0.745;
% K_stepsToDist = 0.08;
% de facto
K_stepsToDist = 0.037;
K_stepsToDeg = 1.8;
%Задание ускорения разгона
acceleration_Q1 = 300 * K_stepsToDist;
acceleration_Q2 = 300 * K_stepsToDist;
acceleration_Q3 = 300 * K_stepsToDist;
acceleration_Q4 = 600 * K_stepsToDeg;
acceleration_Q5 = 600 * K_stepsToDeg;
%Задание ускорения торможения
deceleration_Q1 = 7000 * K_stepsToDist;
deceleration_Q2 = 7000 * K_stepsToDist;
deceleration_Q3 = 7000 * K_stepsToDist;
deceleration_Q4 = 1500 * K_stepsToDeg;
deceleration_Q5 = 1500 * K_stepsToDeg;
%Задание максимальных скоростей
velocity_max_Q1 = 900 * K_stepsToDist;
velocity_max_Q2 = 900 * K_stepsToDist;
velocity_max_Q3 = 900 * K_stepsToDist;
velocity_max_Q4 = 900 * K_stepsToDeg;
velocity_max_Q5 = 900 * K_stepsToDeg;
%Задание обобщенных координат
Q1_0 = 295 * K_Q_VIRTUAL;
Q2_0 = 355;
Q3_0 = 295 * K_Q_VIRTUAL;
Q4_0 = 0;
Q5_0 = 0;
%=
Q1_1 = 280 * K_Q_VIRTUAL;
Q2_1 = 250;
Q3_1 = 280 * K_Q_VIRTUAL;
Q4_1 = 30;
Q5_1 = 45;
%Вычисляем изменение обобщенных координат
difference_Q1 = abs(Q1_1 - Q1_0);
difference_Q2 = abs(Q2_1 - Q2_0);
difference_Q3 = abs(Q3_1 - Q3_0);
difference_Q4 = abs(Q4_1 - Q4_0);
difference_Q5 = abs(Q5_1 - Q5_0);
%Вычисление времени разгона
T_acceleration_Q1 = velocity_max_Q1 / acceleration_Q1;
T_acceleration_Q2 = velocity_max_Q2 / acceleration_Q2;
T_acceleration_Q3 = velocity_max_Q3 / acceleration_Q3;
T_acceleration_Q4 = velocity_max_Q4 / acceleration_Q4;
T_acceleration_Q5 = velocity_max_Q5 / acceleration_Q5;
%Вычисление времени торможения
T_deceleration_Q1 = velocity_max_Q1 / deceleration_Q1;
T_deceleration_Q2 = velocity_max_Q2 / deceleration_Q2;
T_deceleration_Q3 = velocity_max_Q3 / deceleration_Q3;
T_deceleration_Q4 = velocity_max_Q4 / deceleration_Q4;
T_deceleration_Q5 = velocity_max_Q5 / deceleration_Q5;
%Вычисление времени движения с максимальной скоростью
T_max_velocity_Q1 = difference_Q1 / velocity_max_Q1 - (T_acceleration_Q1 + T_deceleration_Q1) / 2;
T_max_velocity_Q2 = difference_Q2 / velocity_max_Q2 - (T_acceleration_Q2 + T_deceleration_Q2) / 2;
T_max_velocity_Q3 = difference_Q3 / velocity_max_Q3 - (T_acceleration_Q3 + T_deceleration_Q3) / 2;
T_max_velocity_Q4 = difference_Q4 / velocity_max_Q4 - (T_acceleration_Q4 + T_deceleration_Q4) / 2;
T_max_velocity_Q5 = difference_Q5 / velocity_max_Q5 - (T_acceleration_Q5 + T_deceleration_Q5) / 2;

if T_max_velocity_Q1 > 0
    Time_END_Q1 = T_acceleration_Q1 + T_deceleration_Q1 + T_max_velocity_Q1;
else
    T_acceleration_Q1 = sqrt((2 * difference_Q1) / (acceleration_Q1 * (1 + acceleration_Q1 / deceleration_Q1)));
    T_deceleration_Q1 = T_acceleration_Q1 * acceleration_Q1 / deceleration_Q1;
    Time_END_Q1 = T_acceleration_Q1 + T_deceleration_Q1;
end

if T_max_velocity_Q2 > 0
    Time_END_Q2 = T_acceleration_Q2 + T_deceleration_Q2 + T_max_velocity_Q2;
else
    T_acceleration_Q2 = sqrt((2 * difference_Q2) / (acceleration_Q2 * (1 + acceleration_Q2 / deceleration_Q2)));
    T_deceleration_Q2 = T_acceleration_Q2 * acceleration_Q2 / deceleration_Q2;
    Time_END_Q2 = T_acceleration_Q2 + T_deceleration_Q2;
end

if T_max_velocity_Q3 > 0
    Time_END_Q3 = T_acceleration_Q3 + T_deceleration_Q3 + T_max_velocity_Q3;
else
    T_acceleration_Q3 = sqrt((2 * difference_Q3) / (acceleration_Q3 * (1 + acceleration_Q3 / deceleration_Q3)));
    T_deceleration_Q3 = T_acceleration_Q3 * acceleration_Q3 / deceleration_Q3;
    Time_END_Q3 = T_acceleration_Q3 + T_deceleration_Q3;
end

if T_max_velocity_Q4 > 0
    Time_END_Q4 = T_acceleration_Q4 + T_deceleration_Q4 + T_max_velocity_Q4;
else
    T_acceleration_Q4 = sqrt((2 * difference_Q4) / (acceleration_Q4 * (1 + acceleration_Q4 / deceleration_Q4)));
    T_deceleration_Q4 = T_acceleration_Q4 * acceleration_Q4 / deceleration_Q4;
    Time_END_Q4 = T_acceleration_Q4 + T_deceleration_Q4;
end

if T_max_velocity_Q5 > 0
    Time_END_Q5 = T_acceleration_Q5 + T_deceleration_Q5 + T_max_velocity_Q5;
else
    T_acceleration_Q5 = sqrt((2 * difference_Q5) / (acceleration_Q5 * (1 + acceleration_Q5 / deceleration_Q5)));
    T_deceleration_Q5 = T_acceleration_Q5 * acceleration_Q5 / deceleration_Q5;
    Time_END_Q5 = T_acceleration_Q5 + T_deceleration_Q5;
end

max_time_end = max([Time_END_Q1 Time_END_Q2 Time_END_Q3 Time_END_Q4 Time_END_Q5]);
% Перерасчет времени
switch max_time_end
    case Time_END_Q1
        % Перерасчет второй координаты
        T_acceleration_Q2 = roots([(1 + acceleration_Q2 / deceleration_Q2); - 2 * max_time_end; 2 * difference_Q2 / acceleration_Q2]);
        T_acceleration_Q2 = T_acceleration_Q2(2, 1);
        T_deceleration_Q2 = T_acceleration_Q2 * acceleration_Q2 / deceleration_Q2;
        velocity_max_Q2 = T_acceleration_Q2 * acceleration_Q2;
        T_max_velocity_Q2 = max_time_end - T_acceleration_Q2 - T_deceleration_Q2;
        % Перерасчет третьей координаты
        T_acceleration_Q3 = roots([(1 + acceleration_Q3 / deceleration_Q3); - 2 * max_time_end; 2 * difference_Q3 / acceleration_Q3]);
        T_acceleration_Q3 = T_acceleration_Q3(2, 1);
        T_deceleration_Q3 = T_acceleration_Q3 * acceleration_Q3 / deceleration_Q3;
        velocity_max_Q3 = T_acceleration_Q3 * acceleration_Q3;
        T_max_velocity_Q3 = max_time_end - T_acceleration_Q3 - T_deceleration_Q3;
        % Перерасчет четвертой координаты
        T_acceleration_Q4 = roots([(1 + acceleration_Q4 / deceleration_Q4); - 2 * max_time_end; 2 * difference_Q4 / acceleration_Q4]);
        T_acceleration_Q4 = T_acceleration_Q4(2, 1);
        T_deceleration_Q4 = T_acceleration_Q4 * acceleration_Q4 / deceleration_Q4;
        velocity_max_Q4 = T_acceleration_Q4 * acceleration_Q4;
        T_max_velocity_Q4 = max_time_end - T_acceleration_Q4 - T_deceleration_Q4;
        % Перерасчет пятой координаты
        T_acceleration_Q5 = roots([(1 + acceleration_Q5 / deceleration_Q5); - 2 * max_time_end; 2 * difference_Q5 / acceleration_Q5]);
        T_acceleration_Q5 = T_acceleration_Q5(2, 1);
        T_deceleration_Q5 = T_acceleration_Q5 * acceleration_Q5 / deceleration_Q5;
        velocity_max_Q5 = T_acceleration_Q5 * acceleration_Q5;
        T_max_velocity_Q5 = max_time_end - T_acceleration_Q5 - T_deceleration_Q5;

    case Time_END_Q2
        % Перерасчет первой координаты
        T_acceleration_Q1 = roots([(1 + acceleration_Q1 / deceleration_Q1); - 2 * max_time_end; 2 * difference_Q1 / acceleration_Q1]);
        T_acceleration_Q1 = T_acceleration_Q1(2, 1);
        T_deceleration_Q1 = T_acceleration_Q1 * acceleration_Q1 / deceleration_Q1;
        velocity_max_Q1 = T_acceleration_Q1 * acceleration_Q1;
        T_max_velocity_Q1 = max_time_end - T_acceleration_Q1 - T_deceleration_Q1;
        % Перерасчет третьей координаты
        T_acceleration_Q3 = roots([(1 + acceleration_Q3 / deceleration_Q3); - 2 * max_time_end; 2 * difference_Q3 / acceleration_Q3]);
        T_acceleration_Q3 = T_acceleration_Q3(2, 1);
        T_deceleration_Q3 = T_acceleration_Q3 * acceleration_Q3 / deceleration_Q3;
        velocity_max_Q3 = T_acceleration_Q3 * acceleration_Q3;
        T_max_velocity_Q3 = max_time_end - T_acceleration_Q3 - T_deceleration_Q3;
        % Перерасчет четвертой координаты
        T_acceleration_Q4 = roots([(1 + acceleration_Q4 / deceleration_Q4); - 2 * max_time_end; 2 * difference_Q4 / acceleration_Q4]);
        T_acceleration_Q4 = T_acceleration_Q4(2, 1);
        T_deceleration_Q4 = T_acceleration_Q4 * acceleration_Q4 / deceleration_Q4;
        velocity_max_Q4 = T_acceleration_Q4 * acceleration_Q4;
        T_max_velocity_Q4 = max_time_end - T_acceleration_Q4 - T_deceleration_Q4;
        % Перерасчет пятой координаты
        T_acceleration_Q5 = roots([(1 + acceleration_Q5 / deceleration_Q5); - 2 * max_time_end; 2 * difference_Q5 / acceleration_Q5]);
        T_acceleration_Q5 = T_acceleration_Q5(2, 1);
        T_deceleration_Q5 = T_acceleration_Q5 * acceleration_Q5 / deceleration_Q5;
        velocity_max_Q5 = T_acceleration_Q5 * acceleration_Q5;
        T_max_velocity_Q5 = max_time_end - T_acceleration_Q5 - T_deceleration_Q5;
    case Time_END_Q3
        % Перерасчет первой координаты
        T_acceleration_Q1 = roots([(1 + acceleration_Q1 / deceleration_Q1); - 2 * max_time_end; 2 * difference_Q1 / acceleration_Q1]);
        T_acceleration_Q1 = T_acceleration_Q1(2, 1);
        T_deceleration_Q1 = T_acceleration_Q1 * acceleration_Q1 / deceleration_Q1;
        velocity_max_Q1 = T_acceleration_Q1 * acceleration_Q1;
        T_max_velocity_Q1 = max_time_end - T_acceleration_Q1 - T_deceleration_Q1;
        % Перерасчет второй координаты
        T_acceleration_Q2 = roots([(1 + acceleration_Q2 / deceleration_Q2); - 2 * max_time_end; 2 * difference_Q2 / acceleration_Q2]);
        T_acceleration_Q2 = T_acceleration_Q2(2, 1);
        T_deceleration_Q2 = T_acceleration_Q2 * acceleration_Q2 / deceleration_Q2;
        velocity_max_Q2 = T_acceleration_Q2 * acceleration_Q2;
        T_max_velocity_Q2 = max_time_end - T_acceleration_Q2 - T_deceleration_Q2;
        % Перерасчет четвертой координаты
        T_acceleration_Q4 = roots([(1 + acceleration_Q4 / deceleration_Q4); - 2 * max_time_end; 2 * difference_Q4 / acceleration_Q4]);
        T_acceleration_Q4 = T_acceleration_Q4(2, 1);
        T_deceleration_Q4 = T_acceleration_Q4 * acceleration_Q4 / deceleration_Q4;
        velocity_max_Q4 = T_acceleration_Q4 * acceleration_Q4;
        T_max_velocity_Q4 = max_time_end - T_acceleration_Q4 - T_deceleration_Q4;
        % Перерасчет пятой координаты
        T_acceleration_Q5 = roots([(1 + acceleration_Q5 / deceleration_Q5); - 2 * max_time_end; 2 * difference_Q5 / acceleration_Q5]);
        T_acceleration_Q5 = T_acceleration_Q5(2, 1);
        T_deceleration_Q5 = T_acceleration_Q5 * acceleration_Q5 / deceleration_Q5;
        velocity_max_Q5 = T_acceleration_Q5 * acceleration_Q5;
        T_max_velocity_Q5 = max_time_end - T_acceleration_Q5 - T_deceleration_Q5;
    case Time_END_Q4
        % Перерасчет первой координаты
        T_acceleration_Q1 = roots([(1 + acceleration_Q1 / deceleration_Q1); - 2 * max_time_end; 2 * difference_Q1 / acceleration_Q1]);
        T_acceleration_Q1 = T_acceleration_Q1(2, 1);
        T_deceleration_Q1 = T_acceleration_Q1 * acceleration_Q1 / deceleration_Q1;
        velocity_max_Q1 = T_acceleration_Q1 * acceleration_Q1;
        T_max_velocity_Q1 = max_time_end - T_acceleration_Q1 - T_deceleration_Q1;
        % Перерасчет второй координаты
        T_acceleration_Q2 = roots([(1 + acceleration_Q2 / deceleration_Q2); - 2 * max_time_end; 2 * difference_Q2 / acceleration_Q2]);
        T_acceleration_Q2 = T_acceleration_Q2(2, 1);
        T_deceleration_Q2 = T_acceleration_Q2 * acceleration_Q2 / deceleration_Q2;
        velocity_max_Q2 = T_acceleration_Q2 * acceleration_Q2;
        T_max_velocity_Q2 = max_time_end - T_acceleration_Q2 - T_deceleration_Q2;
        % Перерасчет третьей координаты
        T_acceleration_Q3 = roots([(1 + acceleration_Q3 / deceleration_Q3); - 2 * max_time_end; 2 * difference_Q3 / acceleration_Q3]);
        T_acceleration_Q3 = T_acceleration_Q3(2, 1);
        T_deceleration_Q3 = T_acceleration_Q3 * acceleration_Q3 / deceleration_Q3;
        velocity_max_Q3 = T_acceleration_Q3 * acceleration_Q3;
        T_max_velocity_Q3 = max_time_end - T_acceleration_Q3 - T_deceleration_Q3;
        % Перерасчет пятой координаты
        T_acceleration_Q5 = roots([(1 + acceleration_Q5 / deceleration_Q5); - 2 * max_time_end; 2 * difference_Q5 / acceleration_Q5]);
        T_acceleration_Q5 = T_acceleration_Q5(2, 1);
        T_deceleration_Q5 = T_acceleration_Q5 * acceleration_Q5 / deceleration_Q5;
        velocity_max_Q5 = T_acceleration_Q5 * acceleration_Q5;
        T_max_velocity_Q5 = max_time_end - T_acceleration_Q5 - T_deceleration_Q5;
    case Time_END_Q5
        % Перерасчет первой координаты
        T_acceleration_Q1 = roots([(1 + acceleration_Q1 / deceleration_Q1); - 2 * max_time_end; 2 * difference_Q1 / acceleration_Q1]);
        T_acceleration_Q1 = T_acceleration_Q1(2, 1);
        T_deceleration_Q1 = T_acceleration_Q1 * acceleration_Q1 / deceleration_Q1;
        velocity_max_Q1 = T_acceleration_Q1 * acceleration_Q1;
        T_max_velocity_Q1 = max_time_end - T_acceleration_Q1 - T_deceleration_Q1;
        % Перерасчет второй координаты
        T_acceleration_Q2 = roots([(1 + acceleration_Q2 / deceleration_Q2); - 2 * max_time_end; 2 * difference_Q2 / acceleration_Q2]);
        T_acceleration_Q2 = T_acceleration_Q2(2, 1);
        T_deceleration_Q2 = T_acceleration_Q2 * acceleration_Q2 / deceleration_Q2;
        velocity_max_Q2 = T_acceleration_Q2 * acceleration_Q2;
        T_max_velocity_Q2 = max_time_end - T_acceleration_Q2 - T_deceleration_Q2;
        % Перерасчет третьей координаты
        T_acceleration_Q3 = roots([(1 + acceleration_Q3 / deceleration_Q3); - 2 * max_time_end; 2 * difference_Q3 / acceleration_Q3]);
        T_acceleration_Q3 = T_acceleration_Q3(2, 1);
        T_deceleration_Q3 = T_acceleration_Q3 * acceleration_Q3 / deceleration_Q3;
        velocity_max_Q3 = T_acceleration_Q3 * acceleration_Q3;
        T_max_velocity_Q3 = max_time_end - T_acceleration_Q3 - T_deceleration_Q3;
        % Перерасчет четвертой координаты
        T_acceleration_Q4 = roots([(1 + acceleration_Q4 / deceleration_Q4); - 2 * max_time_end; 2 * difference_Q4 / acceleration_Q4]);
        T_acceleration_Q4 = T_acceleration_Q4(2, 1);
        T_deceleration_Q4 = T_acceleration_Q4 * acceleration_Q4 / deceleration_Q4;
        velocity_max_Q4 = T_acceleration_Q4 * acceleration_Q4;
        T_max_velocity_Q4 = max_time_end - T_acceleration_Q4 - T_deceleration_Q4;
end

disp('Пересчитанная скорость')
disp('Q1 Q2 Q3')
[velocity_max_Q1 velocity_max_Q2 velocity_max_Q3] / K_stepsToDist
disp('Q4 Q5')
[velocity_max_Q4 velocity_max_Q5]
