T_e = 1;
T = 100;

sigma_Q = 1;
sigma_angle = 10*pi/180;
sigma_distance = 10;

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

R = [sigma_distance^2 0
     0          sigma_angle^2];

x_init = [3
          40
         -4
          20];
x_kalm = x_init;
x_kalm_ligne = x_kalm;
x_kalm = x_kalm;

P_kalm = eye(4);
P_kalm = P_kalm;
P_kalm_ligne = P_kalm;

vecteur_x = creer_trajectoire(F,Q,x_init,T);
vecteur_y = creer_observations_radar(R,vecteur_x,T);

vecteur_y_cartesien = conversion_cartesienne(vecteur_y,T);

for k = 2:T
   
    [x_kalm(:,k),P_kalm] = filtre_de_kalman_radar(F,Q,R,vecteur_y(:,k),x_kalm(:,k-1),P_kalm);
    
end



%{

%figure()
%plot(vecteur_x(1,:),vecteur_x(3,:));
%hold on
%plot(x_kalm(1,:),x_kalm(3,:));


%}

for k = 1:T
    
    err_quadra(k) = (vecteur_x(:,k)-x_kalm(:,k))'*(vecteur_x(:,k)-x_kalm(:,k));

end
erreur_moyenne = 1/T*sum(sqrt(err_quadra));


%{
figure()
abscisse = 1:T;
plot(abscisse,vecteur_x(1,:),abscisse,vecteur_y(1,:),abscisse,x_kalm(1,:));
figure()
plot(abscisse,vecteur_x(3,:),abscisse,vecteur_y(2,:),abscisse,x_kalm(3,:));
figure()
plot(vecteur_x(1,:),vecteur_x(3,:),vecteur_y(1,:),vecteur_y(2,:),x_kalm(1,:),x_kalm(3,:));
%}

display(erreur_moyenne)
%{
figure()
abscisse = 1:T;
plot(abscisse,vecteur_x(1,:),abscisse,vecteur_y_cartesien(1,:),abscisse,x_kalm(1,:));
figure()
plot(abscisse,vecteur_x(3,:),abscisse,vecteur_y_cartesien(2,:),abscisse,x_kalm(3,:));
%}
figure()
plot(vecteur_x(1,:),vecteur_x(3,:),vecteur_y_cartesien(1,:),vecteur_y_cartesien(2,:));
title("Trajectoire observée")
xlabel("X")
ylabel("Y")
legend("Trajectoire","Observation","Location","northwest")
figure()
plot(vecteur_x(1,:),vecteur_x(3,:),x_kalm(1,:),x_kalm(3,:));
title("Trajectoire estimée")
xlabel("X")
ylabel("Y")
legend("Trajectoire","Estimation","Location","northwest")
