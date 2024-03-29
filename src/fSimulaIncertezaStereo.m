function simulacao= fSimulaIncertezaStereo(ptoPlanoImagem_left, ptoPlanoImagem_right, ...
                                           pontos3D, paramStereo, incerteza, ... 
                                           carregaCalibracaoFromFile, numSimulacoes)

close all;
clc;

%******************************* Definição das incertezas ********************************
% Incerteza do comprimento focal:                                              
uf= incerteza.ComprimentoFocal_L(1);
% Incerteza da disparidade:
ud= incerteza.Disparidade;
% Incerteza na localização da coordenada x no plano imagem:
ux= incerteza.X;
% Incerteza na localização da coordenada y no plano imagem:
uy= incerteza.Y;
% Incerteza no baseline, esta incerteza utliza a mesma incerteza decorrente da tranlação.
% Isto porque o cálculo do baseline é pfeito pela translação da cam. R com relação a cam. L:
ub= incerteza.TranslacaoStereo;

% **************************** Carrega os parêmtros estéreo ******************************
% Carrega o comprimento focal já em mm: 
f_L= paramStereo.comprimentoFocal_L;
f_R= paramStereo.comprimentoFocal_R;
% Extraindo os parâmetros par varáveis locais: 
pixelSize= paramStereo.pixelSize;
% Tamanho do sensor em mm:
sensorSize= paramStereo.sensorSize(1)*pixelSize;
% Origem do sensor:
sensorOrigem_L= paramStereo.sensorOrigin_L;
sensorOrigem_R= paramStereo.sensorOrigin_R;
% Carrega o vetor de rotação do sistema estéreo:
vetorR= paramStereo.vetorR; 
% Matriz de rotação estéreo:
R= paramStereo.matrizR;
% Vetor de translação estéreo:
t= paramStereo.vetorT;
%Carrega as distorções:
skell_L= paramStereo.skell_L;
skell_R= paramStereo.skell_R;
distorcao_L= paramStereo.distorcaoLente_L;
distorcao_R= paramStereo.distorcaoLente_R;


% Efetua a varredura para n simulações, a cada iteração as incertezas do sistema estéreo
% são atualizadas:
[numPontos numcoords]= size(pontos3D);
for ctSimulacao=1:numPontos
    
%     f_L= paramStereo.comprimentoFocal_L(1) + uf*randn();
%     
%     % Origem do sistema de coordenadas do plano sensor:
%     u0_L= sensorOrigem_L(1)*pixelSize;
%     yo_L= sensorOrigem_L(2)*pixelSize;
%     u0_R= sensorOrigem_R(1)*pixelSize;
%     yo_R= sensorOrigem_R(2)*pixelSize;
% 
%   
% 
% 
%     % Chama a função que gera a matriz de transformação homogênea da câmera esquerda com relação ao sist. de coordenadas do mundo:
%     matrizT_World= fGeraMatrizTransformacao_LeftCamWorld(rotLeftCamWorld, transLeftCamWorld);
% 
%     % Chama a função que gera a matriz de transformação Stereo, ou seja a transformação da câmera direita com relação à cÂmera esquerda:
%     matrizT_Stereo= fGeraMatrizTransformacao_Stereo(rotStereo, transStereo, carregaCalibracaoFromFile);
  
     % Nã há necessiade de inserir a distorção das lentes, uma vez que os
     % dados usados pata gerar o 3D já estavam com a distorção corrigida:
     distorcaoLente_L= [0 0 0 0 0]';
     distorcaoLente_R= [0 0 0 0 0]';

     % Chama a função stereo_triangulation para determinar a projeção dos pontos 3D referentes a imagem esquerda e direita, 
     [X_L(ctSimulacao,:), X_R(ctSimulacao,:)] = fStereoTriangulation(ptoPlanoImagem_left(ctSimulacao,:)', ...
                                                                     ptoPlanoImagem_right(ctSimulacao,:)', ...
                                                                     vetorR, t, ... 
                                                                     f_L, sensorOrigem_L,  distorcaoLente_L, skell_L, ...
                                                                     f_R, sensorOrigem_R,  distorcaoLente_R, skell_R);

    [M_L, M_R]= fStereoTriangulation_moa(ptoPlanoImagem_left(ctSimulacao,:)', ...
                                         ptoPlanoImagem_right(ctSimulacao,:)', ...
                                         vetorR, t, ... 
                                         f_L, sensorOrigem_L,  distorcaoLente_L, skell_L, ...
                                         f_R, sensorOrigem_R,  distorcaoLente_R, skell_R, ...
                                         X_L, X_R, pixelSize);
  
end

% Os pontos 3D gerados pelo aplicativo processa_Stereo_LiDAR_GUI são
% referentes a visão da câmera direita. Assim, para mais precisão, também
% usar os pontos reconstru[idos a partir da visão da cãmera direita.
plot3(pontos3D(:,1), pontos3D(:,2), pontos3D(:,3), 'or');
hold on;

plot3(X_R(:,1), X_R(:,2), X_R(:,3),'.b');
axis equal;
xlabel('X');
ylabel('Y');
zlabel('X');


end