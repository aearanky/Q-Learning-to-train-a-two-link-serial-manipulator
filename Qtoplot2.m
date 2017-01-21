function Qtoplot2(Q,start1,start2)
close all;
%For joint1
[Max1,sf1] = max(Q(:,1,1));

n1 = abs(start1-sf1)+1;
theta1 = zeros(n1,1);

if start1<sf1
    for i=start1:sf1
        theta1(i-start1+1,1) = i;
    end
end

if start1>sf1
    for i=start1:-1:sf1
        theta1(start1-i+1,1) = i;
    end
end

if (start1==sf1)
    theta1(n1,1) = sf1;
end

%For joint2
[Max2,sf2] = max(Q(:,1,2));

n2 = abs(start2-sf2)+1;
theta2 = zeros(n2,1);

if start2<sf2
    for i=start2:sf2
        theta2(i-start2+1,1) = i;
    end
end

if start2>sf2
    for i=start2:-1:sf2
        theta2(start2-i+1,1) = i;
    end
end

if (start2==sf2)
    theta2(n2,1) = sf2;
end

theta1 = theta1*pi/180;
theta2 = theta2*pi/180;
%------------------Will change for different final angles-----------------
x_pos = 2.2413;
y_pos = 6.1580;
%-------------------------------------------------------------------------

if(n1<=n2)
    for k=1:n2
        if k<=n1
            plot(x_pos,y_pos,'r*');
            hold on;
            [line1, line2] = plot2Larm(theta1(k),theta2(k));
            plot(line1(1,:), line1(2,:),'-rO','MarkerSize',10)
            hold on;
            plot(line2(1,:), line2(2,:),'-bO','MarkerSize',10)
            axis([-5 10 -1 10]);
        else
            plot(x_pos,y_pos,'r*');
            hold on;
            [line1, line2] = plot2Larm(theta1(n1),theta2(k));
            plot(line1(1,:), line1(2,:),'-rO','MarkerSize',10)
            hold on;
            plot(line2(1,:), line2(2,:),'-bO','MarkerSize',10)
            axis([-5 10 -1 10]);
        end
        pause(0.1);
        
        if k==1
            grid on;
        end
        
        if k ~= n2
            clf;
        end
    end
else
    for k=1:n1
        if k<=n2
            plot(x_pos,y_pos,'r*');
            hold on;
            [line1, line2] = plot2Larm(theta1(k),theta2(k));
            plot(line1(1,:), line1(2,:),'-rO','MarkerSize',10)
            hold on;
            plot(line2(1,:), line2(2,:),'-bO','MarkerSize',10)
            axis([-5 10 -1 10]);
        else
            plot(x_pos,y_pos,'r*');
            hold on;
            [line1, line2] = plot2Larm(theta1(k),theta2(n2));
            plot(line1(1,:), line1(2,:),'-rO','MarkerSize',10)
            hold on;
            plot(line2(1,:), line2(2,:),'-bO','MarkerSize',10)
            axis([-5 10 -1 10]);
        end
        pause(0.1);
        
        grid on;
        
        if k ~= n1
            clf;
        end
    end
end

end

