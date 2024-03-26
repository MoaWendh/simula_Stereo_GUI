function [p_left_2D p_right_2D]= fGeraCoordenadasPlanoImagem(pontos3D, paramStereo, ...
                                                             matrizT_World, ...
                                                             matrizT_Stereo, ... 
                                                             numSimulacoes, ...
                                                             carregaCalibracaoFromFile)
clc;

% Extraindo os parâmetros par varáveis locais: 
pixelSize= paramStereo.pixelSize;

% Tamanho do sensor em mm:
sensorSize= paramStereo.sensorSize(1);

% Define a origen das coordenadas x,y no plano sensor:
sensorOrigin_L= paramStereo.sensorOrigin_L;
sensorOrigin_R= paramStereo.sensorOrigin_R;

% Origem do sistema de coordenadas do plano sensor:
x0_L= 1*paramStereo.sensorOrigin_L(1)*pixelSize;
y0_L= 1*paramStereo.sensorOrigin_L(2)*pixelSize;
x0_R= 1*paramStereo.sensorOrigin_R(1)*pixelSize;
y0_R= 1*paramStereo.sensorOrigin_R(2)*pixelSize;


% COmprimento focal em pixels para mm:
f_L= paramStereo.comprimentoFocal_L(1)*pixelSize;
f_R= paramStereo.comprimentoFocal_L(1)*pixelSize;

% Monta a matriz Intrinseca da câmera esquerda:
M_Intrinc_L= [f_L     0     x0_L    0;
               0     f_L    y0_L    0;
               0      0      1      0];
   
% % Monta a matriz Intrinseca da câmera direita:
M_Intrinc_R= [f_R     0     x0_R    0;
               0     f_R    y0_R    0;
               0      0      1      0];

% Calcula a matriz inversa da câmera esquerda com relação ao mundo:
matrizT_World_inv= inv(matrizT_World);

% Matriz estéreo neutra para testes:
% matrizT_Stereo= [eye(4,3) matrizT_Stereo(:,4)]

% Define o número de pontos para simulação:
[numPontos numCoords]= size(pontos3D);


% Para cada ponto de entrada é encontrado a sua projeção nos planos imagens
% equerdo e direito. Apenas depois de conhecidas as coordenadas dos planos
% imagens, elas sevirão para gerar a simulação para cada um desses pontos:
for ctPt=1:numPontos
    % Gera uma coordenada homogênea para o ponto P. As coordenadas já estão em mm:    
    P_H0_3D=[pontos3D(ctPt,:) 1];
    
    % Transformar o ponto P com relação ao sistema de coordenadas da câmera direita (Verificar a página 323 do livro do Peter Corke):
    P_HC_right_3D= matrizT_World_inv*P_H0_3D'; 
    
    % Transformar o ponto P com relação ao sistema de coordenadas da câmera esquerda (Verificar a página 323 do livro do Peter Corke):
    P_HC_left_3D= inv(matrizT_Stereo)*P_HC_right_3D;
    %P_HC_left_3D= matrizT_Stereo\P_HC_right_3D;
    
    % Acha as coordenadas no plano imagem esquerdo em mm:
    p_left_2D_H= M_Intrinc_L*P_HC_left_3D;
    % Converte de homogêneo para cartesiano e em pixel:
    p_left_2D(ctPt,1)= round((p_left_2D_H(1)/p_left_2D_H(3))/pixelSize);
    p_left_2D(ctPt,2)= round((p_left_2D_H(2)/p_left_2D_H(3))/pixelSize); 

    % Acha as coordenadas no plano imagem direito em mm:
    p_right_2D_H= M_Intrinc_R*P_HC_right_3D; 
    % Converte de homogêneo para cartesiano e em pixel: 
    p_right_2D(ctPt,1)= round((p_right_2D_H(1)/p_right_2D_H(3))/pixelSize);
    p_right_2D(ctPt,2)= round((p_right_2D_H(2)/p_right_2D_H(3))/pixelSize);
end

Parei aqui!!!!
Parece que funcionou, coverificar os parêmtros usados na tringulação 3D no processa_stereo_Lidar_GUI

[X_L, X_R] = fStereoTriangulation(p_left_2D', p_right_2D',  paramStereo.vetorR, paramStereo.vetorT, ... 
                                  paramStereo.comprimentoFocal_L, sensorOrigin_L,  paramStereo.distorcaoLente_L, paramStereo.skell_L, ...
                                  paramStereo.comprimentoFocal_R, sensorOrigin_R,  paramStereo.distorcaoLente_R, paramStereo.skell_R);
close all;


plot3(X_R(1,:), X_R(2,:), X_R(3,:), '.r');
hold on;
xlabel('X');
ylabel('Y');
zlabel('Z');
axis equal;

plot3(pontos3D(:,1), pontos3D(:,2), pontos3D(:,3), 'ob');


close all;
fig= figure;
fig.Position= [1117 300 1391 900];  
 

subplot(1,2,1);
plot(p_left_2D(1), p_left_2D(2), '.r', 'MarkerSize', 15);
msgTexto=sprintf('Plano Imagem Esquerdo - disparidade= %d pixels', abs(round(p_left_2D(1,1) - p_right_2D(1,1))));
title(msgTexto);
xlabel('X - Pixels');
ylabel('Y - Pixels');
% xlim([0 2048]);
% ylim([0 2048]);
grid on;
axis equal;


subplot(1,2,2);
plot(p_right_2D(1), p_right_2D(2), '.b', 'MarkerSize', 15);
msgTexto=sprintf('Plano Imagem Direito - disparidade= %d pixels', abs(round((p_left_2D(1,1) - p_right_2D(1,1)))));
title(msgTexto);
xlabel('X - Pixels');
ylabel('Y - Pixels');
% xlim([0 2048]);
% ylim([0 2048]);
grid on;
axis equal;

end