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

subplot(3,1,1);
plot(distancia, dp_L_X, '.r');
hold on;
plot(distancia, dp_R_X, 'ob');
xlabel('Distância (m)');
ylabel('Incerteza (mm)');
grid on;

subplot(3,1,2);
plot(distancia, dp_L_Y, '.r');
hold on;
plot(distancia, dp_R_Y, 'ob');
xlabel('Distância (m)');
ylabel('Incerteza (mm)');
grid on;

subplot(3,1,3);
plot(distancia, dp_L_Z, '.r');
hold on;
plot(distancia, dp_R_Z, 'ob');
xlabel('Distância (m)');
ylabel('Incerteza (mm)');
grid on;


resultados= 0;
end