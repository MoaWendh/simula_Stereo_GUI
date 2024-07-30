function resultados= fAnalisaIncertezas(X_L_sim, X_R_sim, numSimulacoes, ...
                                        distanciaNominal, CalculaIncerteza_Y, ...
                                        carregaPontosFromFile, pontos3D_real, ...
                                        residuo_X_L, residuo_X_R)
close all;
    
[numPontos]= size(X_L_sim, 1);

if carregaPontosFromFile
    media_L_X= mean(residuo_X_L(:,:,1));
    media_L_Y= 0;
    media_L_Z= mean(residuo_X_L(:,:,3));

    dp_L_X= std(residuo_X_L(:,:,1));
    dp_L_Y= 0;
    dp_L_Z= std(residuo_X_L(:,:,3));

    media_R_X= mean(residuo_X_L(:,:,1));
    media_R_Y= 0;
    media_R_Z= mean(residuo_X_L(:,:,3));

    dp_R_X= std(residuo_X_L(:,:,1));
    dp_R_Y= 0;        
    dp_R_Z= std(residuo_X_L(:,:,3));

    distancia_L= mean(X_L_sim(:,1,3))/1000;
    distancia_R= mean(X_R_sim(:,1,3))/1000;
 
    % Define o valor do eixo coordenado:
    pontos= 1:1:numPontos;
    fPlotAnaliseA(pontos, dp_L_X, dp_L_Y, dp_L_Z, dp_R_X, dp_R_Y, dp_R_Z, residuo_X_L, residuo_X_R, CalculaIncerteza_Y, X_L_sim, pontos3D_real);    
else
    for ctDist=1:numPontos
        media_L_X(ctDist)= mean(X_L_sim(ctDist,:,1));
        media_L_Y(ctDist)= mean(X_L_sim(ctDist,:,2));
        media_L_Z(ctDist)= mean(X_L_sim(ctDist,:,3));
        
        x_t= X_L_sim(ctDist,:,1) - media_L_X(ctDist);
        y_t= X_L_sim(ctDist,:,2) - media_L_Y(ctDist);
        z_t= X_L_sim(ctDist,:,3) - media_L_Z(ctDist);
        
        dp_x_t(ctDist)= std(x_t); 
        dp_y_t(ctDist)= std(y_t);        
        dp_z_t(ctDist)= std(z_t);
        
        dp_L_X(ctDist)= std(X_L_sim(ctDist,:,1));
        dp_L_Y(ctDist)= std(X_L_sim(ctDist,:,2));
        dp_L_Z(ctDist)= std(X_L_sim(ctDist,:,3));
                
        dp_L_Z_res(ctDist)= std(residuo_X_L(ctDist,:,3));

        media_R_X(ctDist)= mean(X_R_sim(ctDist,:,1));
        media_R_Y(ctDist)= mean(X_R_sim(ctDist,:,2));
        media_R_Z(ctDist)= mean(X_R_sim(ctDist,:,3));

        dp_R_X(ctDist)= std(X_R_sim(ctDist,:,1));
        dp_R_Y(ctDist)= std(X_R_sim(ctDist,:,2));
        dp_R_Z(ctDist)= std(X_R_sim(ctDist,:,3));

        distancia_L(ctDist)= media_L_Z(ctDist)/1000;
        distancia_R(ctDist)= media_R_Z(ctDist)/1000;
    end
    % Define o valor do eixo coordenado:
    pontos= distanciaNominal/1000; 
    
    p= polyfit(pontos, dp_L_X, 2);
    curvaAjustada.x= polyval(p, pontos);
    
    p= polyfit(pontos, dp_L_Y, 2);
    curvaAjustada.y= polyval(p, pontos);
    
    p= polyfit(pontos, dp_L_Z, 2);
    curvaAjustada.z= polyval(p, pontos);
        
    %Chama função para plotar os resultados:
    fPlotAnaliseB(pontos, dp_L_X, dp_L_Y, dp_L_Z, dp_R_X, dp_R_Y, dp_R_Z, curvaAjustada);
end

resultados= 0;
end