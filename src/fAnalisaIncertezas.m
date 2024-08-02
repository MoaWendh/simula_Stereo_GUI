function fAnalisaIncertezas(X_L_sim, X_R_sim, numSimulacoes, ...
                            distanciaNominal, CalculaIncerteza_Y, ...
                            carregaPontosFromFile, pontos3D, ...
                            residuo_X_L, residuo_X_R, ...
                            ExibeGraficoComEstatistica, ...
                            ExibeTabelaComEstatistica)
clc;

[numPontos]= size(X_L_sim, 1);

if carregaPontosFromFile
    estat.media_L_X= mean(residuo_X_L(:,:,1));
    estat.media_L_Y= 0;
    estat.media_L_Z= mean(residuo_X_L(:,:,3));

    estat.dp_L_X= std(residuo_X_L(:,:,1));
    estat.dp_L_Y= 0;
    estat.dp_L_Z= std(residuo_X_L(:,:,3));

    estat.media_R_X= mean(residuo_X_L(:,:,1));
    estat.media_R_Y= 0;
    estat.media_R_Z= mean(residuo_X_L(:,:,3));

    estat.dp_R_X= std(residuo_X_L(:,:,1));
    estat.dp_R_Y= 0;        
    estat.dp_R_Z= std(residuo_X_L(:,:,3));

    estat.distancia_L= mean(X_L_sim(:,1,3))/1000;
    estat.distancia_R= mean(X_R_sim(:,1,3))/1000;
 
    % Define o valor do eixo coordenado:
    pontos= 1:1:numPontos;
    fPlotAnaliseA(pontos, estat, residuo_X_L, residuo_X_R, CalculaIncerteza_Y, X_L_sim, pontos3D);    
else
    for ctDist=1:numPontos
        estat.media_L_X(ctDist)= mean(X_L_sim(ctDist,:,1));
        estat.media_L_Y(ctDist)= mean(X_L_sim(ctDist,:,2));
        estat.media_L_Z(ctDist)= mean(X_L_sim(ctDist,:,3));
        
        estat.dp_L_X(ctDist)= std(X_L_sim(ctDist,:,1));
        estat.dp_L_Y(ctDist)= std(X_L_sim(ctDist,:,2));
        estat.dp_L_Z(ctDist)= std(X_L_sim(ctDist,:,3));
               
        estat.media_R_X(ctDist)= mean(X_R_sim(ctDist,:,1));
        estat.media_R_Y(ctDist)= mean(X_R_sim(ctDist,:,2));
        estat.media_R_Z(ctDist)= mean(X_R_sim(ctDist,:,3));

        estat.dp_R_X(ctDist)= std(X_R_sim(ctDist,:,1));
        estat.dp_R_Y(ctDist)= std(X_R_sim(ctDist,:,2));
        estat.dp_R_Z(ctDist)= std(X_R_sim(ctDist,:,3));

        estat.distancia_L(ctDist)= estat.media_L_Z(ctDist)/1000;
        estat.distancia_R(ctDist)= estat.media_R_Z(ctDist)/1000;
    end
    % Define o valor do eixo coordenado:
    pontos= distanciaNominal/1000; 
    
    p= polyfit(pontos, estat.dp_L_X, 2);
    curvaAjustada.x= polyval(p, pontos);
    
    p= polyfit(pontos, estat.dp_L_Y, 2);
    curvaAjustada.y= polyval(p, pontos);
    
    p= polyfit(pontos, estat.dp_L_Z, 2);
    curvaAjustada.z= polyval(p, pontos);
        
    % Exibe os resultados:
    close all;
    if ExibeGraficoComEstatistica && ExibeTabelaComEstatistica
        fPlotAnaliseB(pontos, estat, curvaAjustada, CalculaIncerteza_Y);
        fGeraTabelaEstatistica(pontos, estat, curvaAjustada, distanciaNominal, CalculaIncerteza_Y);
    elseif ExibeGraficoComEstatistica 
        fPlotAnaliseB(pontos, estat, curvaAjustada, CalculaIncerteza_Y);        
    elseif ExibeTabelaComEstatistica 
        fGeraTabelaEstatistica(pontos, estat, curvaAjustada, distanciaNominal, CalculaIncerteza_Y);
    end
end
end