function [p_left p_right]= fSimulaIncertezaStereo(ptoPlanoImagem_left, ptoPlanoImagem_right, ...
                                                  pontos3D, pixelSize, sensorSize, ... 
                                                  sensorOrigin_L, sensorOrigin_R, ...
                                                  comprimentoFocal_L, comprimentoFocal_R, ...
                                                  rotStereo, transStereo, ...
                                                  rotLeftCamWorld, transLeftCamWorld, ...
                                                  carregaCalibracaoFromFile, numSimulacoes, ...
                                                  incerteza)

Parei Aqui!!! Falta elaborar as incertezas!!

clc;

% Carrega as incertezas para cad parâmetro:


% Extraindo os parâmetros par varáveis locais: 
pixelSize= pixelSize;

% Tamanho do sensor em mm:
sensorSize= sensorSize(1)*pixelSize;

for ctSimulacao=1:numSimulacoes

    % Origem do sistema de coordenadas do plano sensor:
    u0_L= sensorOrigin_L(1)*pixelSize;
    yo_L= sensorOrigin_L(2)*pixelSize;
    u0_R= sensorOrigin_R(1)*pixelSize;
    yo_R= sensorOrigin_R(2)*pixelSize;


    % COmprimento focal em pixels para mm:
    f_L= comprimentoFocal_L(1);
    f_R= comprimentoFocal_R(1);

    % Chama a função que gera a matriz de transformação homogênea da câmera esquerda com relação ao sist. de coordenadas do mundo:
    matrizT_World= fGeraMatrizTransformacao_LeftCamWorld(rotLeftCamWorld, transLeftCamWorld);

    % Chama a função que gera a matriz de transformação Stereo, ou seja a transformação da câmera direita com relação à cÂmera esquerda:
    matrizT_Stereo= fGeraMatrizTransformacao_Stereo(rotStereo, transStereo, carregaCalibracaoFromFile);

    % Gera as coordenadas do ponto 3D no plano imagem, ainda em mm, para a scam. esquerda e direita:
    [p_left p_right]= fGeraCoordenadasPlanoImagem_mm(f_L, f_R, matrizT_World, matrizT_Stereo, pontos3D, ...
                                                     sensorSize, pixelSize, ... 
                                                     sensorOrigin_L, sensorOrigin_R);
                                      
end
end