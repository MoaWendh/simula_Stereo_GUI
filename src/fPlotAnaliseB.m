function fPlotAnaliseB(pontos, estatistica, curvaAjustada, CalculaIncerteza_Y)

plotaApenasCameraEsquerda=1;

if plotaApenasCameraEsquerda
    if CalculaIncerteza_Y
        fig1= figure;
        fig1.Position=[22 100 1250 1160];

        subplot(3,1,1);
        plot(pontos, estatistica.dp_L.x, '*r');
        hold on;
        plot(pontos, curvaAjustada.x, '-b');
        xlabel('Distância (m)');
        ylabel('Incerteza (mm)');
        grid on;
        subtitle('Incerteza padrão ao longo do eixo "X".');
        legend('Cam. Left','Cam. Right', 'Location', 'east');

        subplot(3,1,2);
        plot(pontos, estatistica.dp_L.y, '*r');
        hold on;
        plot(pontos, curvaAjustada.y, '-b');
        xlabel('Distância (m)');
        ylabel('Incerteza (mm)');
        subtitle('Incerteza padrão ao longo do eixo "Y".');
        legend('Cam. Left','Cam. Right', 'Location', 'east');
        grid on;

        subplot(3,1,3);
        plot(pontos, estatistica.dp_L.z, '*r');
        hold on;
        plot(pontos, curvaAjustada.z, '-b');
        xlabel('Distância (m)');
        ylabel('Incerteza (mm)');
        subtitle('Incerteza padrão ao longo do eixo "Z".');
        legend('Cam. Left','Cam. Right', 'Location', 'east');
        grid on;
    else
        fig1= figure;
        fig1.Position=[22 100 1250 1160];

        subplot(2,1,1);
        plot(pontos, estatistica.dp_L.x, '*r');
        hold on;
        plot(pontos, curvaAjustada.x, '-b');
        xlabel('Distância (m)');
        ylabel('Incerteza (mm)');
        grid on;
        subtitle('Incerteza padrão ao longo do eixo "X".');
        legend('Cam. Left','Cam. Right', 'Location', 'east');

        subplot(2,1,2);
        plot(pontos, estatistica.dp_L.z, '*r');
        hold on;
        plot(pontos, curvaAjustada.z, '-b');
        xlabel('Distância (m)');
        ylabel('Incerteza (mm)');
        subtitle('Incerteza padrão ao longo do eixo "Z".');
        legend('Cam. Left','Cam. Right', 'Location', 'east');
        grid on;        
    end

else
    subplot(3,1,1);
    plot(pontos, estatistica.dp_L.x, '*r');
    hold on;
    plot(pontos, estatistica.dp_R.x, 'ob');
    xlabel('Distância (m)');
    ylabel('Incerteza (mm)');
    grid on;
    subtitle('Incerteza padrão ao longo do eixo "X".');
    legend('Cam. Left','Cam. Right', 'Location', 'east');

    subplot(3,1,2);
    plot(pontos, estatistica.dp_L.y, '*r');
    hold on;
    plot(pontos, estatistica.dp_R.y, 'ob');
    xlabel('Distância (m)');
    ylabel('Incerteza (mm)');
    subtitle('Incerteza padrão ao longo do eixo "Y".');
    legend('Cam. Left','Cam. Right', 'Location', 'east');
    grid on;

    subplot(3,1,3);
    plot(pontos, estatistica.dp_L.z, '*r');
    hold on;
    plot(pontos, estatistica.dp_R.z, 'ob');
    xlabel('Distância (m)');
    ylabel('Incerteza (mm)');
    subtitle('Incerteza padrão ao longo do eixo "Z".');
    legend('Cam. Left','Cam. Right', 'Location', 'east');
    grid on;

    fig2= figure;

    subplot(2,1,1);
    plot(pontos, estatistica.dp_R.x, '*-b');
    hold on;
    plot(pontos, estatistica.dp_R.y, '*-g');
    plot(pontos, estatistica.dp_R.z, '*-r');
    xlabel('Distância (m)');
    ylabel('Incerteza (mm)');
    grid on;
    subtitle('Câmera direita: Incertezas padrão ao longos dos eixos X, Y e Z.');
    legend('Incerteza X','Incerteza Y','Incerteza Z', 'Location', 'north');

    subplot(2,1,2);
    plot(pontos, estatistica.dp_L.x, '*-b');
    hold on;
    plot(pontos, estatistica.dp_L.y, '*-g');
    plot(pontos, estatistica.dp_L.z, '*-r');
    plot(pontos, curvaAjustada.z,'-g');
    xlabel('Distância (m)');
    ylabel('Incerteza (mm)');
    grid on;
    subtitle('Câmera Esquerda: Incertezas padrão ao longos dos eixos X, Y e Z.');
    legend('Incerteza X','Incerteza Y','Incerteza Z', 'Location', 'north');

    fig2.Position=[1300 100 1250 1160];      
end                   
end