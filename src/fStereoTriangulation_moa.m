function [M_L, M_R]= fStereoTriangulation_moa(p_left, p_right, ...
                                              vetorR, t, ... 
                                              f_L, sensorOrigem_L,  distorcaoLente_L, skell_L, ...
                                              f_R, sensorOrigem_R,  distorcaoLente_R, skell_R, ...
                                              X_L, X_R, pixelSize)

p_left_n = normalize_pixel(p_left, f_L, sensorOrigem_L, distorcaoLente_L, skell_L);
p_right_n = normalize_pixel(p_right, f_R, sensorOrigem_R, distorcaoLente_R, skell_R);

R= fRodrigues(vetorR);

baseLine= sqrt(t(1)^2 + t(2)^2 + t(3)^2);

disparidade= p_left_n(1) - p_right_n(1);

z= baseLine/disparidade;

x= z*p_left_n(1);

y= z*p_left_n(2);


end