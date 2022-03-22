clc
clear all
Vi = 350;
Vc = 100;
Vref = 100;
R = 50;
K = Vc/Vi;
Fsw = 20000 ;
T = 1/Fsw;
Il = Vc/R;
deltaIl = 0.02*Il; 
deltaVc = 0.05*Vc;
l = K*T*(Vi-Vc)/(deltaIl);
c = (1/8)*(T*T/l)*(1-K)*(Vc/deltaVc);

 %% modelo de espacio de estados: 
 A = [  0       -1/l ;
       1/c  -1/(R*c)  ];
 B = [   Vi/l    ;
         0     ];
 
 C = [0 1];
 D = [0];

 spaceStateModel = ss(A,B,C,D)
 Gs = tf (spaceStateModel)
 %GsIlk = Gs(1,1)
 %GsVcK = Gs(2,1)

 step(Gs)
 rlocus(Gs)
 disp('')