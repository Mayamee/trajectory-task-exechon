function [velocity_max_Q, max_time_end] = syncM5(Qi, Q0, VELM, ACC, DEC)
    %Задание ускорения разгона
    acceleration_Q = ACC;
    % %Задание ускорения торможения
    deceleration_Q = DEC;
    % %Задание максимальных скоростей
    velocity_max_Q = VELM;
    % %Задание обобщенных координат
    Q_1 = Qi;
    Q_0 = Q0;
    %Вычисляем изменение обобщенных координат
    difference_Q = abs(Q_1 - Q_0);
    %Вычисление времени разгона
    T_acceleration_Q = velocity_max_Q ./ acceleration_Q;
    %Вычисление времени торможения
    T_deceleration_Q = velocity_max_Q ./ deceleration_Q;
    %Вычисление времени движения с максимальной скоростью
    T_max_velocity_Q = difference_Q ./ velocity_max_Q - (T_acceleration_Q + T_deceleration_Q) ./ 2;

    for i = 1:5

        if T_max_velocity_Q(i) > 0
            Time_END_Q(i) = T_acceleration_Q(i) + T_deceleration_Q(i) + T_max_velocity_Q(i);
        else
            T_acceleration_Q(i) = sqrt((2 * difference_Q(i)) / (acceleration_Q(i) * (1 + acceleration_Q(i) / deceleration_Q(i))));
            T_deceleration_Q(i) = T_acceleration_Q(i) * acceleration_Q(i) / deceleration_Q(i);
            Time_END_Q(i) = T_acceleration_Q(i) + T_deceleration_Q(i);
        end

    end

    max_time_end = max(Time_END_Q);
    % Перерасчет времени
    switch max_time_end

        case Time_END_Q(1)
            % Перерасчет второй координаты
            [velocity_max_Q(2), T_max_velocity_Q(2)] = syncM5_Resolve_FNC(difference_Q(2), acceleration_Q(2), deceleration_Q(2), max_time_end);
            % Перерасчет третьей координаты
            [velocity_max_Q(3), T_max_velocity_Q(3)] = syncM5_Resolve_FNC(difference_Q(3), acceleration_Q(3), deceleration_Q(3), max_time_end);
            % Перерасчет четвертой координаты
            [velocity_max_Q(4), T_max_velocity_Q(4)] = syncM5_Resolve_FNC(difference_Q(4), acceleration_Q(4), deceleration_Q(4), max_time_end);
            % Перерасчет пятой координаты
            [velocity_max_Q(5), T_max_velocity_Q(5)] = syncM5_Resolve_FNC(difference_Q(5), acceleration_Q(5), deceleration_Q(5), max_time_end);

        case Time_END_Q(2)
            % Перерасчет первой координаты
            [velocity_max_Q(1), T_max_velocity_Q(1)] = syncM5_Resolve_FNC(difference_Q(1), acceleration_Q(1), deceleration_Q(1), max_time_end);
            % Перерасчет третьей координаты
            [velocity_max_Q(3), T_max_velocity_Q(3)] = syncM5_Resolve_FNC(difference_Q(3), acceleration_Q(3), deceleration_Q(3), max_time_end);
            % Перерасчет четвертой координаты
            [velocity_max_Q(4), T_max_velocity_Q(4)] = syncM5_Resolve_FNC(difference_Q(4), acceleration_Q(4), deceleration_Q(4), max_time_end);
            % Перерасчет пятой координаты
            [velocity_max_Q(5), T_max_velocity_Q(5)] = syncM5_Resolve_FNC(difference_Q(5), acceleration_Q(5), deceleration_Q(5), max_time_end);

        case Time_END_Q(3)
            % Перерасчет первой координаты
            [velocity_max_Q(1), T_max_velocity_Q(1)] = syncM5_Resolve_FNC(difference_Q(1), acceleration_Q(1), deceleration_Q(1), max_time_end);
            % Перерасчет второй координаты
            [velocity_max_Q(2), T_max_velocity_Q(2)] = syncM5_Resolve_FNC(difference_Q(2), acceleration_Q(2), deceleration_Q(2), max_time_end);
            % Перерасчет четвертой координаты
            [velocity_max_Q(4), T_max_velocity_Q(4)] = syncM5_Resolve_FNC(difference_Q(4), acceleration_Q(4), deceleration_Q(4), max_time_end);
            % Перерасчет пятой координаты
            [velocity_max_Q(5), T_max_velocity_Q(5)] = syncM5_Resolve_FNC(difference_Q(5), acceleration_Q(5), deceleration_Q(5), max_time_end);

        case Time_END_Q(4)
            % Перерасчет первой координаты
            [velocity_max_Q(1), T_max_velocity_Q(1)] = syncM5_Resolve_FNC(difference_Q(1), acceleration_Q(1), deceleration_Q(1), max_time_end);
            % Перерасчет второй координаты
            [velocity_max_Q(2), T_max_velocity_Q(2)] = syncM5_Resolve_FNC(difference_Q(2), acceleration_Q(2), deceleration_Q(2), max_time_end);
            % Перерасчет третьей координаты
            [velocity_max_Q(3), T_max_velocity_Q(3)] = syncM5_Resolve_FNC(difference_Q(3), acceleration_Q(3), deceleration_Q(3), max_time_end);
            % Перерасчет пятой координаты
            [velocity_max_Q(5), T_max_velocity_Q(5)] = syncM5_Resolve_FNC(difference_Q(5), acceleration_Q(5), deceleration_Q(5), max_time_end);
        case Time_END_Q(5)
            % Перерасчет первой координаты
            [velocity_max_Q(1), T_max_velocity_Q(1)] = syncM5_Resolve_FNC(difference_Q(1), acceleration_Q(1), deceleration_Q(1), max_time_end);
            % Перерасчет второй координаты
            [velocity_max_Q(2), T_max_velocity_Q(2)] = syncM5_Resolve_FNC(difference_Q(2), acceleration_Q(2), deceleration_Q(2), max_time_end);
            % Перерасчет третьей координаты
            [velocity_max_Q(3), T_max_velocity_Q(3)] = syncM5_Resolve_FNC(difference_Q(3), acceleration_Q(3), deceleration_Q(3), max_time_end);
            % Перерасчет четвертой координаты
            [velocity_max_Q(4), T_max_velocity_Q(4)] = syncM5_Resolve_FNC(difference_Q(4), acceleration_Q(4), deceleration_Q(4), max_time_end);
    end
