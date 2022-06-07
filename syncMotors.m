clc; clear; close all;
%Задание ускорения разгона
acceleration_1 = 300 * 0.037;
acceleration_2 = 300 * 0.037;
acceleration_3 = 300 * 0.037;
acceleration_4 = 600 * 1.8;
acceleration_5 = 600 * 1.8;
%Задание ускорения торможения
braking_1 = 7000 * 0.037;
braking_2 = 7000 * 0.037;
braking_3 = 7000 * 0.037;
braking_4 = 1500 * 1.8;
braking_5 = 1500 * 1.8;
%Задание максимальных скоростей
velocity_max_1 = 900 * 0.037;
velocity_max_2 = 900 * 0.037;
velocity_max_3 = 900 * 0.037;
velocity_max_4 = 900 * 1.8;
velocity_max_5 = 900 * 1.8;
% Поправочные константы
K_Q_VIRTUAL = 0.745;
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

%Вычисление времени укорения
Time_acceleration_1 = velocity_max_1 / acceleration_1;
Time_acceleration_2 = velocity_max_2 / acceleration_2;
Time_acceleration_3 = velocity_max_3 / acceleration_3;
Time_acceleration_4 = velocity_max_4 / acceleration_4;
Time_acceleration_5 = velocity_max_5 / acceleration_5;

%Вычисление времени торможения
Time_braking_1 = velocity_max_1 / braking_1;
Time_braking_2 = velocity_max_2 / braking_2;
Time_braking_3 = velocity_max_3 / braking_3;
Time_braking_4 = velocity_max_4 / braking_4;
Time_braking_5 = velocity_max_5 / braking_5;

%Вычисление времени движения с максимальной скоростью
Time_velocity_1 = difference_Q1 / velocity_max_1 - (Time_acceleration_1 + Time_braking_1) / 2;
Time_velocity_2 = difference_Q2 / velocity_max_2 - (Time_acceleration_2 + Time_braking_2) / 2;
Time_velocity_3 = difference_Q3 / velocity_max_3 - (Time_acceleration_3 + Time_braking_3) / 2;
Time_velocity_4 = difference_Q4 / velocity_max_4 - (Time_acceleration_4 + Time_braking_4) / 2;
Time_velocity_5 = difference_Q5 / velocity_max_5 - (Time_acceleration_5 + Time_braking_5) / 2;

%Определение формы графика скорости первой обобщенной координаты
% Построение графиков обобщенных координат
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
stepTime = 0.00001;
%Определение формы графика скорости первой обобщенной координаты
% Построение графиков первой обобщенной координаты
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if Time_velocity_1 > 0
    Time_end_1 = Time_acceleration_1 + Time_braking_1 + Time_velocity_1;
    Time_acceleration = ['Время разгона: ', num2str(Time_acceleration_1), 'c'];
    Time_braking = ['Время торможения: ', num2str(Time_braking_1), 'c'];
    velocity_max = ['Максимальная скорость: ', num2str(velocity_max_1), 'м/с'];
    Time_velocity = ['Время движения с максимальной скоростью: ', num2str(Time_velocity_1), 'с'];
    Time_end = ['Суммарное время: ', num2str(Time_end_1), 'с'];
    difference_Q = ['Изменение координаты: ', num2str(difference_Q1)];
    disp('Ообобщенная координата: Q1')
    disp('Форма графика: Трапеция')
    disp(difference_Q)
    disp(Time_acceleration)
    disp(Time_braking)
    disp(velocity_max)
    disp(Time_velocity)
    disp(Time_end)
    disp('-----------------')
    graph_acceleration_time = 0:stepTime:Time_acceleration_1;
    graph_acceleration = acceleration_1 * graph_acceleration_time;
    graph_velocity_time = Time_acceleration_1:stepTime:Time_acceleration_1 + Time_velocity_1;
    graph_velocity = velocity_max_1 - 0 * graph_velocity_time;
    graph_braking_time = Time_acceleration_1 + Time_velocity_1:stepTime:Time_end_1;
    graph_braking = velocity_max_1 - braking_1 * (graph_braking_time - Time_acceleration_1 - Time_velocity_1);
    subplot(2, 3, 1)
    plot(graph_acceleration_time, graph_acceleration, 'G', graph_velocity_time, graph_velocity, 'G', graph_braking_time, graph_braking, 'G')
    ylabel('V, мм/с')
    xlabel('t, с')
    title('Скорость Q1')
else
    Time_acceleration_1 = sqrt((2 * difference_Q1) / (acceleration_1 * (1 + acceleration_1 / braking_1)));
    Time_braking_1 = Time_acceleration_1 * acceleration_1 / braking_1;
    Velocity_max_1 = Time_acceleration_1 * acceleration_1;
    Time_end_1 = Time_acceleration_1 + Time_braking_1;
    Time_acceleration = ['Время разгона: ', num2str(Time_acceleration_1), 'c'];
    Time_braking = ['Время торможения: ', num2str(Time_braking_1), 'c'];
    velocity_max = ['Максимальная скорость: ', num2str(Velocity_max_1), 'м/c'];
    Time_end = ['Суммарное время: ', num2str(Time_end_1), 'с'];
    difference_Q = ['Изменение координаты: ', num2str(difference_Q1)];
    disp('Ообобщенная координата: Q1')
    disp('Форма графика: Треугольник')
    disp(difference_Q)
    disp(Time_acceleration)
    disp(Time_braking)
    disp(velocity_max)
    disp(Time_end)
    disp('-----------------')
    graph_acceleration_time = 0:stepTime:Time_acceleration_1;
    graph_acceleration = acceleration_1 * graph_acceleration_time;
    graph_braking_time = Time_acceleration_1:stepTime:Time_braking_1 + Time_acceleration_1;
    graph_braking = Time_acceleration_1 * acceleration_1 - braking_1 * (graph_braking_time - Time_acceleration_1);
    subplot(2, 3, 1)
    plot(graph_acceleration_time, graph_acceleration, 'G', graph_braking_time, graph_braking, 'G')
    ylabel('V, мм/с')
    xlabel('t, с')
    title('Скорость Q1')
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Построение графиков второй обобщенной координаты
if Time_velocity_2 > 0
    Time_end_2 = Time_acceleration_2 + Time_braking_2 + Time_velocity_2;
    Time_acceleration = ['Время разгона: ', num2str(Time_acceleration_2), 'c'];
    Time_braking = ['Время торможения: ', num2str(Time_braking_2), 'c'];
    velocity_max = ['Максимальная скорость: ', num2str(velocity_max_2), 'м/с'];
    Time_velocity = ['Время движения с максимальной скоростью: ', num2str(Time_velocity_2), 'с'];
    Time_end = ['Суммарное время: ', num2str(Time_end_2), 'с'];
    difference_Q = ['Изменение координаты: ', num2str(difference_Q2)];
    disp('Ообобщенная координата: Q2')
    disp('Форма графика: Трапеция')
    disp(difference_Q)
    disp(Time_acceleration)
    disp(Time_braking)
    disp(velocity_max)
    disp(Time_velocity)
    disp(Time_end)
    disp('-----------------')
    graph_acceleration_time = 0:stepTime:Time_acceleration_2;
    graph_acceleration = acceleration_2 * graph_acceleration_time;
    graph_velocity_time = Time_acceleration_2:stepTime:Time_acceleration_2 + Time_velocity_2;
    graph_velocity = velocity_max_2 - 0 * graph_velocity_time;
    graph_braking_time = Time_acceleration_2 + Time_velocity_2:stepTime:Time_braking_2 + Time_acceleration_2 + Time_velocity_2;
    graph_braking = velocity_max_2 - braking_2 * (graph_braking_time - Time_acceleration_2 - Time_velocity_2);
    subplot(2, 3, 2)
    plot(graph_acceleration_time, graph_acceleration, 'B', graph_velocity_time, graph_velocity, 'B', graph_braking_time, graph_braking, 'B')
    %hold on;
    ylabel('V, мм/с')
    xlabel('t, с')
    title('Скорость Q2')
else
    Time_acceleration_2 = sqrt((2 * difference_Q2) / (acceleration_2 * (1 + acceleration_2 / braking_2)));
    Time_braking_2 = Time_acceleration_2 * acceleration_2 / braking_2;
    Velocity_max_2 = Time_acceleration_2 * acceleration_2;
    Time_end_2 = Time_acceleration_2 + Time_braking_2;
    Time_acceleration = ['Время разгона: ', num2str(Time_acceleration_2), 'c'];
    Time_braking = ['Время торможения: ', num2str(Time_braking_2), 'c'];
    velocity_max = ['Максимальная скорость: ', num2str(Velocity_max_2), 'м/c'];
    Time_end = ['Суммарное время: ', num2str(Time_end_2), 'с'];
    disp('Ообобщенная координата: Q2')
    disp('Форма графика: Треугольник')
    disp(difference_Q)
    disp(Time_acceleration)
    disp(Time_braking)
    disp(velocity_max)
    disp(Time_end)
    disp('-----------------')
    graph_acceleration_time = 0:stepTime:Time_acceleration_2;
    graph_acceleration = acceleration_2 * graph_acceleration_time;
    graph_braking_time = Time_acceleration_2:stepTime:Time_braking_2 + Time_acceleration_2;
    graph_braking = Time_acceleration_2 * acceleration_2 - braking_2 * (graph_braking_time - Time_acceleration_2);
    subplot(2, 3, 2)
    plot(graph_acceleration_time, graph_acceleration, 'B', graph_braking_time, graph_braking, 'B')
    %hold on;
    ylabel('V, мм/с')
    xlabel('t, с')
    title('Скорость Q2')
end

% Построение графиков третьей обобщенной координаты
if Time_velocity_3 > 0
    Time_end_3 = Time_acceleration_3 + Time_braking_3 + Time_velocity_3;
    Time_acceleration = ['Время разгона: ', num2str(Time_acceleration_3), 'c'];
    Time_braking = ['Время торможения: ', num2str(Time_braking_3), 'c'];
    velocity_max = ['Максимальная скорость: ', num2str(velocity_max_3), 'м/с'];
    Time_velocity = ['Время движения с максимальной скоростью: ', num2str(Time_velocity_3), 'с'];
    Time_end = ['Суммарное время: ', num2str(Time_end_3), 'с'];
    difference_Q = ['Изменение координаты: ', num2str(difference_Q3)];
    disp('Ообобщенная координата: Q3')
    disp('Форма графика: Трапеция')
    disp(difference_Q)
    disp(Time_acceleration)
    disp(Time_braking)
    disp(velocity_max)
    disp(Time_velocity)
    disp(Time_end)
    disp('-----------------')
    graph_acceleration_time = 0:stepTime:Time_acceleration_3;
    graph_acceleration = acceleration_3 * graph_acceleration_time;
    graph_velocity_time = Time_acceleration_3:stepTime:Time_acceleration_3 + Time_velocity_3;
    graph_velocity = velocity_max_3 - 0 * graph_velocity_time;
    graph_braking_time = Time_acceleration_3 + Time_velocity_3:stepTime:Time_braking_3 + Time_acceleration_3 + Time_velocity_3;
    graph_braking = velocity_max_3 - braking_3 * (graph_braking_time - Time_acceleration_3 - Time_velocity_3);
    subplot(2, 3, 3)
    plot(graph_acceleration_time, graph_acceleration, 'R', graph_velocity_time, graph_velocity, 'R', graph_braking_time, graph_braking, 'R')
    %hold on;
    ylabel('V, мм/с')
    xlabel('t, с')
    title('Скорость Q3')
else
    Time_acceleration_3 = sqrt((2 * difference_Q3) / (acceleration_3 * (1 + acceleration_3 / braking_3)));
    Time_braking_3 = Time_acceleration_3 * acceleration_3 / braking_3;
    Velocity_max_3 = Time_acceleration_3 * acceleration_3;
    Time_end_3 = Time_acceleration_3 + Time_braking_3;
    Time_acceleration = ['Время разгона: ', num2str(Time_acceleration_3), 'c'];
    Time_braking = ['Время торможения: ', num2str(Time_braking_3), 'c'];
    velocity_max = ['Максимальная скорость: ', num2str(Velocity_max_3), 'м/c'];
    Time_end = ['Суммарное время: ', num2str(Time_end_3), 'с'];
    difference_Q = ['Изменение координаты: ', num2str(difference_Q3)];
    disp('Ообобщенная координата: Q3')
    disp('Форма графика: Треугольник')
    disp(difference_Q)
    disp(Time_acceleration)
    disp(Time_braking)
    disp(velocity_max)
    disp(Time_end)
    disp('-----------------')
    graph_acceleration_time = 0:stepTime:Time_acceleration_3;
    graph_acceleration = acceleration_3 * graph_acceleration_time;
    graph_braking_time = Time_acceleration_3:stepTime:Time_braking_3 + Time_acceleration_3;
    graph_braking = Time_acceleration_3 * acceleration_3 - braking_3 * (graph_braking_time - Time_acceleration_3);
    subplot(2, 3, 3)
    plot(graph_acceleration_time, graph_acceleration, 'R', graph_braking_time, graph_braking, 'R')
    %hold on;
    ylabel('V, мм/с')
    xlabel('t, с')
    title('Скорость Q3')
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if Time_velocity_4 > 0
    Time_end_4 = Time_acceleration_4 + Time_braking_4 + Time_velocity_4;
    Time_acceleration = ['Время разгона: ', num2str(Time_acceleration_4), 'c'];
    Time_braking = ['Время торможения: ', num2str(Time_braking_4), 'c'];
    velocity_max = ['Максимальная скорость: ', num2str(velocity_max_4), 'м/с'];
    Time_velocity = ['Время движения с максимальной скоростью: ', num2str(Time_velocity_4), 'с'];
    Time_end = ['Суммарное время: ', num2str(Time_end_4), 'с'];
    difference_Q = ['Изменение координаты: ', num2str(difference_Q4)];
    disp('Ообобщенная координата: Q4')
    disp('Форма графика: Трапеция')
    disp(difference_Q)
    disp(Time_acceleration)
    disp(Time_braking)
    disp(velocity_max)
    disp(Time_velocity)
    disp(Time_end)
    disp('-----------------')
    graph_acceleration_time = 0:stepTime:Time_acceleration_4;
    graph_acceleration = acceleration_4 * graph_acceleration_time;
    graph_velocity_time = Time_acceleration_4:stepTime:Time_acceleration_4 + Time_velocity_4;
    graph_velocity = velocity_max_4 - 0 * graph_velocity_time;
    graph_braking_time = Time_acceleration_4 + Time_velocity_4:stepTime:Time_end_4;
    graph_braking = velocity_max_4 - braking_4 * (graph_braking_time - Time_acceleration_4 - Time_velocity_4);
    subplot(2, 3, 4)
    plot(graph_acceleration_time, graph_acceleration, 'G', graph_velocity_time, graph_velocity, 'G', graph_braking_time, graph_braking, 'G')
    %hold on;
    ylabel('V, град/с')
    xlabel('t, с')
    title('Скорость Q4')
else
    Time_acceleration_4 = sqrt((2 * difference_Q4) / (acceleration_4 * (1 + acceleration_4 / braking_4)));
    Time_braking_4 = Time_acceleration_4 * acceleration_4 / braking_4;
    Velocity_max_4 = Time_acceleration_4 * acceleration_4;
    Time_end_4 = Time_acceleration_4 + Time_braking_4;
    Time_acceleration = ['Время разгона: ', num2str(Time_acceleration_4), 'c'];
    Time_braking = ['Время торможения: ', num2str(Time_braking_4), 'c'];
    velocity_max = ['Максимальная скорость: ', num2str(Velocity_max_4), 'м/c'];
    Time_end = ['Суммарное время: ', num2str(Time_end_4), 'с'];
    difference_Q = ['Изменение координаты: ', num2str(difference_Q4)];
    disp('Ообобщенная координата: Q4')
    disp('Форма графика: Треугольник')
    disp(difference_Q)
    disp(Time_acceleration)
    disp(Time_braking)
    disp(velocity_max)
    disp(Time_end)
    disp('-----------------')
    graph_acceleration_time = 0:stepTime:Time_acceleration_4;
    graph_acceleration = acceleration_4 * graph_acceleration_time;
    graph_braking_time = Time_acceleration_4:stepTime:Time_braking_4 + Time_acceleration_4;
    graph_braking = Time_acceleration_4 * acceleration_4 - braking_4 * (graph_braking_time - Time_acceleration_4);
    subplot(2, 3, 4)
    plot(graph_acceleration_time, graph_acceleration, 'G', graph_braking_time, graph_braking, 'G')
    %hold on;
    ylabel('V, град/с')
    xlabel('t, с')
    title('Скорость Q4')
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if Time_velocity_5 > 0
    Time_end_5 = Time_acceleration_5 + Time_braking_5 + Time_velocity_5;
    Time_acceleration = ['Время разгона: ', num2str(Time_acceleration_5), 'c'];
    Time_braking = ['Время торможения: ', num2str(Time_braking_5), 'c'];
    velocity_max = ['Максимальная скорость: ', num2str(velocity_max_5), 'м/с'];
    Time_velocity = ['Время движения с максимальной скоростью: ', num2str(Time_velocity_5), 'с'];
    Time_end = ['Суммарное время: ', num2str(Time_end_5), 'с'];
    difference_Q = ['Изменение координаты: ', num2str(difference_Q5)];
    disp('Ообобщенная координата: Q5')
    disp('Форма графика: Трапеция')
    disp(difference_Q)
    disp(Time_acceleration)
    disp(Time_braking)
    disp(velocity_max)
    disp(Time_velocity)
    disp(Time_end)
    disp('-----------------')
    graph_acceleration_time = 0:stepTime:Time_acceleration_5;
    graph_acceleration = acceleration_5 * graph_acceleration_time;
    graph_velocity_time = Time_acceleration_5:stepTime:Time_acceleration_5 + Time_velocity_5;
    graph_velocity = velocity_max_5 - 0 * graph_velocity_time;
    graph_braking_time = Time_acceleration_5 + Time_velocity_5:stepTime:Time_end_5;
    graph_braking = velocity_max_5 - braking_5 * (graph_braking_time - Time_acceleration_5 - Time_velocity_5);
    subplot(2, 3, 5)
    plot(graph_acceleration_time, graph_acceleration, 'G', graph_velocity_time, graph_velocity, 'G', graph_braking_time, graph_braking, 'G')
    %hold on;
    ylabel('V, град/с')
    xlabel('t, с')
    title('Скорость Q5')
else
    Time_acceleration_5 = sqrt((2 * difference_Q5) / (acceleration_5 * (1 + acceleration_5 / braking_5)));
    Time_braking_5 = Time_acceleration_5 * acceleration_5 / braking_5;
    Velocity_max_5 = Time_acceleration_5 * acceleration_5;
    Time_end_5 = Time_acceleration_5 + Time_braking_5;
    Time_acceleration = ['Время разгона: ', num2str(Time_acceleration_5), 'c'];
    Time_braking = ['Время торможения: ', num2str(Time_braking_5), 'c'];
    velocity_max = ['Максимальная скорость: ', num2str(Velocity_max_5), 'м/c'];
    Time_end = ['Суммарное время: ', num2str(Time_end_5), 'с'];
    difference_Q = ['Изменение координаты: ', num2str(difference_Q5)];
    disp('Ообобщенная координата: Q5')
    disp('Форма графика: Треугольник')
    disp(difference_Q)
    disp(Time_acceleration)
    disp(Time_braking)
    disp(velocity_max)
    disp(Time_end)
    disp('-----------------')
    graph_acceleration_time = 0:stepTime:Time_acceleration_5;
    graph_acceleration = acceleration_5 * graph_acceleration_time;
    graph_braking_time = Time_acceleration_5:stepTime:Time_braking_5 + Time_acceleration_5;
    graph_braking = Time_acceleration_5 * acceleration_5 - braking_5 * (graph_braking_time - Time_acceleration_5);
    subplot(2, 3, 5)
    plot(graph_acceleration_time, graph_acceleration, 'G', graph_braking_time, graph_braking, 'G')
    %hold on;
    ylabel('V, град/с')
    xlabel('t, с')
    title('Скорость Q5')
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Time_end_array = [Time_end_1 Time_end_2 Time_end_3 Time_end_4 Time_end_5];
max_time_end = max(Time_end_array);
figure;
% Равенство времени
disp('ххххххххххххххххххх')
disp('Перерасчет времени:')
disp('ххххххххххххххххххх')

switch max_time_end
    case Time_end_1
        % Перерасчет второй координаты
        Time_acceleration_2 = roots([(1 + acceleration_2 / braking_2); - 2 * max_time_end; 2 * difference_Q2 / acceleration_2]);
        Time_acceleration_2 = Time_acceleration_2(2, 1);
        Time_braking_2 = Time_acceleration_2 * acceleration_2 / braking_2;
        velocity_max_2 = Time_acceleration_2 * acceleration_2;
        Time_velocity_2 = max_time_end - Time_acceleration_2 - Time_braking_2;
        Time_acceleration = ['Время разгона: ', num2str(Time_acceleration_2), 'c'];
        Time_braking = ['Время торможения: ', num2str(Time_braking_2), 'c'];
        velocity_max = ['Максимальная скорость: ', num2str(velocity_max_2), 'м/с'];
        Time_velocity = ['Время движения с максимальной скоростью: ', num2str(Time_velocity_2), 'с'];
        Time_end = ['Суммарное время: ', num2str(max_time_end), 'с'];
        difference_Q = ['Изменение координаты: ', num2str(difference_Q2)];
        disp('Ообобщенная координата: Q2')
        disp('Форма графика: Трапеция')
        disp(difference_Q)
        disp(Time_acceleration)
        disp(Time_braking)
        disp(velocity_max)
        disp(Time_velocity)
        disp(Time_end)
        disp('-----------------')
        graph_acceleration_time = 0:stepTime:Time_acceleration_2;
        graph_acceleration = acceleration_2 * graph_acceleration_time;
        graph_velocity_time = Time_acceleration_2:stepTime:Time_acceleration_2 + Time_velocity_2;
        graph_velocity = velocity_max_2 - 0 * graph_velocity_time;
        graph_braking_time = Time_acceleration_2 + Time_velocity_2:stepTime:max_time_end;
        graph_braking = velocity_max_2 - braking_2 * (graph_braking_time - Time_acceleration_2 - Time_velocity_2);
        liWi = 2;
        plot(graph_acceleration_time, graph_acceleration, 'R', graph_velocity_time, graph_velocity, 'R', graph_braking_time, graph_braking, 'R', 'LineWidth', liWi)
        hold on; grid on;
        ylabel('V, мм/с')
        xlabel('t, с')
        title('Скорость второй обобщенной координаты')
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Перерасчет третьей координаты
        Time_acceleration_3 = roots([(1 + acceleration_3 / braking_3); - 2 * max_time_end; 2 * difference_Q3 / acceleration_3]);
        Time_acceleration_3 = Time_acceleration_3(2, 1);
        Time_braking_3 = Time_acceleration_3 * acceleration_3 / braking_3;
        velocity_max_3 = Time_acceleration_3 * acceleration_3;
        Time_velocity_3 = max_time_end - Time_acceleration_3 - Time_braking_3;
        Time_acceleration = ['Время разгона: ', num2str(Time_acceleration_3), 'c'];
        Time_braking = ['Время торможения: ', num2str(Time_braking_3), 'c'];
        velocity_max = ['Максимальная скорость: ', num2str(velocity_max_3), 'м/с'];
        Time_velocity = ['Время движения с максимальной скоростью: ', num2str(Time_velocity_3), 'с'];
        Time_end = ['Суммарное время: ', num2str(max_time_end), 'с'];
        difference_Q = ['Изменение координаты: ', num2str(difference_Q3)];
        disp('Ообобщенная координата: Q3')
        disp('Форма графика: Трапеция')
        disp(difference_Q)
        disp(Time_acceleration)
        disp(Time_braking)
        disp(velocity_max)
        disp(Time_velocity)
        disp(Time_end)
        disp('-----------------')
        graph_acceleration_time = 0:stepTime:Time_acceleration_3;
        graph_acceleration = acceleration_3 * graph_acceleration_time;
        graph_velocity_time = Time_acceleration_3:stepTime:Time_acceleration_3 + Time_velocity_3;
        graph_velocity = velocity_max_3 - 0 * graph_velocity_time;
        graph_braking_time = Time_acceleration_3 + Time_velocity_3:stepTime:max_time_end;
        graph_braking = velocity_max_3 - braking_3 * (graph_braking_time - Time_acceleration_3 - Time_velocity_3);
        plot(graph_acceleration_time, graph_acceleration, 'G', graph_velocity_time, graph_velocity, 'G', graph_braking_time, graph_braking, 'G')
        hold on; grid on;
        ylabel('V, мм/с')
        xlabel('t, с')
        title('Скорость третьей обобщенной координаты')
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Перерасчет четвертой координаты
        Time_acceleration_4 = roots([(1 + acceleration_4 / braking_4); - 2 * max_time_end; 2 * difference_Q4 / acceleration_4]);
        Time_acceleration_4 = Time_acceleration_4(2, 1);
        Time_braking_4 = Time_acceleration_4 * acceleration_4 / braking_4;
        velocity_max_4 = Time_acceleration_4 * acceleration_4;
        Time_velocity_4 = max_time_end - Time_acceleration_4 - Time_braking_4;
        Time_acceleration = ['Время разгона: ', num2str(Time_acceleration_4), 'c'];
        Time_braking = ['Время торможения: ', num2str(Time_braking_4), 'c'];
        velocity_max = ['Максимальная скорость: ', num2str(velocity_max_4), 'м/с'];
        Time_velocity = ['Время движения с максимальной скоростью: ', num2str(Time_velocity_4), 'с'];
        Time_end = ['Суммарное время: ', num2str(max_time_end), 'с'];
        difference_Q = ['Изменение координаты: ', num2str(difference_Q4)];
        disp('Ообобщенная координата: Q4')
        disp('Форма графика: Трапеция')
        disp(difference_Q)
        disp(Time_acceleration)
        disp(Time_braking)
        disp(velocity_max)
        disp(Time_velocity)
        disp(Time_end)
        disp('-----------------')
        graph_acceleration_time = 0:stepTime:Time_acceleration_4;
        graph_acceleration = acceleration_4 * graph_acceleration_time;
        graph_velocity_time = Time_acceleration_4:stepTime:Time_acceleration_4 + Time_velocity_4;
        graph_velocity = velocity_max_4 - 0 * graph_velocity_time;
        graph_braking_time = Time_acceleration_4 + Time_velocity_4:stepTime:max_time_end;
        graph_braking = velocity_max_4 - braking_4 * (graph_braking_time - Time_acceleration_4 - Time_velocity_4);
        plot(graph_acceleration_time, graph_acceleration, '--R', graph_velocity_time, graph_velocity, '--R', graph_braking_time, graph_braking, '--R')
        hold on; grid on;
        ylabel('V, град/с')
        xlabel('t, с')
        title('Скорость четвертой обобщенной координаты')
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Перерасчет пятой координаты
        Time_acceleration_5 = roots([(1 + acceleration_5 / braking_5); - 2 * max_time_end; 2 * difference_Q5 / acceleration_5]);
        Time_acceleration_5 = Time_acceleration_5(2, 1);
        Time_braking_5 = Time_acceleration_5 * acceleration_5 / braking_5;
        velocity_max_5 = Time_acceleration_5 * acceleration_5;
        Time_velocity_5 = max_time_end - Time_acceleration_5 - Time_braking_5;
        Time_acceleration = ['Время разгона: ', num2str(Time_acceleration_5), 'c'];
        Time_braking = ['Время торможения: ', num2str(Time_braking_5), 'c'];
        velocity_max = ['Максимальная скорость: ', num2str(velocity_max_5), 'м/с'];
        Time_velocity = ['Время движения с максимальной скоростью: ', num2str(Time_velocity_5), 'с'];
        Time_end = ['Суммарное время: ', num2str(max_time_end), 'с'];
        difference_Q = ['Изменение координаты: ', num2str(difference_Q5)];
        disp('Ообобщенная координата: Q5')
        disp('Форма графика: Трапеция')
        disp(difference_Q)
        disp(Time_acceleration)
        disp(Time_braking)
        disp(velocity_max)
        disp(Time_velocity)
        disp(Time_end)
        disp('-----------------')
        graph_acceleration_time = 0:stepTime:Time_acceleration_5;
        graph_acceleration = acceleration_5 * graph_acceleration_time;
        graph_velocity_time = Time_acceleration_5:stepTime:Time_acceleration_5 + Time_velocity_5;
        graph_velocity = velocity_max_5 - 0 * graph_velocity_time;
        graph_braking_time = Time_acceleration_5 + Time_velocity_5:stepTime:max_time_end;
        graph_braking = velocity_max_5 - braking_5 * (graph_braking_time - Time_acceleration_5 - Time_velocity_5);
        plot(graph_acceleration_time, graph_acceleration, '--R', graph_velocity_time, graph_velocity, '--B', graph_braking_time, graph_braking, '--B')
        hold on; grid on;
        ylabel('V, град/с')
        xlabel('t, с')
        title('Скорость пятой обобщенной координаты')
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    case Time_end_2
        % Перерасчет первой координаты
        Time_acceleration_1 = roots([(1 + acceleration_1 / braking_1); - 2 * max_time_end; 2 * difference_Q1 / acceleration_1]);
        Time_acceleration_1 = Time_acceleration_1(2, 1);
        Time_braking_1 = Time_acceleration_1 * acceleration_1 / braking_1;
        velocity_max_1 = Time_acceleration_1 * acceleration_1;
        Time_velocity_1 = max_time_end - Time_acceleration_1 - Time_braking_1;
        Time_acceleration = ['Время разгона: ', num2str(Time_acceleration_1), 'c'];
        Time_braking = ['Время торможения: ', num2str(Time_braking_1), 'c'];
        velocity_max = ['Максимальная скорость: ', num2str(velocity_max_1), 'м/с'];
        Time_velocity = ['Время движения с максимальной скоростью: ', num2str(Time_velocity_1), 'с'];
        Time_end = ['Суммарное время: ', num2str(max_time_end), 'с'];
        difference_Q = ['Изменение координаты: ', num2str(difference_Q1)];
        disp('Ообобщенная координата: Q1')
        disp('Форма графика: Трапеция')
        disp(difference_Q)
        disp(Time_acceleration)
        disp(Time_braking)
        disp(velocity_max)
        disp(Time_velocity)
        disp(Time_end)
        disp('-----------------')
        graph_acceleration_time = 0:stepTime:Time_acceleration_1;
        graph_acceleration = acceleration_1 * graph_acceleration_time;
        graph_velocity_time = Time_acceleration_1:stepTime:Time_acceleration_1 + Time_velocity_1;
        graph_velocity = velocity_max_1 - 0 * graph_velocity_time;
        graph_braking_time = Time_acceleration_1 + Time_velocity_1:stepTime:max_time_end;
        graph_braking = velocity_max_1 - braking_1 * (graph_braking_time - Time_acceleration_1 - Time_velocity_1);
        plot(graph_acceleration_time, graph_acceleration, 'B', graph_velocity_time, graph_velocity, 'B', graph_braking_time, graph_braking, 'B')
        hold on; grid on;
        ylabel('V, мм/с')
        xlabel('t, с')
        title('Скорость первой обобщенной координаты')
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Перерасчет третьей координаты
        Time_acceleration_3 = roots([(1 + acceleration_3 / braking_3); - 2 * max_time_end; 2 * difference_Q3 / acceleration_3]);
        Time_acceleration_3 = Time_acceleration_3(2, 1);
        Time_braking_3 = Time_acceleration_3 * acceleration_3 / braking_3;
        velocity_max_3 = Time_acceleration_3 * acceleration_3;
        Time_velocity_3 = max_time_end - Time_acceleration_3 - Time_braking_3;
        Time_acceleration = ['Время разгона: ', num2str(Time_acceleration_3), 'c'];
        Time_braking = ['Время торможения: ', num2str(Time_braking_3), 'c'];
        velocity_max = ['Максимальная скорость: ', num2str(velocity_max_3), 'м/с'];
        Time_velocity = ['Время движения с максимальной скоростью: ', num2str(Time_velocity_3), 'с'];
        Time_end = ['Суммарное время: ', num2str(max_time_end), 'с'];
        difference_Q = ['Изменение координаты: ', num2str(difference_Q3)];
        disp('Ообобщенная координата: Q3')
        disp('Форма графика: Трапеция')
        disp(difference_Q)
        disp(Time_acceleration)
        disp(Time_braking)
        disp(velocity_max)
        disp(Time_velocity)
        disp(Time_end)
        disp('-----------------')
        graph_acceleration_time = 0:stepTime:Time_acceleration_3;
        graph_acceleration = acceleration_3 * graph_acceleration_time;
        graph_velocity_time = Time_acceleration_3:stepTime:Time_acceleration_3 + Time_velocity_3;
        graph_velocity = velocity_max_3 - 0 * graph_velocity_time;
        graph_braking_time = Time_acceleration_3 + Time_velocity_3:stepTime:max_time_end;
        graph_braking = velocity_max_3 - braking_3 * (graph_braking_time - Time_acceleration_3 - Time_velocity_3);
        plot(graph_acceleration_time, graph_acceleration, 'G', graph_velocity_time, graph_velocity, 'G', graph_braking_time, graph_braking, 'G')
        hold on; grid on;
        ylabel('V, мм/с')
        xlabel('t, с')
        title('Скорость третьей обобщенной координаты')
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Перерасчет четвертой координаты
        Time_acceleration_4 = roots([(1 + acceleration_4 / braking_4); - 2 * max_time_end; 2 * difference_Q4 / acceleration_4]);
        Time_acceleration_4 = Time_acceleration_4(2, 1);
        Time_braking_4 = Time_acceleration_4 * acceleration_4 / braking_4;
        velocity_max_4 = Time_acceleration_4 * acceleration_4;
        Time_velocity_4 = max_time_end - Time_acceleration_4 - Time_braking_4;
        Time_acceleration = ['Время разгона: ', num2str(Time_acceleration_4), 'c'];
        Time_braking = ['Время торможения: ', num2str(Time_braking_4), 'c'];
        velocity_max = ['Максимальная скорость: ', num2str(velocity_max_4), 'м/с'];
        Time_velocity = ['Время движения с максимальной скоростью: ', num2str(Time_velocity_4), 'с'];
        Time_end = ['Суммарное время: ', num2str(max_time_end), 'с'];
        difference_Q = ['Изменение координаты: ', num2str(difference_Q4)];
        disp('Ообобщенная координата: Q4')
        disp('Форма графика: Трапеция')
        disp(difference_Q)
        disp(Time_acceleration)
        disp(Time_braking)
        disp(velocity_max)
        disp(Time_velocity)
        disp(Time_end)
        disp('-----------------')
        graph_acceleration_time = 0:stepTime:Time_acceleration_4;
        graph_acceleration = acceleration_4 * graph_acceleration_time;
        graph_velocity_time = Time_acceleration_4:stepTime:Time_acceleration_4 + Time_velocity_4;
        graph_velocity = velocity_max_4 - 0 * graph_velocity_time;
        graph_braking_time = Time_acceleration_4 + Time_velocity_4:stepTime:max_time_end;
        graph_braking = velocity_max_4 - braking_4 * (graph_braking_time - Time_acceleration_4 - Time_velocity_4);
        plot(graph_acceleration_time, graph_acceleration, '--R', graph_velocity_time, graph_velocity, '--R', graph_braking_time, graph_braking, '--R')
        hold on; grid on;
        ylabel('V, град/с')
        xlabel('t, с')
        title('Скорость четвертой обобщенной координаты')
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Перерасчет пятой координаты
        Time_acceleration_5 = roots([(1 + acceleration_5 / braking_5); - 2 * max_time_end; 2 * difference_Q5 / acceleration_5]);
        Time_acceleration_5 = Time_acceleration_5(2, 1);
        Time_braking_5 = Time_acceleration_5 * acceleration_5 / braking_5;
        velocity_max_5 = Time_acceleration_5 * acceleration_5;
        Time_velocity_5 = max_time_end - Time_acceleration_5 - Time_braking_5;
        Time_acceleration = ['Время разгона: ', num2str(Time_acceleration_5), 'c'];
        Time_braking = ['Время торможения: ', num2str(Time_braking_5), 'c'];
        velocity_max = ['Максимальная скорость: ', num2str(velocity_max_5), 'м/с'];
        Time_velocity = ['Время движения с максимальной скоростью: ', num2str(Time_velocity_5), 'с'];
        Time_end = ['Суммарное время: ', num2str(max_time_end), 'с'];
        difference_Q = ['Изменение координаты: ', num2str(difference_Q5)];
        disp('Ообобщенная координата: Q5')
        disp('Форма графика: Трапеция')
        disp(difference_Q)
        disp(Time_acceleration)
        disp(Time_braking)
        disp(velocity_max)
        disp(Time_velocity)
        disp(Time_end)
        disp('-----------------')
        graph_acceleration_time = 0:stepTime:Time_acceleration_5;
        graph_acceleration = acceleration_5 * graph_acceleration_time;
        graph_velocity_time = Time_acceleration_5:stepTime:Time_acceleration_5 + Time_velocity_5;
        graph_velocity = velocity_max_5 - 0 * graph_velocity_time;
        graph_braking_time = Time_acceleration_5 + Time_velocity_5:stepTime:max_time_end;
        graph_braking = velocity_max_5 - braking_5 * (graph_braking_time - Time_acceleration_5 - Time_velocity_5);
        plot(graph_acceleration_time, graph_acceleration, '--R', graph_velocity_time, graph_velocity, '--B', graph_braking_time, graph_braking, '--B')
        hold on; grid on;
        ylabel('V, град/с')
        xlabel('t, с')
        title('Скорость пятой обобщенной координаты')
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    case Time_end_3
        % Перерасчет первой координаты
        Time_acceleration_1 = roots([(1 + acceleration_1 / braking_1); - 2 * max_time_end; 2 * difference_Q1 / acceleration_1]);
        Time_acceleration_1 = Time_acceleration_1(2, 1);
        Time_braking_1 = Time_acceleration_1 * acceleration_1 / braking_1;
        velocity_max_1 = Time_acceleration_1 * acceleration_1;
        Time_velocity_1 = max_time_end - Time_acceleration_1 - Time_braking_1;
        Time_acceleration = ['Время разгона: ', num2str(Time_acceleration_1), 'c'];
        Time_braking = ['Время торможения: ', num2str(Time_braking_1), 'c'];
        velocity_max = ['Максимальная скорость: ', num2str(velocity_max_1), 'м/с'];
        Time_velocity = ['Время движения с максимальной скоростью: ', num2str(Time_velocity_1), 'с'];
        Time_end = ['Суммарное время: ', num2str(max_time_end), 'с'];
        difference_Q = ['Изменение координаты: ', num2str(difference_Q1)];
        disp('Ообобщенная координата: Q1')
        disp('Форма графика: Трапеция')
        disp(difference_Q)
        disp(Time_acceleration)
        disp(Time_braking)
        disp(velocity_max)
        disp(Time_velocity)
        disp(Time_end)
        disp('-----------------')
        graph_acceleration_time = 0:stepTime:Time_acceleration_1;
        graph_acceleration = acceleration_1 * graph_acceleration_time;
        graph_velocity_time = Time_acceleration_1:stepTime:Time_acceleration_1 + Time_velocity_1;
        graph_velocity = velocity_max_1 - 0 * graph_velocity_time;
        graph_braking_time = Time_acceleration_1 + Time_velocity_1:stepTime:max_time_end;
        graph_braking = velocity_max_1 - braking_1 * (graph_braking_time - Time_acceleration_1 - Time_velocity_1);
        plot(graph_acceleration_time, graph_acceleration, 'B', graph_velocity_time, graph_velocity, 'B', graph_braking_time, graph_braking, 'B')
        hold on; grid on;
        ylabel('V, мм/с')
        xlabel('t, с')
        title('Скорость первой обобщенной координаты')
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Перерасчет второй координаты
        Time_acceleration_2 = roots([(1 + acceleration_2 / braking_2); - 2 * max_time_end; 2 * difference_Q2 / acceleration_2]);
        Time_acceleration_2 = Time_acceleration_2(2, 1);
        Time_braking_2 = Time_acceleration_2 * acceleration_2 / braking_2;
        velocity_max_2 = Time_acceleration_2 * acceleration_2;
        Time_velocity_2 = max_time_end - Time_acceleration_2 - Time_braking_2;
        Time_acceleration = ['Время разгона: ', num2str(Time_acceleration_2), 'c'];
        Time_braking = ['Время торможения: ', num2str(Time_braking_2), 'c'];
        velocity_max = ['Максимальная скорость: ', num2str(velocity_max_2), 'м/с'];
        Time_velocity = ['Время движения с максимальной скоростью: ', num2str(Time_velocity_2), 'с'];
        Time_end = ['Суммарное время: ', num2str(max_time_end), 'с'];
        difference_Q = ['Изменение координаты: ', num2str(difference_Q2)];
        disp('Ообобщенная координата: Q2')
        disp('Форма графика: Трапеция')
        disp(difference_Q)
        disp(Time_acceleration)
        disp(Time_braking)
        disp(velocity_max)
        disp(Time_velocity)
        disp(Time_end)
        disp('-----------------')
        graph_acceleration_time = 0:stepTime:Time_acceleration_2;
        graph_acceleration = acceleration_2 * graph_acceleration_time;
        graph_velocity_time = Time_acceleration_2:stepTime:Time_acceleration_2 + Time_velocity_2;
        graph_velocity = velocity_max_2 - 0 * graph_velocity_time;
        graph_braking_time = Time_acceleration_2 + Time_velocity_2:stepTime:max_time_end;
        graph_braking = velocity_max_2 - braking_2 * (graph_braking_time - Time_acceleration_2 - Time_velocity_2);
        liWi = 2;
        plot(graph_acceleration_time, graph_acceleration, 'R', graph_velocity_time, graph_velocity, 'R', graph_braking_time, graph_braking, 'R', 'LineWidth', liWi)
        hold on; grid on;
        ylabel('V, мм/с')
        xlabel('t, с')
        title('Скорость второй обобщенной координаты')
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Перерасчет четвертой координаты
        Time_acceleration_4 = roots([(1 + acceleration_4 / braking_4); - 2 * max_time_end; 2 * difference_Q4 / acceleration_4]);
        Time_acceleration_4 = Time_acceleration_4(2, 1);
        Time_braking_4 = Time_acceleration_4 * acceleration_4 / braking_4;
        velocity_max_4 = Time_acceleration_4 * acceleration_4;
        Time_velocity_4 = max_time_end - Time_acceleration_4 - Time_braking_4;
        Time_acceleration = ['Время разгона: ', num2str(Time_acceleration_4), 'c'];
        Time_braking = ['Время торможения: ', num2str(Time_braking_4), 'c'];
        velocity_max = ['Максимальная скорость: ', num2str(velocity_max_4), 'м/с'];
        Time_velocity = ['Время движения с максимальной скоростью: ', num2str(Time_velocity_4), 'с'];
        Time_end = ['Суммарное время: ', num2str(max_time_end), 'с'];
        difference_Q = ['Изменение координаты: ', num2str(difference_Q4)];
        disp('Ообобщенная координата: Q4')
        disp('Форма графика: Трапеция')
        disp(difference_Q)
        disp(Time_acceleration)
        disp(Time_braking)
        disp(velocity_max)
        disp(Time_velocity)
        disp(Time_end)
        disp('-----------------')
        graph_acceleration_time = 0:stepTime:Time_acceleration_4;
        graph_acceleration = acceleration_4 * graph_acceleration_time;
        graph_velocity_time = Time_acceleration_4:stepTime:Time_acceleration_4 + Time_velocity_4;
        graph_velocity = velocity_max_4 - 0 * graph_velocity_time;
        graph_braking_time = Time_acceleration_4 + Time_velocity_4:stepTime:max_time_end;
        graph_braking = velocity_max_4 - braking_4 * (graph_braking_time - Time_acceleration_4 - Time_velocity_4);
        plot(graph_acceleration_time, graph_acceleration, '--R', graph_velocity_time, graph_velocity, '--R', graph_braking_time, graph_braking, '--R')
        hold on; grid on;
        ylabel('V, град/с')
        xlabel('t, с')
        title('Скорость четвертой обобщенной координаты')
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Перерасчет пятой координаты
        Time_acceleration_5 = roots([(1 + acceleration_5 / braking_5); - 2 * max_time_end; 2 * difference_Q5 / acceleration_5]);
        Time_acceleration_5 = Time_acceleration_5(2, 1);
        Time_braking_5 = Time_acceleration_5 * acceleration_5 / braking_5;
        velocity_max_5 = Time_acceleration_5 * acceleration_5;
        Time_velocity_5 = max_time_end - Time_acceleration_5 - Time_braking_5;
        Time_acceleration = ['Время разгона: ', num2str(Time_acceleration_5), 'c'];
        Time_braking = ['Время торможения: ', num2str(Time_braking_5), 'c'];
        velocity_max = ['Максимальная скорость: ', num2str(velocity_max_5), 'м/с'];
        Time_velocity = ['Время движения с максимальной скоростью: ', num2str(Time_velocity_5), 'с'];
        Time_end = ['Суммарное время: ', num2str(max_time_end), 'с'];
        difference_Q = ['Изменение координаты: ', num2str(difference_Q5)];
        disp('Ообобщенная координата: Q5')
        disp('Форма графика: Трапеция')
        disp(difference_Q)
        disp(Time_acceleration)
        disp(Time_braking)
        disp(velocity_max)
        disp(Time_velocity)
        disp(Time_end)
        disp('-----------------')
        graph_acceleration_time = 0:stepTime:Time_acceleration_5;
        graph_acceleration = acceleration_5 * graph_acceleration_time;
        graph_velocity_time = Time_acceleration_5:stepTime:Time_acceleration_5 + Time_velocity_5;
        graph_velocity = velocity_max_5 - 0 * graph_velocity_time;
        graph_braking_time = Time_acceleration_5 + Time_velocity_5:stepTime:max_time_end;
        graph_braking = velocity_max_5 - braking_5 * (graph_braking_time - Time_acceleration_5 - Time_velocity_5);
        plot(graph_acceleration_time, graph_acceleration, '--R', graph_velocity_time, graph_velocity, '--B', graph_braking_time, graph_braking, '--B')
        hold on; grid on;
        ylabel('V, град/с')
        xlabel('t, с')
        title('Скорость пятой обобщенной координаты')
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    case Time_end_4
        % Перерасчет первой координаты
        Time_acceleration_1 = roots([(1 + acceleration_1 / braking_1); - 2 * max_time_end; 2 * difference_Q1 / acceleration_1]);
        Time_acceleration_1 = Time_acceleration_1(2, 1);
        Time_braking_1 = Time_acceleration_1 * acceleration_1 / braking_1;
        velocity_max_1 = Time_acceleration_1 * acceleration_1;
        Time_velocity_1 = max_time_end - Time_acceleration_1 - Time_braking_1;
        Time_acceleration = ['Время разгона: ', num2str(Time_acceleration_1), 'c'];
        Time_braking = ['Время торможения: ', num2str(Time_braking_1), 'c'];
        velocity_max = ['Максимальная скорость: ', num2str(velocity_max_1), 'м/с'];
        Time_velocity = ['Время движения с максимальной скоростью: ', num2str(Time_velocity_1), 'с'];
        Time_end = ['Суммарное время: ', num2str(max_time_end), 'с'];
        difference_Q = ['Изменение координаты: ', num2str(difference_Q1)];
        disp('Ообобщенная координата: Q1')
        disp('Форма графика: Трапеция')
        disp(difference_Q)
        disp(Time_acceleration)
        disp(Time_braking)
        disp(velocity_max)
        disp(Time_velocity)
        disp(Time_end)
        disp('-----------------')
        graph_acceleration_time = 0:stepTime:Time_acceleration_1;
        graph_acceleration = acceleration_1 * graph_acceleration_time;
        graph_velocity_time = Time_acceleration_1:stepTime:Time_acceleration_1 + Time_velocity_1;
        graph_velocity = velocity_max_1 - 0 * graph_velocity_time;
        graph_braking_time = Time_acceleration_1 + Time_velocity_1:stepTime:max_time_end;
        graph_braking = velocity_max_1 - braking_1 * (graph_braking_time - Time_acceleration_1 - Time_velocity_1);
        plot(graph_acceleration_time, graph_acceleration, 'B', graph_velocity_time, graph_velocity, 'B', graph_braking_time, graph_braking, 'B')
        hold on; grid on;
        ylabel('V, мм/с')
        xlabel('t, с')
        title('Скорость первой обобщенной координаты')
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Перерасчет второй координаты
        Time_acceleration_2 = roots([(1 + acceleration_2 / braking_2); - 2 * max_time_end; 2 * difference_Q2 / acceleration_2]);
        Time_acceleration_2 = Time_acceleration_2(2, 1);
        Time_braking_2 = Time_acceleration_2 * acceleration_2 / braking_2;
        velocity_max_2 = Time_acceleration_2 * acceleration_2;
        Time_velocity_2 = max_time_end - Time_acceleration_2 - Time_braking_2;
        Time_acceleration = ['Время разгона: ', num2str(Time_acceleration_2), 'c'];
        Time_braking = ['Время торможения: ', num2str(Time_braking_2), 'c'];
        velocity_max = ['Максимальная скорость: ', num2str(velocity_max_2), 'м/с'];
        Time_velocity = ['Время движения с максимальной скоростью: ', num2str(Time_velocity_2), 'с'];
        Time_end = ['Суммарное время: ', num2str(max_time_end), 'с'];
        difference_Q = ['Изменение координаты: ', num2str(difference_Q2)];
        disp('Ообобщенная координата: Q2')
        disp('Форма графика: Трапеция')
        disp(difference_Q)
        disp(Time_acceleration)
        disp(Time_braking)
        disp(velocity_max)
        disp(Time_velocity)
        disp(Time_end)
        disp('-----------------')
        graph_acceleration_time = 0:stepTime:Time_acceleration_2;
        graph_acceleration = acceleration_2 * graph_acceleration_time;
        graph_velocity_time = Time_acceleration_2:stepTime:Time_acceleration_2 + Time_velocity_2;
        graph_velocity = velocity_max_2 - 0 * graph_velocity_time;
        graph_braking_time = Time_acceleration_2 + Time_velocity_2:stepTime:max_time_end;
        graph_braking = velocity_max_2 - braking_2 * (graph_braking_time - Time_acceleration_2 - Time_velocity_2);
        liWi = 2;
        plot(graph_acceleration_time, graph_acceleration, 'R', graph_velocity_time, graph_velocity, 'R', graph_braking_time, graph_braking, 'R', 'LineWidth', liWi)
        hold on; grid on;
        ylabel('V, мм/с')
        xlabel('t, с')
        title('Скорость второй обобщенной координаты')
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Перерасчет третьей координаты
        Time_acceleration_3 = roots([(1 + acceleration_3 / braking_3); - 2 * max_time_end; 2 * difference_Q3 / acceleration_3]);
        Time_acceleration_3 = Time_acceleration_3(2, 1);
        Time_braking_3 = Time_acceleration_3 * acceleration_3 / braking_3;
        velocity_max_3 = Time_acceleration_3 * acceleration_3;
        Time_velocity_3 = max_time_end - Time_acceleration_3 - Time_braking_3;
        Time_acceleration = ['Время разгона: ', num2str(Time_acceleration_3), 'c'];
        Time_braking = ['Время торможения: ', num2str(Time_braking_3), 'c'];
        velocity_max = ['Максимальная скорость: ', num2str(velocity_max_3), 'м/с'];
        Time_velocity = ['Время движения с максимальной скоростью: ', num2str(Time_velocity_3), 'с'];
        Time_end = ['Суммарное время: ', num2str(max_time_end), 'с'];
        difference_Q = ['Изменение координаты: ', num2str(difference_Q3)];
        disp('Ообобщенная координата: Q3')
        disp('Форма графика: Трапеция')
        disp(difference_Q)
        disp(Time_acceleration)
        disp(Time_braking)
        disp(velocity_max)
        disp(Time_velocity)
        disp(Time_end)
        disp('-----------------')
        graph_acceleration_time = 0:stepTime:Time_acceleration_3;
        graph_acceleration = acceleration_3 * graph_acceleration_time;
        graph_velocity_time = Time_acceleration_3:stepTime:Time_acceleration_3 + Time_velocity_3;
        graph_velocity = velocity_max_3 - 0 * graph_velocity_time;
        graph_braking_time = Time_acceleration_3 + Time_velocity_3:stepTime:max_time_end;
        graph_braking = velocity_max_3 - braking_3 * (graph_braking_time - Time_acceleration_3 - Time_velocity_3);
        plot(graph_acceleration_time, graph_acceleration, 'G', graph_velocity_time, graph_velocity, 'G', graph_braking_time, graph_braking, 'G')
        hold on; grid on;
        ylabel('V, мм/с')
        xlabel('t, с')
        title('Скорость третьей обобщенной координаты')
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Перерасчет пятой координаты
        Time_acceleration_5 = roots([(1 + acceleration_5 / braking_5); - 2 * max_time_end; 2 * difference_Q5 / acceleration_5]);
        Time_acceleration_5 = Time_acceleration_5(2, 1);
        Time_braking_5 = Time_acceleration_5 * acceleration_5 / braking_5;
        velocity_max_5 = Time_acceleration_5 * acceleration_5;
        Time_velocity_5 = max_time_end - Time_acceleration_5 - Time_braking_5;
        Time_acceleration = ['Время разгона: ', num2str(Time_acceleration_5), 'c'];
        Time_braking = ['Время торможения: ', num2str(Time_braking_5), 'c'];
        velocity_max = ['Максимальная скорость: ', num2str(velocity_max_5), 'м/с'];
        Time_velocity = ['Время движения с максимальной скоростью: ', num2str(Time_velocity_5), 'с'];
        Time_end = ['Суммарное время: ', num2str(max_time_end), 'с'];
        difference_Q = ['Изменение координаты: ', num2str(difference_Q5)];
        disp('Ообобщенная координата: Q5')
        disp('Форма графика: Трапеция')
        disp(difference_Q)
        disp(Time_acceleration)
        disp(Time_braking)
        disp(velocity_max)
        disp(Time_velocity)
        disp(Time_end)
        disp('-----------------')
        graph_acceleration_time = 0:stepTime:Time_acceleration_5;
        graph_acceleration = acceleration_5 * graph_acceleration_time;
        graph_velocity_time = Time_acceleration_5:stepTime:Time_acceleration_5 + Time_velocity_5;
        graph_velocity = velocity_max_5 - 0 * graph_velocity_time;
        graph_braking_time = Time_acceleration_5 + Time_velocity_5:stepTime:max_time_end;
        graph_braking = velocity_max_5 - braking_5 * (graph_braking_time - Time_acceleration_5 - Time_velocity_5);
        plot(graph_acceleration_time, graph_acceleration, '--R', graph_velocity_time, graph_velocity, '--B', graph_braking_time, graph_braking, '--B')
        hold on; grid on;
        ylabel('V, град/с')
        xlabel('t, с')
        title('Скорость пятой обобщенной координаты')
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    case Time_end_5
        % Перерасчет первой координаты
        Time_acceleration_1 = roots([(1 + acceleration_1 / braking_1); - 2 * max_time_end; 2 * difference_Q1 / acceleration_1]);
        Time_acceleration_1 = Time_acceleration_1(2, 1);
        Time_braking_1 = Time_acceleration_1 * acceleration_1 / braking_1;
        velocity_max_1 = Time_acceleration_1 * acceleration_1;
        Time_velocity_1 = max_time_end - Time_acceleration_1 - Time_braking_1;
        Time_acceleration = ['Время разгона: ', num2str(Time_acceleration_1), 'c'];
        Time_braking = ['Время торможения: ', num2str(Time_braking_1), 'c'];
        velocity_max = ['Максимальная скорость: ', num2str(velocity_max_1), 'м/с'];
        Time_velocity = ['Время движения с максимальной скоростью: ', num2str(Time_velocity_1), 'с'];
        Time_end = ['Суммарное время: ', num2str(max_time_end), 'с'];
        difference_Q = ['Изменение координаты: ', num2str(difference_Q1)];
        disp('Ообобщенная координата: Q1')
        disp('Форма графика: Трапеция')
        disp(difference_Q)
        disp(Time_acceleration)
        disp(Time_braking)
        disp(velocity_max)
        disp(Time_velocity)
        disp(Time_end)
        disp('-----------------')
        graph_acceleration_time = 0:stepTime:Time_acceleration_1;
        graph_acceleration = acceleration_1 * graph_acceleration_time;
        graph_velocity_time = Time_acceleration_1:stepTime:Time_acceleration_1 + Time_velocity_1;
        graph_velocity = velocity_max_1 - 0 * graph_velocity_time;
        graph_braking_time = Time_acceleration_1 + Time_velocity_1:stepTime:max_time_end;
        graph_braking = velocity_max_1 - braking_1 * (graph_braking_time - Time_acceleration_1 - Time_velocity_1);
        plot(graph_acceleration_time, graph_acceleration, 'B', graph_velocity_time, graph_velocity, 'B', graph_braking_time, graph_braking, 'B')
        hold on; grid on;
        ylabel('V, мм/с')
        xlabel('t, с')
        title('Скорость первой обобщенной координаты')
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Перерасчет второй координаты
        Time_acceleration_2 = roots([(1 + acceleration_2 / braking_2); - 2 * max_time_end; 2 * difference_Q2 / acceleration_2]);
        Time_acceleration_2 = Time_acceleration_2(2, 1);
        Time_braking_2 = Time_acceleration_2 * acceleration_2 / braking_2;
        velocity_max_2 = Time_acceleration_2 * acceleration_2;
        Time_velocity_2 = max_time_end - Time_acceleration_2 - Time_braking_2;
        Time_acceleration = ['Время разгона: ', num2str(Time_acceleration_2), 'c'];
        Time_braking = ['Время торможения: ', num2str(Time_braking_2), 'c'];
        velocity_max = ['Максимальная скорость: ', num2str(velocity_max_2), 'м/с'];
        Time_velocity = ['Время движения с максимальной скоростью: ', num2str(Time_velocity_2), 'с'];
        Time_end = ['Суммарное время: ', num2str(max_time_end), 'с'];
        difference_Q = ['Изменение координаты: ', num2str(difference_Q2)];
        disp('Ообобщенная координата: Q2')
        disp('Форма графика: Трапеция')
        disp(difference_Q)
        disp(Time_acceleration)
        disp(Time_braking)
        disp(velocity_max)
        disp(Time_velocity)
        disp(Time_end)
        disp('-----------------')
        graph_acceleration_time = 0:stepTime:Time_acceleration_2;
        graph_acceleration = acceleration_2 * graph_acceleration_time;
        graph_velocity_time = Time_acceleration_2:stepTime:Time_acceleration_2 + Time_velocity_2;
        graph_velocity = velocity_max_2 - 0 * graph_velocity_time;
        graph_braking_time = Time_acceleration_2 + Time_velocity_2:stepTime:max_time_end;
        graph_braking = velocity_max_2 - braking_2 * (graph_braking_time - Time_acceleration_2 - Time_velocity_2);
        liWi = 2;
        plot(graph_acceleration_time, graph_acceleration, 'R', graph_velocity_time, graph_velocity, 'R', graph_braking_time, graph_braking, 'R', 'LineWidth', liWi)
        hold on; grid on;
        ylabel('V, мм/с')
        xlabel('t, с')
        title('Скорость второй обобщенной координаты')
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Перерасчет третьей координаты
        Time_acceleration_3 = roots([(1 + acceleration_3 / braking_3); - 2 * max_time_end; 2 * difference_Q3 / acceleration_3]);
        Time_acceleration_3 = Time_acceleration_3(2, 1);
        Time_braking_3 = Time_acceleration_3 * acceleration_3 / braking_3;
        velocity_max_3 = Time_acceleration_3 * acceleration_3;
        Time_velocity_3 = max_time_end - Time_acceleration_3 - Time_braking_3;
        Time_acceleration = ['Время разгона: ', num2str(Time_acceleration_3), 'c'];
        Time_braking = ['Время торможения: ', num2str(Time_braking_3), 'c'];
        velocity_max = ['Максимальная скорость: ', num2str(velocity_max_3), 'м/с'];
        Time_velocity = ['Время движения с максимальной скоростью: ', num2str(Time_velocity_3), 'с'];
        Time_end = ['Суммарное время: ', num2str(max_time_end), 'с'];
        difference_Q = ['Изменение координаты: ', num2str(difference_Q3)];
        disp('Ообобщенная координата: Q3')
        disp('Форма графика: Трапеция')
        disp(difference_Q)
        disp(Time_acceleration)
        disp(Time_braking)
        disp(velocity_max)
        disp(Time_velocity)
        disp(Time_end)
        disp('-----------------')
        graph_acceleration_time = 0:stepTime:Time_acceleration_3;
        graph_acceleration = acceleration_3 * graph_acceleration_time;
        graph_velocity_time = Time_acceleration_3:stepTime:Time_acceleration_3 + Time_velocity_3;
        graph_velocity = velocity_max_3 - 0 * graph_velocity_time;
        graph_braking_time = Time_acceleration_3 + Time_velocity_3:stepTime:max_time_end;
        graph_braking = velocity_max_3 - braking_3 * (graph_braking_time - Time_acceleration_3 - Time_velocity_3);
        plot(graph_acceleration_time, graph_acceleration, 'G', graph_velocity_time, graph_velocity, 'G', graph_braking_time, graph_braking, 'G')
        hold on; grid on;
        ylabel('V, мм/с')
        xlabel('t, с')
        title('Скорость третьей обобщенной координаты')
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Перерасчет четвертой координаты
        Time_acceleration_4 = roots([(1 + acceleration_4 / braking_4); - 2 * max_time_end; 2 * difference_Q4 / acceleration_4]);
        Time_acceleration_4 = Time_acceleration_4(2, 1);
        Time_braking_4 = Time_acceleration_4 * acceleration_4 / braking_4;
        velocity_max_4 = Time_acceleration_4 * acceleration_4;
        Time_velocity_4 = max_time_end - Time_acceleration_4 - Time_braking_4;
        Time_acceleration = ['Время разгона: ', num2str(Time_acceleration_4), 'c'];
        Time_braking = ['Время торможения: ', num2str(Time_braking_4), 'c'];
        velocity_max = ['Максимальная скорость: ', num2str(velocity_max_4), 'м/с'];
        Time_velocity = ['Время движения с максимальной скоростью: ', num2str(Time_velocity_4), 'с'];
        Time_end = ['Суммарное время: ', num2str(max_time_end), 'с'];
        difference_Q = ['Изменение координаты: ', num2str(difference_Q4)];
        disp('Ообобщенная координата: Q4')
        disp('Форма графика: Трапеция')
        disp(difference_Q)
        disp(Time_acceleration)
        disp(Time_braking)
        disp(velocity_max)
        disp(Time_velocity)
        disp(Time_end)
        disp('-----------------')
        graph_acceleration_time = 0:stepTime:Time_acceleration_4;
        graph_acceleration = acceleration_4 * graph_acceleration_time;
        graph_velocity_time = Time_acceleration_4:stepTime:Time_acceleration_4 + Time_velocity_4;
        graph_velocity = velocity_max_4 - 0 * graph_velocity_time;
        graph_braking_time = Time_acceleration_4 + Time_velocity_4:stepTime:max_time_end;
        graph_braking = velocity_max_4 - braking_4 * (graph_braking_time - Time_acceleration_4 - Time_velocity_4);
        plot(graph_acceleration_time, graph_acceleration, '--R', graph_velocity_time, graph_velocity, '--R', graph_braking_time, graph_braking, '--R')
        hold on;
        grid on;
        ylabel('V, град/с')
        xlabel('t, с')
        title('Скорость четвертой обобщенной координаты')
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end
