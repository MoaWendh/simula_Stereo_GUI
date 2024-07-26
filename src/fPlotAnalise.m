function fPlotAnalise(pontos, dp_L_X, dp_L_Y, dp_L_Z, dp_R_X, dp_R_Y, dp_R_Z, residuo_X_L, residuo_X_R, CalculaIncerteza_Y)

if ~CalculaIncerteza_Y
    fig1= figure;
    fig1.Position=[22 100 1250 1160];

    subplot(2,1,1);
    plot(pontos, residuo_X_L(:,1), '*r');
    xlabel('Ponto');
    ylabel('Erro (mm)');
    msg= sprintf('Resíduo na direção X: DP= %fmm', dp_L_X);
    subtitle(msg);   
    %legend('Cam. Left','Cam. Right', 'Location', 'east');

    grid on;

    subplot(2,1,2);
    plot(pontos, residuo_X_L(:,3), '*b');
    xlabel('Distância (m)');
    ylabel('Incerteza (mm)');
    msg= sprintf('Resíduo na direção Z: DP= %fmm', dp_L_Z);
    subtitle(msg);   
    %legend('Cam. Left','Cam. Right', 'Location', 'east');
    grid on;  
    a=0;
else
    fig1= figure;
    fig1.Position=[22 100 1250 1160];

    subplot(3,1,1);
    plot(pontos, dp_L_X, '*r');
    hold on;
    plot(pontos, dp_R_X, 'ob');
    xlabel('Distância (m)');
    ylabel('Incerteza (mm)');
    grid on;
    subtitle('Incerteza padrão ao longo do eixo "X".');
    legend('Cam. Left','Cam. Right', 'Location', 'east');

    subplot(3,1,2);
    plot(pontos, dp_L_Y, '*r');
    hold on;
    plot(pontos, dp_R_Y, 'ob');
    xlabel('Distância (m)');
    ylabel('Incerteza (mm)');
    subtitle('Incerteza padrão ao longo do eixo "Y".');
    legend('Cam. Left','Cam. Right', 'Location', 'east');
    grid on;

    subplot(3,1,3);
    plot(pontos, dp_L_Z, '*r');
    hold on;
    plot(pontos, dp_R_Z, 'ob');
    xlabel('Distância (m)');
    ylabel('Incerteza (mm)');
    subtitle('Incerteza padrão ao longo do eixo "Z".');
    legend('Cam. Left','Cam. Right', 'Location', 'east');
    grid on;

    fig2= figure;

    subplot(2,1,1);
    plot(pontos, dp_R_X, '*-b');
    hold on;
    plot(pontos, dp_R_Y, '*-g');
    plot(pontos, dp_R_Z, '*-r');
    xlabel('Distância (m)');
    ylabel('Incerteza (mm)');
    grid on;
    subtitle('Câmera direita: Incertezas padrão ao longos dos eixos X, Y e Z.');
    legend('Incerteza X','Incerteza Y','Incerteza Z', 'Location', 'north');

    subplot(2,1,2);
    plot(pontos, dp_L_X, '*-b');
    hold on;
    plot(pontos, dp_L_Y, '*-g');
    plot(pontos, dp_L_Z, '*-r');
    xlabel('Distância (m)');
    ylabel('Incerteza (mm)');
    grid on;
    subtitle('Câmera Esquerda: Incertezas padrão ao longos dos eixos X, Y e Z.');
    legend('Incerteza X','Incerteza Y','Incerteza Z', 'Location', 'north');

    fig2.Position=[1300 100 1250 1160];      
end                    
end