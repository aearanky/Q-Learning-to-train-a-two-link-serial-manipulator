function Qtoplot1(Q,start)

[Max,sf1] = max(Q(:,1,1));
n = abs(start-sf1)+1;
theta1 = zeros(n,1);

if start<sf1
    for i=start:sf1
        theta1(i-start+1,1) = i;
    end
end

if start>sf1
    for i=start:-1:sf1
        theta1(start-i+1,1) = i;
    end
end

if (start==sf1)
    theta1(n,1) = sf1;
end

theta1 = theta1*pi/180;
theta2 = 0;

grid on;
for k=1:n
    [line1, line2] = plot2Larm(theta1(k),theta2);
    plot(line1(1,:), line1(2,:),'-rO','MarkerSize',10)
    hold on;
    plot(line2(1,:), line2(2,:),'-bO','MarkerSize',10)
    axis([-5 10 -1 10]);
    pause(0.1);
    clf;
end

end