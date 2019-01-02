function [X0] = Create_target(n)
%CREATE_TARGET Summary of this function goes here
%   Detailed explanation goes here

% state space is [Xmax Xdot_max Ymax Ydot_max ; Xmin Xdot_min Ymin
% Ydot_min];
state_space = [1000  20  1000  20
               -1000 -20 -1000 -20];

amp = state_space(1,:) - state_space(2,:);
mean = 0.5*(state_space(1,:)-state_space(2,:));
           
X0 = rand(n,4);
X0 = (X0 .* amp) - mean;

end

