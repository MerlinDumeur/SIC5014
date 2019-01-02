function [Zk] = Measurement_generation(Xk,pD,lambdak,H,R)
%MEASUREMENT_GENERATION Summary of this function goes here
%   Detailed explanation goes here

c = poissrnd(lambdak);
samples = binornd(1,pD,size(Xk,1),1);

Zk = zeros(sum(samples)+c,2);

j = 1;

for i = 1:size(Xk,1)
   
    if samples(i)
        
       Zk(j,:) = mvnrnd(H*Xk(i,:)',R)';
       j = j+1; 
       
    end
    
end

if c > 0

    Ztemp = Create_target(c);
    Zk(sum(samples)+1:end,:) = [Ztemp(:,1) Ztemp(:,3)];

end
    
end

