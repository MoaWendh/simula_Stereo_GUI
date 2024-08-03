function [estatistica, curvaAjustada]= fAnalisaIncertezas(X_L_sim, X_R_sim, numSimulacoes, ...
                                                          distanciaNominal, CalculaIncerteza_Y, ...
                                                          carregaPontosFromFile, pontos3D, ...
                                                          residuo_X_L, residuo_X_R)

[numPontos]= size(X_L_sim, 1);

if carregaPontosFromFile
    estatistica.media_L.x= mean(residuo_X_L(:,:,1));
    estatistica.media_L.y= 0;
    estatistica.media_L.z= mean(residuo_X_L(:,:,3));

    estatistica.dp_L.x= std(residuo_X_L(:,:,1));
    estatistica.dp_L.y= 0;
    estatistica.dp_L.z= std(residuo_X_L(:,:,3));
    
    estatistica.min_L.x= min(residuo_X_L(:,:,1));
    estatistica.min_L.y= 0;
    estatistica.min_L.z= min(residuo_X_L(:,:,3));
    
    estatistica.max_L.x= max(residuo_X_L(:,:,1));
    estatistica.max_L.y= 0;
    estatistica.max_L.z= max(residuo_X_L(:,:,3));

    estatistica.media_R.x= mean(residuo_X_R(:,:,1));
    estatistica.media_R.y= 0;
    estatistica.media_R.z= mean(residuo_X_R(:,:,3));

    estatistica.dp_R.x= std(residuo_X_R(:,:,1));
    estatistica.dp_R.y= 0;        
    estatistica.dp_R.z= std(residuo_X_R(:,:,3));

    estatistica.min_R.x= min(residuo_X_R(:,:,1));
    estatistica.min_R.y= 0;
    estatistica.min_R.z= min(residuo_X_R(:,:,3));
    
    estatistica.max_R.x= max(residuo_X_R(:,:,1));
    estatistica.max_R.y= 0;
    estatistica.max_R.z= max(residuo_X_R(:,:,3));
    
    estatistica.distancia_L= mean(X_L_sim(:,1,3))/1000;
    estatistica.distancia_R= mean(X_R_sim(:,1,3))/1000; 
else
    for ctDist=1:numPontos
        estatistica.media_L.x(ctDist)= mean(X_L_sim(ctDist,:,1));
        estatistica.media_L.y(ctDist)= mean(X_L_sim(ctDist,:,2));
        estatistica.media_L.z(ctDist)= mean(X_L_sim(ctDist,:,3));
        
        estatistica.dp_L.x(ctDist)= std(X_L_sim(ctDist,:,1));
        estatistica.dp_L.y(ctDist)= std(X_L_sim(ctDist,:,2));
        estatistica.dp_L.z(ctDist)= std(X_L_sim(ctDist,:,3));
        
        estatistica.min_L.x(ctDist)= min(residuo_X_L(ctDist,:,1));
        estatistica.min_L.y(ctDist)= min(residuo_X_L(ctDist,:,2));
        estatistica.min_L.z(ctDist)= min(residuo_X_L(ctDist,:,3));

        estatistica.max_L.x(ctDist)= max(residuo_X_L(ctDist,:,1));
        estatistica.max_L.y(ctDist)= max(residuo_X_L(ctDist,:,2));
        estatistica.max_L.z(ctDist)= max(residuo_X_L(ctDist,:,3));
               
        estatistica.media_R.x(ctDist)= mean(X_R_sim(ctDist,:,1));
        estatistica.media_R.y(ctDist)= mean(X_R_sim(ctDist,:,2));
        estatistica.media_R.z(ctDist)= mean(X_R_sim(ctDist,:,3));

        estatistica.dp_R.x(ctDist)= std(X_R_sim(ctDist,:,1));
        estatistica.dp_R.y(ctDist)= std(X_R_sim(ctDist,:,2));
        estatistica.dp_R.y(ctDist)= std(X_R_sim(ctDist,:,3));

        estatistica.min_R.x(ctDist)= min(residuo_X_R(ctDist,:,1));
        estatistica.min_R.y(ctDist)= min(residuo_X_R(ctDist,:,2));
        estatistica.min_R.z(ctDist)= min(residuo_X_R(ctDist,:,3));

        estatistica.max_R.x(ctDist)= max(residuo_X_R(ctDist,:,1));
        estatistica.max_R.y(ctDist)= max(residuo_X_R(ctDist,:,2));
        estatistica.max_R.z(ctDist)= max(residuo_X_R(ctDist,:,3));        

        estatistica.distancia_L(ctDist)= estatistica.media_L.z(ctDist)/1000;
        estatistica.distancia_R(ctDist)= estatistica.media_R.z(ctDist)/1000;
    end
    % Define o valor do eixo coordenado:
    pontos= distanciaNominal/1000; 
    
    p= polyfit(pontos, estatistica.dp_L.x, 2);
    curvaAjustada.x= polyval(p, pontos);
    
    p= polyfit(pontos, estatistica.dp_L.y, 2);
    curvaAjustada.y= polyval(p, pontos);
    
    p= polyfit(pontos, estatistica.dp_L.z, 2);
    curvaAjustada.z= polyval(p, pontos);
end
end