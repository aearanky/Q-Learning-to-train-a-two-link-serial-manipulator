clc;
clear all;
close all;

% Q-learning
% -----------------------------------------------------------------
% 1. Set the gamma parameter, and environment rewards in matrix R.
% Reward R --> Reward for taking an action from s to s'
Gamma = 0.8;
R = zeros(90,2); %,2 %two angles and two actions for each joint (currently doing only one joint)
sf=35;
for i=1:sf-1
    for j=1:2
        if j==1
            R(i,j)=i/(sf-1);
        else
            R(i,j)=-0.05;
        end       
    end
end
R(sf,:)= 10;
for i=sf+1:90
    for j=1:2
        if j==2
            R(i,j)=sf/i+1;
        else
            R(i,j)=-0.05;
        end       
    end
end



%Initialize the states matrix
S = ones(90,1);
for i=1:90 %The increment is actually by 0.1 degree
    S(i,1)=i;
end
%Initialize the action matrix
A1 = [1 2]; %1='+1'deg, 2='-1'deg

% Initialize matrix Q to zero.
Q = zeros(90,2);

% For each episode:
for i=1:1000
    % Select a random initial state.(Completely exploring mode)
    Start_s1 = randi([1 length(S(:,1))],1,1);
    s=Start_s1;
    sf=S(35,1);
    % Do While the goal state hasn't been reached.
    epsilon = 1-i/1000;
    while(s ~= sf && epsilon>0)
        % Select one among all possible actions for the current state.
%         a1 = randi([1 length(A1)],1,1);
        p=rand;
        if p<epsilon %Explore
             a1 = randi([1 length(A1)],1,1);
        else %Choose policy based step
             if Q(s,1)>Q(s,2)
                 a1=1;
             else
                 a1=2;
             end
        end
            
        % Using this possible action, consider going to the next state.
            if a1==1 && s ~= 90
                snext=s+1;%+1
            elseif (s ~= 1) %For the first angle
                if a1==1 && s ~= 90
                    snext=s+1;%-1
                elseif a1==2 
                    snext=s-1;%+1
                end
            else
                continue;
            end
        
        % Get maximum Q value for this next state based on all possible actions.
        Qmax = max(Q(snext,:));
        
        % Compute: Q(state, action) = R(state, action) + Gamma * Max[Q(next state, all actions)]
        alpha = 0.6;
        Q(s,a1)= Q(s,a1) + alpha*( R(s,a1) + Gamma * Qmax -  Q(s,a1));
        
        % Set the next state as the current state.
        s=snext;
        if s==snext
            Q(snext,a1)= Q(snext,a1) + alpha*( R(snext,a1) + Gamma * Qmax -  Q(snext,a1));
        end
    % End While
    end
% End For
end

%--------------------Store the Q value in a file and load it for everytime---------------------------
Q_plot=importdata('Qdatafor1Link.mat');
start=15;
Qtoplot(Q_plot,start);