%**************************************************************************************************
% Moacir Wendhausen
% Esta função gera a matriz de transformação da câmera qesquerda com relação ao Mundo.
%**************************************************************************************************

function matrixT_World= fGeraMatrizTransformacao_LeftCamWorld(rotLeftCamWorld, transLeftCamWorld)

% Gera a matriz de transformação da câmera esquerda com relação ao mundo:
matrixT_World= [rotLeftCamWorld transLeftCamWorld'; [0 0 0 1]];   

end