close all

T = 1;
F = [1 T 0 0
     0 1 0 0
     0 0 1 T
     0 0 0 1];
 
T4 = (T^4)/4;
T3 = (T^3)/2;
T2 = T^2;
 
Q_p = [T4 T3 0 0
       T3 T2 0 0
       0  0  T4 T3
       0  0  T3 T2];

sig_v = 5;
Q = (sig_v^2) * Q_p;
 

H = [1 0 0 0
     0 0 1 0];

R_p = [1 0
       0 1];
   
sig_R = 1;
R = (sig_R^2) * R_p;

pS = 0.9;
pD = 0.9;

gamma0 = 10;
gammas = ones(10,1);
lambdas = ones(10,1);
           
X0 = Target_initialization(gamma0);
X = {X0};
Z = {zeros(5,2)};

for i = 1:length(gammas)
   
    X{i+1} = Target_prediction(gammas(i),X{i},pS,F,Q);
    Z{i+1} = Measurement_generation(X{i+1},pD,lambdas(i),H,R);
    
end

figure();
hold on
for i = 1:length(gammas)

    y = X{i+1}(:,1);
    x = ones(size(y,1),1)*i;
    
    plot(x,y,'x')
    
end

xlim([0 length(gammas)+1]);

hold off

