function [p_left p_right]= fCalculaPontosNoPlanoImagem(pontos3D, ... 
                                                       paramStereo, ...
                                                       carregaCalibracaoFromFile, ...
                                                       numSimulacoes)
                                                  
clc;

% Extraindo os parâmetros par varáveis locais: 
pixelSize= paramStereo.pixelSize;

% Tamanho do sensor em mm:
sensorSize= paramStereo.sensorSize(1)*pixelSize;

% Origem do sistema de coordenadas do plano sensor:
x0_L= paramStereo.sensorOrigin_L(1)*pixelSize;
y0_L= paramStereo.sensorOrigin_L(2)*pixelSize;
x0_R= paramStereo.sensorOrigin_R(1)*pixelSize;
y0_R= paramStereo.sensorOrigin_R(2)*pixelSize;


% COmprimento focal em pixels para mm:
f_L= paramStereo.comprimentoFocal_L(1)*pixelSize;
f_R= paramStereo.comprimentoFocal_R(1)*pixelSize;

% Chama a função que gera a matriz de transformação homogênea da câmera esquerda com relação ao sist. de coordenadas do mundo:
matrizT_World= fGeraMatrizTransformacao_LeftCamWorld(paramStereo.rotLeftCamWorld, paramStereo.transLeftCamWorld);

% Chama a função que gera a matriz de transformação Stereo, ou seja a transformação da câmera direita com relação à cÂmera esquerda:
matrizT_Stereo= fGeraMatrizTransformacao_Stereo(paramStereo.matrizR, paramStereo.vetorT, carregaCalibracaoFromFile);

% Gera as coordenadas do ponto 3D no plano imagem, ainda em mm, para a scam. esquerda e direita:
[p_left p_right]= fGeraCoordenadasPlanoImagem(f_L, f_R, matrizT_World, matrizT_Stereo, ... 
                                                 pontos3D, sensorSize, pixelSize, ...
                                                 x0_L, y0_L, x0_R, y0_R, ...
                                                 paramStereo.sensorOrigin_L, paramStereo.sensorOrigin_R, ...
                                                 numSimulacoes, carregaCalibracaoFromFile);

                                       

end