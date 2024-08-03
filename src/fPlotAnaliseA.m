function fPlotAnalise(pontos, estatistica, residuo_X_L, residuo_X_R, CalculaIncerteza_Y, X_L_sim, pontos3D_real)

fig1= figure;
fig1.Position=[8 65 2550 1280];

subplot(2,3,[3 6]);
plot3(pontos3D_real(:,1), pontos3D_real(:,2), pontos3D_real(:,3), 'or', 'MarkerSize', 6, 'LineWidth', 2);
hold on;
xlabel('X (mm)');
ylabel('Y (mm)');
zlabel('Z (mm)');
grid on; 
plot3(X_L_sim(:,:,1), X_L_sim(:,:,2), X_L_sim(:,:,3), '.b');  
msg= sprintf('Pontos 3D real x simulado');
subtitle(msg); 
legend('Real','Simulado')
axis equal;

subplot(2,3,1);
plot(pontos, residuo_X_L(:,1), '-r');
xlabel('Ponto');
ylabel('Erro (mm)');
msg= sprintf('Resíduo na direção X: DP= %0.4fmm', estatistica.dp_L_X);
subtitle(msg);   
%legend('Cam. Left','Cam. Right', 'Location', 'east');
grid on;

subplot(2,3,4);
plot(pontos, residuo_X_L(:,3), '-b');
xlabel('Distância (m)');
ylabel('Incerteza (mm)');
msg= sprintf('Resíduo na direção Z: DP= %0.4fmm', estatistica.dp_L_Z);
subtitle(msg);   
%legend('Cam. Left','Cam. Right', 'Location', 'east');
grid on; 


subplot(2,3,2);
%histogram(residuos_x, nBins, 'Normalization','pdf');
histogram(residuo_X_L(:,:,1), 'Normalization','pdf');
hold on;
media_x= mean(residuo_X_L(:,:,1));
dp_x= estatistica.dp_L_X;
auxRes_x= min(residuo_X_L(:,:,1)):max(residuo_X_L(:,:,1))/1000:max(residuo_X_L(:,:,1));
f_x = exp(-(auxRes_x - media_x).^2./(2*dp_x^2))./(dp_x*sqrt(2*pi));
plot(auxRes_x, f_x,'LineWidth', 1.5);
msg= sprintf('Histograma normalizado - Resíduo na direção X.');
title(msg);
grid on;


nBits= 10;
subplot(2,3,5);
% histogram(residuos_z, nBins, 'Normalization','pdf');
histogram(residuo_X_L(:,:,3), 'Normalization','pdf');
hold on;
media_z= mean(residuo_X_L(:,:,3));
dp_z= dp_L_Z;
auxRes_z= min(residuo_X_L(:,:,3)):max(residuo_X_L(:,:,3))/1000:max(residuo_X_L(:,:,3));
f_z= exp(-(auxRes_z - media_z).^2./(2*dp_z^2))./(dp_z*sqrt(2*pi));
plot(auxRes_z, f_z, 'LineWidth', 1.5);
msg= sprintf('Histograma normalizado - Resíduo na direção Z.');
title(msg);
grid on;

end