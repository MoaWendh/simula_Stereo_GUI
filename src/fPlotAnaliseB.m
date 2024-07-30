function fPlotAnaliseB(pontos, dp_L_X, dp_L_Y, dp_L_Z, dp_R_X, dp_R_Y, dp_R_Z, curvaAjustada)

plotaApenasCameraEsquerda=1;

if plotaApenasCameraEsquerda
    
    fig1= figure;
    fig1.Position=[22 100 1250 1160];

    subplot(3,1,1);
    plot(pontos, dp_L_X, '*r');
    hold on;
    plot(pontos, curvaAjustada.x, '-b');
    xlabel('Distância (m)');
    ylabel('Incerteza (mm)');
    grid on;
    subtitle('Incerteza padrão ao longo do eixo "X".');
    legend('Cam. Left','Cam. Right', 'Location', 'east');

    subplot(3,1,2);
    plot(pontos, dp_L_Y, '*r');
    hold on;
    plot(pontos, curvaAjustada.y, '-b');
    xlabel('Distância (m)');
    ylabel('Incerteza (mm)');
    subtitle('Incerteza padrão ao longo do eixo "Y".');
    legend('Cam. Left','Cam. Right', 'Location', 'east');
    grid on;

    subplot(3,1,3);
    plot(pontos, dp_L_Z, '*r');
    hold on;
    plot(pontos, curvaAjustada.z, '-b');
    xlabel('Distância (m)');
    ylabel('Incerteza (mm)');
    subtitle('Incerteza padrão ao longo do eixo "Z".');
    legend('Cam. Left','Cam. Right', 'Location', 'east');
    grid on;

else
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
    plot(pontos, curvaAjustada.z,'-g');
    xlabel('Distância (m)');
    ylabel('Incerteza (mm)');
    grid on;
    subtitle('Câmera Esquerda: Incertezas padrão ao longos dos eixos X, Y e Z.');
    legend('Incerteza X','Incerteza Y','Incerteza Z', 'Location', 'north');

    fig2.Position=[1300 100 1250 1160];      
end                   
end