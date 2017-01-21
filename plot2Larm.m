function[line1, line2] = plot2Larm(theta1,theta2)

a1 = 4; %length of link one
x1=0:a1:a1;
y1= 0*x1;
z1 = 0*x1;
ones1 = ones(1,2);
T01 = [cos(theta1)    -sin(theta1) 0  a1*cos(theta1);
    sin(theta1)    cos(theta1)  0    a1*sin(theta1);
    0                0          1     0;
    0                0          0     1];

P1 = [x1(:,1); y1(:,1); z1(:,1); ones1(:,1)];
P1p = T01* P1;
line1 = [P1(1,1)  P1p(1,1); P1(2,1) P1p(2,1)];
% ----------------------------------------------------
a2 = 4; %length of link two
T12 = [cos(theta2)    -sin(theta2) 0    a2*cos(theta2);
    sin(theta2)    cos(theta2)  0    a2*sin(theta2);
    0                0          1     0;
    0                0          0     1];
P2p = T01*T12* P1;
line2 = [P1p(1,1)  P2p(1,1); P1p(2,1) P2p(2,1)];
% ----------------------------------------------------

