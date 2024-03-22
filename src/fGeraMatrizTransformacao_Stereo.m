%**************************************************************************************************
% Moacir Wendhausen
% Esta função gera a matriz de transformação homogênea do sist. estéreo.
% Ou seja, transformação da câmera esquerda com relação a direita.
%**************************************************************************************************

function matrixT_Stereo= fGeraMatrizTransformacao_Stereo(rotStereo, transStereo, carregaCalibracaoFromFile)

% Monta a matriz de rotação da câmera direita com relação ao sist. de coordenadas da cãmera esquerda:

if carregaCalibracaoFromFile    
    % Gera a matriz de transformação da câmera esquerda com relação ao mundo:
    matrixT_Stereo= [rotStereo transStereo; [0 0 0 1]]; 
else
    % Gera a matriz de transformação da câmera esquerda com relação ao mundo:
    matrixT_Stereo= [rotStereo transStereo'; [0 0 0 1]];   
end

end