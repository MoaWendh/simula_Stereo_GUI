function fPlotAnalise(pontos, dp_L_X, dp_L_Y, dp_L_Z, dp_R_X, dp_R_Y, dp_R_Z, residuo_X_L, residuo_X_R, CalculaIncerteza_Y)


fig1= figure;
fig1.Position=[22 100 1250 1160];

subplot(2,1,1);
plot(pontos, residuo_X_L(:,1), '*r');
xlabel('Ponto');
ylabel('Erro (mm)');
msg= sprintf('Resíduo na direção X: DP= %0.4fmm', dp_L_X);
subtitle(msg);   
%legend('Cam. Left','Cam. Right', 'Location', 'east');

grid on;

subplot(2,1,2);
plot(pontos, residuo_X_L(:,3), '*b');
xlabel('Distância (m)');
ylabel('Incerteza (mm)');
msg= sprintf('Resíduo na direção Z: DP= %0.4fmm', dp_L_Z);
subtitle(msg);   
%legend('Cam. Left','Cam. Right', 'Location', 'east');
grid on;  

end