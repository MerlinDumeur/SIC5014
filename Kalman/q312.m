T_e = 1;
T = 100;

sigma_Q = 1;
sigma_angle = 100*pi/180;
sigma_distance = 1000;

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