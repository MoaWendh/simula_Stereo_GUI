function [M_L, M_R]= fStereoTriangulation_moa(p_left, p_right, vetorR, t, ... 
                                              f_L, sensorOrigem_L,  distorcaoLente_L, skell_L, ...
                                              f_R, sensorOrigem_R,  distorcaoLente_R, skell_R, ...
                                              pixelSize, matrizT_Stereo)
% p_left_n = normalize_pixel(p_left, f_L, sensorOrigem_L, distorcaoLente_L, skell_L);
% p_right_n = normalize_pixel(p_right, f_R, sensorOrigem_R, distorcaoLente_R, skell_R);

R= [fRodrigues(vetorR) [0; 0; 0]; [0 0 0 1]];

t= [t ; 1];

%baseline= -1*sqrt(t(1)^2 + t(2)^2 + t(3)^2);
% baseline= t(1);
baseline= matrizT_Stereo(1,4);

disparidade= p_right(1) - p_left(1);

Z_L= f_L(1)*(baseline/disparidade);
X_L= (baseline*(p_left(1)-sensorOrigem_L(1))/disparidade);
Y_L= (baseline*(p_left(2)-sensorOrigem_L(2))/disparidade)*(f_L(1)/f_L(2));

Z_R= f_R(1)*(baseline/disparidade);
% X_R= (baseline*(p_right(1)-sensorOrigem_R(1))/disparidade);
% Y_R= (baseline*(p_right(2)-sensorOrigem_R(2))/disparidade)*(f_R(1)/f_R(2));

X_R= (baseline*(p_right(1))/disparidade);
Y_R= (baseline*(p_right(2))/disparidade)*(f_R(1)/f_R(2));

P_L=[X_L  Y_L  Z_L  1]';
P_R= [X_R  Y_R   Z_R  1]';

M_L= P_L(1:3,1);
M_R= P_R(1:3,1);

end