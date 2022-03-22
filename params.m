Vi = 350;
Vo = 100;
fsw = 20000;
dIL = 0.02;
dVc = 0.05;
R = 50;

K = Vo/Vi;
ILEE = Vo/R;
L = Vi*(1-K)*K/(dIL*ILEE*fsw);