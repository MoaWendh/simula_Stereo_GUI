function fPlotAnaliseB(pontos, estatistica, curvaAjustada, CalculaIncerteza_Y)

plotaApenasCameraEsquerda=1;

if plotaApenasCameraEsquerda
    if CalculaIncerteza_Y
        % Explora a curva ajustada para plotar contra os velores simulados:        
        valFim= max(estatistica.distancia_L);
        valIni= min(estatistica.distancia_L);
        valIntervalo= (valFim-valIni)/100;

        t= (valIni:valIntervalo:valFim);
        dpX_fit= feval(curvaAjustada.x, t(:));
        dpY_fit= feval(curvaAjustada.y, t(:));
        dpZ_fit= feval(curvaAjustada.z, t(:));
        
        % Exibe os resultados:
        fig1= figure;
        fig1.Position=[8 65 2550 1280];
        fontSize= 28; 
        
        plot(t*1000, dpX_fit, '-r');
        hold on;
        plot(estatistica.distancia_L*1000, estatistica.dp_L.x,'.r', 'MarkerSize', 48);
        plot(t*1000, dpY_fit, '-g');        
        plot(estatistica.distancia_L*1000, estatistica.dp_L.y,'.g', 'MarkerSize', 48);
        plot(t*1000, dpZ_fit, '-b');  
        plot(estatistica.distancia_L*1000, estatistica.dp_L.z,'.b', 'MarkerSize', 48);
        
        xlabel('Distância (mm)', 'FontSize', fontSize);
        ylabel('Incerteza (mm)', 'FontSize', fontSize);
        zlabel('Incerteza (mm)', 'FontSize', fontSize);
        
        msg= sprintf('Simulação - Incerteza em função da distância (Direções X, Y e Z)');
        subtitle(msg,'FontSize', fontSize, 'FontWeight', 'bold');   
        legend('Curva Ajustada: direção X', '', 'Curva Ajustada: direção Y', '', 'Curva Ajustada: direção Z', '', 'FontSize', fontSize);
        grid on;        
        
        % Alterar a fonte dos valores dos eixos X e Y
        ax= gca;
        ax.FontName = 'Arial';  % Nome da fonte
        ax.FontSize = 28;       % Tamanho da fonte           
    else
        % Explora a curva ajustada para plotar contra os velores simulados:        
        valFim= max(estatistica.distancia_L);
        valIni= min(estatistica.distancia_L);
        valIntervalo= (valFim-valIni)/100;

        t= (valIni:valIntervalo:valFim);
        dpX_fit= feval(curvaAjustada.x, t(:));
        dpZ_fit= feval(curvaAjustada.z, t(:));
        
        % Exibe os resultados:
        fig1= figure;
        fig1.Position=[8 65 2550 1280];
        fontSize= 20; 
        
        plot(estatistica.distancia_L*1000, estatistica.dp_L.x, '.r', 'MarkerSize', 48);
        hold on;
        plot(t*1000, dpX_fit, '-r');
        plot(estatistica.distancia_L*1000, estatistica.dp_L.z, '.b', 'MarkerSize', 48);
        plot(t*1000, dpZ_fit, '-b');  
        
        xlabel('Distância (mm)', 'FontSize', fontSize);
        ylabel('Incerteza (mm)','FontSize', fontSize);
%         msg= sprintf('Simulação - Incerteza em função da distância (Direções X e Y)');
%         subtitle(msg,'FontSize', fontSize, 'FontWeight', 'bold');   
        legend('', 'Curva Ajustada: direção X', '', 'Curva Ajustada: direção Z', 'FontSize', fontSize);
        grid on;        
        
        % Alterar a fonte dos valores dos eixos X e Y
        ax= gca;
        ax.FontName = 'Arial';  % Nome da fonte
        ax.FontSize = 28;       % Tamanho da fonte           
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