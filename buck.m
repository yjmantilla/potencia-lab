clc
clear all
Ve = 350;
Vc = 100;
R = 50;
K = Vc/Ve;
Fsw = 20000 ;
T = 1/Fsw;
Il = Vc/R;
deltaIl = 0.02*Il; 
deltaVc = 0.05*Vc;
l = K*T*(Ve-Vc)/(deltaIl);
c = (1/8)*(T*T/l)*(1-K)*(Vc/deltaVc);


 %% modelo de espacio de estados: 
 A = [  0       -1/l ;
       1/c  -1/(R*c)  ]
 B = [   Ve/l     K/l;
         0     0  ]
 C = eye(size(A))
 D = zeros(size(A))

 spaceSatateModel = ss(A,B,C,D)
 Gs = tf (spaceSatateModel)
 %GsIlk = Gs(1,1)
 GsVcK = Gs(2,1)

 step(GsVcK)
 %rlocus(GsVcK)
