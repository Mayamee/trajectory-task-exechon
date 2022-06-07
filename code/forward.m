function [P, exitflag, F] = forward(Q, disp)
    q1 = Q(1); q2 = Q(2); q3 = Q(3); q4 = Q(4); q5 = Q(5);
    % base
    global xA1; global yA1; global zA1;
    % base
    global xA2; global yA2; global zA2;
    % base
    global xA3; global yA3; global zA3;
    % base
    % Platform
    global d_B1B3; global de;
    % Platform
    % out
    global L1; global L2;
    % out
    %     max iter 25000000
    opts = optimoptions(@fsolve, 'Display', disp, 'MaxFunEvals', 25000000, 'MaxIter', 1500, 'FunctionTolerance', 1E-10);
    % x0 = [xe ye ze];
    x0 = [350 350 350];
    f1 = @(x)[
        (xA1 - (x(1) - d_B1B3 * cos(atan((x(1) - xA2) / (cos(atan(-x(2) / x(3))) * (x(3) - zA2) - sin(atan(-x(2) / x(3))) * (x(2) - yA2)))) / 2))^2 + (yA1 - (x(2) - d_B1B3 * sin(atan(-x(2) / x(3))) * sin(atan((x(1) - xA2) / (cos(atan(-x(2) / x(3))) * (x(3) - zA2) - sin(atan(-x(2) / x(3))) * (x(2) - yA2)))) / 2))^2 + (zA1 - (x(3) + d_B1B3 * cos(atan(-x(2) / x(3))) * sin(atan((x(1) - xA2) / (cos(atan(-x(2) / x(3))) * (x(3) - zA2) - sin(atan(-x(2) / x(3))) * (x(2) - yA2)))) / 2))^2 - q1^2;
        (xA2 - x(1))^2 + (yA2 - (x(2) + de * cos(atan(-x(2) / x(3)))))^2 + (zA2 - (x(3) + de * sin(atan(-x(2) / x(3)))))^2 - q2^2;
        (xA3 - (x(1) + d_B1B3 * cos(atan((x(1) - xA2) / (cos(atan(-x(2) / x(3))) * (x(3) - zA2) - sin(atan(-x(2) / x(3))) * (x(2) - yA2)))) / 2))^2 + (yA3 - (x(2) + d_B1B3 * sin(atan(-x(2) / x(3))) * sin(atan((x(1) - xA2) / (cos(atan(-x(2) / x(3))) * (x(3) - zA2) - sin(atan(-x(2) / x(3))) * (x(2) - yA2)))) / 2))^2 + (zA3 - (x(3) - d_B1B3 * cos(atan(-x(2) / x(3))) * sin(atan((x(1) - xA2) / (cos(atan(-x(2) / x(3))) * (x(3) - zA2) - sin(atan(-x(2) / x(3))) * (x(2) - yA2)))) / 2))^2 - q3^2;
        ];
    [SOL, ~, exitflag] = fsolve(f1, x0, opts);
    xe = SOL(1); ye = SOL(2); ze = SOL(3);
    alf = atan(-ye / ze);
    k3 = atan((xe - xA2) / (cos(atan(-ye / ze)) * (ze - zA2) - sin(atan(-ye / ze)) * (ye - yA2)));
    T_pl = [
        cos(k3) 0 sin(k3) xe;
        sin(alf) * sin(k3) cos(alf) -sin(alf) * cos(k3) ye;
        -cos(alf) * sin(k3) sin(alf) cos(alf) * cos(k3) ze;
        0 0 0 1;
        ]; %однородная матрица платформы
    A_EndEff_FIRST = [
                cos(q4) -sin(q4) 0 0;
                sin(q4) cos(q4) 0 0;
                0 0 1 L1;
                0 0 0 1;
                ];
    A_First_Second = [
                1 0 0 0;
                0 cos(q5) -sin(q5) 0;
                0 sin(q5) cos(q5) 0;
                0 0 0 1;
                ];
    E_out = [0; L2; 0; 1; ];
    Ae = [
        1 0 0 E_out(1);
        0 1 0 E_out(2);
        0 0 1 E_out(3);
        0 0 0 1;
        ];
    T_out = T_pl * A_EndEff_FIRST * A_First_Second * Ae;
    P = T_out(1:3, 4);
    F = T_out(1:2, 2); F = [F; 1];
    %returns the position and orientation of end effector
end
