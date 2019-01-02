T_e = 1;
T = 100;

sigma_Q = 1;
sigma_px = 30;
sigma_py = 30;

F = [1 T_e 0 0 
     0 1   0 0
     0 0   1 T_e
     0 0   0 1];


Te33 = T_e^3/3;
Te22 = T_e^2/2;
Q = [Te33 Te22 0    0
     Te22 T_e  0    0
     0    0    Te33 Te22
     0    0    Te22 T_e];

Q = sigma_Q^2 * Q;
  
H = [1 0 0 0
     0 0 1 0];

R = [sigma_px^2 0
     0          sigma_py^2];

x_init = [3
          40
         -4
          20];
x_kalm = x_init;

P_kalm = eye(4);

v_x = creer_trajectoire(F,Q,x_init,T);

v_y = creer_observations(H,R,v_x,T);

%{
figure()
plot(v_x(1,:),v_x(3,:));
figure()
plot(v_y(1,:),v_y(2,:));
%}


for k = 2:T
   
    [x_kalm(:,k),P_kalm] = filtre_de_kalman(F,Q,H,R,v_y(:,k),x_kalm(:,k-1),P_kalm);
    
end

%figure()
%plot(v_x(1,:),v_x(3,:));
%hold on
%plot(x_kalm(1,:),x_kalm(3,:));

for k = 1:T
    
    err_quadra(k) = (v_x(:,k)-x_kalm(:,k))'*(v_x(:,k)-x_kalm(:,k));

end

erreur_moyenne = 1/T*sum(sqrt(err_quadra));

%{
figure()
abscisse = 1:T;
plot(abscisse,v_x(1,:),abscisse,v_y(1,:),abscisse,x_kalm(1,:));
title("X(t)")
xlabel("t")
ylabel("X")
legend("Trajectoire","Observation","Estimation","Location","northwest")
figure()
plot(abscisse,v_x(3,:),abscisse,v_y(2,:),abscisse,x_kalm(3,:));
title("Y(t)")
xlabel("t")
ylabel("Y")
legend("Trajectoire","Observation","Estimation","Location","northwest")
figure()
%}
plot(v_x(1,:),v_x(3,:),v_y(1,:),v_y(2,:),x_kalm(1,:),x_kalm(3,:));
title("Trajectoire")
xlabel("X")
ylabel("Y")
legend("Trajectoire","Observation","Estimation","Location","northwest")


display(erreur_moyenne)

