clc;
clear all;
close all;

% Q-learning
% -----------------------------------------------------------------
% 1. Set the gamma parameter, and environment rewards in matrix R.
% Reward R --> Reward for taking an action from s to s'
Gamma = 0.8;
R = zeros(90,2,2); %,2 %two angles and two actions for each joint (currently doing only one joint)

sf1=35;
for i=1:sf1-1
    for j=1:2
        if j==1
            R(i,j,1)=i/(sf1-1);
        else
            R(i,j,1)=-0.05;
        end
    end
end
R(sf1,:,1)= 10;
for i=sf1+1:90
    for j=1:2
        if j==2
            R(i,j,1)=sf1/i+1;
        else
            R(i,j,1)=-0.05;
        end
    end
end

sf2=70;
for i=1:sf2-1
    for j=1:2
        if j==1
            R(i,j,2)=i/(sf2-1);
        else
            R(i,j,2)=-0.05;
        end
    end
end
R(sf2,:,2)= 10;
for i=sf2+1:90
    for j=1:2
        if j==2
            R(i,j,2)=sf2/i+1;
        else
            R(i,j,2)=-0.05;
        end
    end
end
%Initialize the states matrix
S1 = ones(90,1);
S2 = ones(90,1);

for i=1:90 %The increment is actually by 1 degree
    S1(i,1)=i;
end

for i=1:90 %The increment is actually by 1 degree
    S1(i,1)=i;
end

%Initialize the action matrix
A1 = [1 2]; %1='+1'deg, 2='-1'deg
A2 = [1 2]; %1='+1'deg, 2='-1'deg

% Initialize matrix Q to zero.
Q = zeros(90,2,2);

% For each episode:
for i=1:1000
    % Select a random initial state.(Completely exploring mode)
    Start_s1 = randi([1 length(S1(:,1))],1,1);
    Start_s2 = randi([1 length(S2(:,1))],1,1);
    s1=Start_s1;
    s2=Start_s2;
    % Do While the goal state hasn't been reached.
    epsilon = 1-i/1000;
    while(s1 ~= sf1 && s2 ~= sf2 && epsilon>0)
        % Select one among all possible actions for the current state.
        %         a1 = randi([1 length(A1)],1,1);
        %         a2 = randi([1 length(A2)],1,1);
        p=rand;
        if s1 ~= sf1     
            if p<epsilon %Explore
                a1 = randi([1 length(A1)],1,1);
            else %Choose policy based step
                if Q(s1,1,1)>Q(s1,2,1)
                    a1=1;
                else
                    a1=2;
                end
            end
            
            % Using this possible action, consider going to the next state.
            if a1==1 && s1 ~= 90
                snext1=s1+1;%+1
            elseif (s1 ~= 1) %For the first angle
                if a1==1 && s1 ~= 90
                    snext1=s1+1;%-1
                elseif a1==2
                    snext1=s1-1;%+1
                end
            else
                continue;
            end
            
            % Get maximum Q value for this next state based on all possible actions.
            Qmax1 = max(Q(snext1,:,1));
            
            % Compute: Q(state, action) = R(state, action) + Gamma * Max[Q(next state, all actions)]
            alpha = 0.6;
            Q(s1,a1,1)= Q(s1,a1,1) + alpha*( R(s1,a1,1) + Gamma * Qmax1 -  Q(s1,a1,1));
            
            % Set the next state as the current state.
            s1=snext1;
            if s1==snext1
                Q(snext1,a1,1)= Q(snext1,a1,1) + alpha*( R(snext1,a1,1) + Gamma * Qmax1 -  Q(snext1,a1,1));
            end
        %End If    
        end
        
        if s2 ~= sf2
            if p<epsilon %Explore
                a2 = randi([1 length(A2)],1,1);
            else %Choose policy based step
                if Q(s1,1,2)>Q(s1,2,2)
                    a2=1;
                else
                    a2=2;
                end
            end
            
            % Using this possible action, consider going to the next state.
            if a2==1 && s2 ~= 90
                snext2=s2+1;%+1
            elseif (s2 ~= 1) %For the first angle
                if a2==1 && s2 ~= 90
                    snext2=s2+1;%-1
                elseif a2==2
                    snext2=s2-1;%+1
                end
            else
                continue;
            end
            
            % Get maximum Q value for this next state based on all possible actions.
            Qmax2 = max(Q(snext2,:,2));
            
            % Compute: Q(state, action) = R(state, action) + Gamma * Max[Q(next state, all actions)]
            alpha = 0.6;
            Q(s2,a2,2)= Q(s2,a2,2) + alpha*( R(s2,a2,2) + Gamma * Qmax2 -  Q(s2,a2,2));
            
            % Set the next state as the current state.
            s2=snext2;
            if s2==snext2
                Q(snext2,a2,2)= Q(snext2,a2,2) + alpha*( R(snext2,a2,2) + Gamma * Qmax2 -  Q(snext2,a2,2));
            end
        %End If    
        end
        
    % End While
    end
% End For
end

% theta1 = pi/3;
% theta2 = pi/4;
%         [line1, line2] = plot2Larm(theta1,theta2);
%         plot(line1(1,:), line1(2,:),'-rO','MarkerSize',10)
%         hold on;
%         plot(line2(1,:), line2(2,:),'-bo','MarkerSize',10)
%         axis([-1 10 -1 10]);
% grid on;