clc;
clear all;
% Q-learning
% -----------------------------------------------------------------
% 1. Set the gamma parameter, and environment rewards in matrix R.
Gamma = 0.8;
R = [-1 -1 -1 -1  0 -1; ...
     -1 -1 -1  0 -1 100; ...
     -1 -1 -1  0 -1 -1; ...
     -1  0  0 -1  0 -1; ...
      0 -1 -1  0 -1 100; ...
     -1  0 -1 -1  0 100]
 S = [1 2 3 4 5 6];
 A = [1 2 3 4 5 6];
% 2. Initialize matrix Q to zero.
Q = zeros(6,6);
% 3. For each episode:
for i=1:5
    % Select a random initial state.
    Start = randi([1 length(S)],1,1);
    s = Start;
    sf = S(6);
    % Do While the goal state hasn't been reached.
    while(s ~= sf) 
        % Select one among all possible actions for the current state.
        a = randi([1 length(A)],1,1);
        % Using this possible action, consider going to the next state.
        snext = S(a); %Only for this example 
        % Get maximum Q value for this next state based on all possible actions.
        Qmax = max(Q(snext,:));
        % Compute: Q(state, action) = R(state, action) + Gamma * Max[Q(next state, all actions)]
        Q(s,a) = R(s,a) + Gamma * Qmax;
        % Set the next state as the current state.
        s=S(a);
% End Do
    end
% End For
end 

Q 