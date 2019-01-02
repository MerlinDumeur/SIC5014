function [Xk] = Target_prediction(gammak,Xk_1,pS,F,Q)
%TARGET_PREDICTION Summary of this function goes here
%   Detailed explanation goes here

b = poissrnd(gammak);
samples = binornd(1,pS,size(Xk_1,1),1);

Xk = zeros(sum(samples)+b,4);

% disp(samples);
% disp(size(Xk));
% disp(b);
% disp(b+sum(samples));

j = 1;

for i = 1:size(Xk_1,1)
   
    if samples(i)
        
%        disp(F*Xk_1(i,:)');
%        disp(Q);
       Xk(j,:) = mvnrnd(F*Xk_1(i,:)',Q)';
       j = j+1; 
       
    end
    
end

% disp(size(Xk(sum(samples)+1:end,:)));
% disp(size(Create_target(b)));
% disp(size(Xk))

if b > 0

    Xk(sum(samples)+1:end,:) = Create_target(b);

end

