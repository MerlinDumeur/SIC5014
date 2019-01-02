function [X0] = Target_initialization(gamma0)
%TARGET_INITIALIZATION Summary of this function goes here
%   Detailed explanation goes here

n0 = poissrnd(gamma0);
X0 = Create_target(n0);

end