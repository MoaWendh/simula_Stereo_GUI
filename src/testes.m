clc;

Pr=[-300 0 2000 1];

Rot_lr= [1  0  0
         0  1  0
         0  0  1];

t_lr=[-10 0 0]';

T_lr=[Rot_lr t_lr; [0 0 0 1]];

T= [0.9878    0.0014    0.1559 -635.0767
   -0.0012    1.0000   -0.0009    1.5924
   -0.1559    0.0007    0.9878   50.7062
         0         0         0    1.0000];

%Pl= inv(T_lr)*Pr';
Pl= inv(T)*Pr'
a=0;
