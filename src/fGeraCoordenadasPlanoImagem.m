function [p_left_out p_right_out]= fGeraCoordenadasPlanoImagem(f_L, f_R, matrizT_World, matrizT_Stereo, ...
                                                               P, sensorSize, pixelSize, ...
                                                               x0_L, y0_L, x0_R, y0_R, ...
                                                               sensorOrigin_L, sensorOrigin_R, ...
                                                               numSimulacoes, carregaCalibracaoFromFile)
clc;

% Monta a matriz Intrinseca da câmera esquerda:
% K_L= [f_L     0    sensorOrigin_L(1)*pixelSize;
%        0     f_L   sensorOrigin_L(2)*pixelSize;
%        0      0             1                  ];
K_L= [f_L     0     0;
       0     f_L    0;
       0      0     1];
   
% % Monta a matriz Intrinseca da câmera direita:
% K_R= [f_R     0    sensorOrigin_R(1)*pixelSize;
%        0     f_R   sensorOrigin_R(2)*pixelSize;
%        0      0             1                  ];
K_R= [f_R     0     0;
       0     f_R    0;
       0      0     1];



% Calcula a matriz inversa da câmera esquerda com relação ao mundo:
matrizT_World_inv= inv(matrizT_World);

% Define o número de pontos para simulação:
[numPontos numCoords]= size(P);

% Para cada ponto de entrada é encontrado a sua projeção nos planos imagens
% equerdo e direito. Apenas depois de conhecidas as coordenadas dos planos
% imagens, elas sevirão para gerar a simulação para cada um desses pontos:
for ctPt=1:numPontos
    % Gera uma coordenada homogênea para o ponto P. Como a entrada é em metros, as coordenadas já estão em mm:    
    P_H0=[P(ctPt,:) 1];
    
    % Transformar o ponto P com relação ao sistema de cooredanadas da câmera esquerda (Verificar a página 323 do livro do Peter Corke):
    P_HC_right= matrizT_World_inv*P_H0'; 
    %P_HC_right(ctPt,:)= P_H0'; 
    
    % Transformar o ponto P com relação ao sistema de cooredanadas da câmera direita (Verificar a página 323 do livro do Peter Corke):
    P_HC_left= inv(matrizT_Stereo)*P_HC_right;
    
    % Acha as coordenadas no plano imagem esquerdo em mm:
    p_left= K_L*(P_HC_left(1:3,1)/P_HC_left(3,1));
    p_left_out(ctPt,1)= (p_left(1)/pixelSize) + sensorOrigin_L(1);
    p_left_out(ctPt,2)= (p_left(2)/pixelSize) + sensorOrigin_L(2);

    % Acha as coordenadas no plano imagem direito em mm:
    p_right= K_R*(P_HC_right(1:3,1)/P_HC_right(3,1));   
    p_right_out(ctPt,1)= (p_right(1)/pixelSize) + sensorOrigin_R(1);
    p_right_out(ctPt,2)= (p_right(2)/pixelSize) + sensorOrigin_R(2);
end

close all;
fig= figure;
fig.Position= [1117 300 1391 900];   

subplot(1,2,1);
plot(p_left_out(:,1), p_left_out(:,2), '.r', 'MarkerSize', 15);
title('Plano Imagem Esquerdo');
xlabel('X - Pixels');
ylabel('Y - Pixels');
% xlim([0 2048]);
% ylim([0 2048]);
grid on;
axis equal;

subplot(1,2,2);
plot(p_right_out(:,1), p_right_out(:,2), '.b', 'MarkerSize', 15);
title('Plano Imagem Direito');
xlabel('X - Pixels');
ylabel('Y - Pixels');
% xlim([0 2048]);
% ylim([0 2048]);
grid on;
axis equal;
end