function [new_point] = prepare(point)
P_correct = [1 0 0 0;
0 1 0 0;
0 0 1 385;
0 0 0 1
];
L = P_correct*ROz(-pi/2)*ROx(-pi/2);
point = [point;1];
new_point = L*point;
new_point = new_point(1:3,:);
end

