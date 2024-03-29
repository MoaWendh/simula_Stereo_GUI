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
x0_L= 1*paramStereo.sensorOrigin_L(1);
y0_L= 1*paramStereo.sensorOrigin_L(2);
x0_R= 1*paramStereo.sensorOrigin_R(1);
y0_R= 1*paramStereo.sensorOrigin_R(2);


% COmprimento focal em pixels para mm:
f_L(1)= paramStereo.comprimentoFocal_L(1);
f_L(2)= paramStereo.comprimentoFocal_L(2);
f_R(1)= paramStereo.comprimentoFocal_R(1);
f_R(2)= paramStereo.comprimentoFocal_R(2);

% Monta a matriz Intrinseca da câmera esquerda com valores em mm:
M_Intrinc_L= [f_L(1)*pixelSize       0             x0_L*pixelSize    0;
                    0          f_L(2)*pixelSize    y0_L*pixelSize    0;
                    0                0                     1         0];
   
% % Monta a matriz Intrinseca da câmera direita:
M_Intrinc_R= [f_R(1)*pixelSize       0             x0_R*pixelSize    0;
                    0          f_R(2)*pixelSize    y0_R*pixelSize    0;
                    0                0                     1         0];

% Calcula a matriz inversa da câmera esquerda com relação ao mundo:
matrizT_World_inv= inv(matrizT_World);

% Matriz estéreo neutra para testes:
 matrizT_Stereo= [eye(4,3) [-500 0 0 1]']

% Define o número de pontos para simulação:
[numPontos numCoords]= size(pontos3D);

% Atenbção, como os pontos 3D carregados de arquivo já estão com a
% distorção corrigida, não pe necessário repassar as distorção para a
% tringulação:
distorcaoLente_L= [0 0 0 0 0]';
distorcaoLente_R= [0 0 0 0 0]';

% Para cada ponto de entrada é encontrado a sua projeção nos planos imagens
% equerdo e direito. Apenas depois de conhecidas as coordenadas dos planos
% imagens, elas sevirão para gerar a simulação para cada um desses pontos:
for ctPt=1:numPontos
    % Gera uma coordenada homogênea para o ponto P. As coordenadas já estão em mm:    
    P_HC_right_3D=[pontos3D(ctPt,:) 1];
    
    % Transformar o ponto P com relação ao sistema de coordenadas da câmera direita (Verificar a página 323 do livro do Peter Corke):
%     P_HC_right_3D= matrizT_World_inv*P_H0_3D'; 
    
    % Transformar o ponto P com relação ao sistema de coordenadas da câmera esquerda (Verificar a página 323 do livro do Peter Corke).
    % As coordenadas do ponto 2D "p_left_2D_H" já estão mapeados no sensor:
    p_left_2D_H= M_Intrinc_L*inv(matrizT_Stereo)*P_HC_right_3D';
    
    % Converte de homogêneo para cartesiano e em pixel:
    p_left_2D(1)= round((p_left_2D_H(1)/p_left_2D_H(3))/pixelSize);
    p_left_2D(2)= round((p_left_2D_H(2)/p_left_2D_H(3))/pixelSize); 

    % Acha as coordenadas no plano imagem direito em mm:
    p_right_2D_H= M_Intrinc_R*P_HC_right_3D'; 
    % Converte de homogêneo para cartesiano e em pixel: 
    p_right_2D(1)= round((p_right_2D_H(1)/p_right_2D_H(3))/pixelSize);
    p_right_2D(2)= round((p_right_2D_H(2)/p_right_2D_H(3))/pixelSize);

    
    %************* Outra forma de calcular as coordenadas x e y:
    %baseline= -1*sqrt(matrizT_Stereo(1,4)^2 + matrizT_Stereo(2,4)^2 + matrizT_Stereo(3,4)^2);
    baseline= matrizT_Stereo(1,4);
    X= P_HC_right_3D(1);
    Y= P_HC_right_3D(2);
    Z= P_HC_right_3D(3);
    uL= round((f_L(1)*pixelSize*((X-baseline)/Z) + x0_L*pixelSize)/pixelSize);
    vL= round((f_L(2)*(Y/Z) + y0_L)/pixelSize);
    
    uR= round((f_R(1)*((X)/Z) + x0_R)/pixelSize);
    vR= round((f_R(2)*(Y/Z) + y0_R)/pixelSize);

    p_left(ctPt,:)= [uL vL];
    p_right(ctPt,:)= [uR vR];
    
% % Nã há necessiade de colocar adistorção, uma vez que os pontos 3D de entrada já estão com a distorção corrigida. 
[X_LA(:,ctPt), X_RA(:,ctPt)] = fStereoTriangulation_moa(p_left(ctPt,:)', p_right(ctPt,:)',  paramStereo.vetorR, paramStereo.vetorT, ... 
                                  paramStereo.comprimentoFocal_L, sensorOrigin_L,  distorcaoLente_L, paramStereo.skell_L, ...
                                  paramStereo.comprimentoFocal_R, sensorOrigin_R,  distorcaoLente_R, paramStereo.skell_R, ...
                                  pixelSize, matrizT_Stereo);

% % Nã há necessiade de colocar adistorção, uma vez que os pontos 3D de entrada já estão com a distorção corrigida. 
[X_LB(:,ctPt), X_RB(:,ctPt)] = fStereoTriangulation_moa(p_left_2D', p_right_2D',  paramStereo.vetorR, paramStereo.vetorT, ... 
                                  paramStereo.comprimentoFocal_L, sensorOrigin_L,  distorcaoLente_L, paramStereo.skell_L, ...
                                  paramStereo.comprimentoFocal_R, sensorOrigin_R,  distorcaoLente_R, paramStereo.skell_R, ...
                                  pixelSize, matrizT_Stereo);
end


close all;


plot3(pontos3D(:,1), pontos3D(:,2), pontos3D(:,3), 'or');
hold on;
xlabel('X');
ylabel('Y');
zlabel('Z');
axis equal;

plot3(X_RA(1,:), X_RA(2,:), X_RA(3,:), '.b');
plot3(X_RB(1,:), X_RB(2,:), X_RB(3,:), '.g');



close all;
fig= figure;
fig.Position= [1117 300 1391 900];  
 
% Plota o ponto na tela como se fosse o plano imagem do sensor, a origem do plano
% coordenado u e v está no canto superior esquerdo:
subplot(1,2,1);
plot(p_left_2D(:,1), p_left_2D(:,2), '.r', 'MarkerSize', 15);
msgTexto=sprintf('Plano Imagem Esquerdo - disparidade= %d pixels', abs(round(p_left_2D(1,1) - p_right_2D(1,1))));
title(msgTexto);
xlabel('X - Pixels');
ylabel('Y - Pixels');
xlim([0 2047]);
ylim([0 2047]);
grid on;
% axis equal;
h1= gca;
% Inverte o eixo vertical, para colocar a origem do sensor no canto superior esquerdo:
set(h1,'YDir','reverse');


% Plota o ponto na tela como se fosse o plano imagem dos ensor, a origem do plano
% coordenado u e v está no canto superior esquerdo:
subplot(1,2,2);
plot(p_right_2D(:,1), p_right_2D(:,2), '.b', 'MarkerSize', 15);
msgTexto=sprintf('Plano Imagem Direito - disparidade= %d pixels', abs(round((p_left_2D(1,1) - p_right_2D(1,1)))));
title(msgTexto);
xlabel('X - Pixels');
ylabel('Y - Pixels');
xlim([0 2047]);
ylim([0 2047]);
grid on;
% axis equal;
h2= gca;
% Inverte o eixo vertical, para colocar a origem do sensor no canto superior esquerdo:
set(h2,'YDir','reverse');


end