function resultados= fAnalisaIncertezas(X_L_sim, X_R_sim, numSimulacoes, distanciaNominal)
clc;

[numDistancias numSim]= size(X_L_sim);

for ctDist=1:numDistancias
    media_L_X(ctDist)= mean(X_L_sim(ctDist,:,1));
    media_L_Y(ctDist)= mean(X_L_sim(ctDist,:,2));
    media_L_Z(ctDist)= mean(X_L_sim(ctDist,:,3));

    dp_L_X(ctDist)= std(X_L_sim(ctDist,:,1));
    dp_L_Y(ctDist)= std(X_L_sim(ctDist,:,2));
    dp_L_Z(ctDist)= std(X_L_sim(ctDist,:,3));
    
    distancia_L(ctDist)= media_L_Z(ctDist)/1000;
    
    media_R_X(ctDist)= mean(X_R_sim(ctDist,:,1));
    media_R_Y(ctDist)= mean(X_R_sim(ctDist,:,2));
    media_R_Z(ctDist)= mean(X_R_sim(ctDist,:,3));

    dp_R_X(ctDist)= std(X_R_sim(ctDist,:,1));
    dp_R_Y(ctDist)= std(X_R_sim(ctDist,:,2));
    dp_R_Z(ctDist)= std(X_R_sim(ctDist,:,3));
    
    distancia_R(ctDist)= media_R_Z(ctDist)/1000;
end

close all;

distancia= distanciaNominal/1000;
fig1= figure;
fig1.Position=[22 100 1250 1160];

subplot(3,1,1);
plot(distancia, dp_L_X, '*r');
hold on;
plot(distancia, dp_R_X, 'ob');
xlabel('Distância (m)');
ylabel('Incerteza (mm)');
grid on;
subtitle('Incerteza padrão ao longo do eixo "X".');
legend('Cam. Left','Cam. Right', 'Location', 'east');

subplot(3,1,2);
plot(distancia, dp_L_Y, '*r');
hold on;
plot(distancia, dp_R_Y, 'ob');
xlabel('Distância (m)');
ylabel('Incerteza (mm)');
subtitle('Incerteza padrão ao longo do eixo "Y".');
legend('Cam. Left','Cam. Right', 'Location', 'east');
grid on;

subplot(3,1,3);
plot(distancia, dp_L_Z, '*r');
hold on;
plot(distancia, dp_R_Z, 'ob');
xlabel('Distância (m)');
ylabel('Incerteza (mm)');
subtitle('Incerteza padrão ao longo do eixo "Z".');
legend('Cam. Left','Cam. Right', 'Location', 'east');
grid on;

fig2= figure;

subplot(2,1,1);
plot(distancia, dp_R_X, '*-b');
hold on;
plot(distancia, dp_R_Y, '*-g');
plot(distancia, dp_R_Z, '*-r');
xlabel('Distância (m)');
ylabel('Incerteza (mm)');
grid on;
subtitle('Câmera direita: Incertezas padrão ao longos dos eixos X, Y e Z.');
legend('Incerteza X','Incerteza Y','Incerteza Z', 'Location', 'north');

subplot(2,1,2);
plot(distancia, dp_L_X, '*-b');
hold on;
plot(distancia, dp_L_Y, '*-g');
plot(distancia, dp_L_Z, '*-r');
xlabel('Distância (m)');
ylabel('Incerteza (mm)');
grid on;
subtitle('Câmera Esquerda: Incertezas padrão ao longos dos eixos X, Y e Z.');
legend('Incerteza X','Incerteza Y','Incerteza Z', 'Location', 'north');

fig2.Position=[1300 100 1250 1160];

resultados= 0;
end