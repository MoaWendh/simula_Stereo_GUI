%**************************************************************************************************
% Moacir Wendhausen
% Esta função gera a matriz de transformação homogênea do sist. estéreo.
% Ou seja, transformação da câmera esquerda com relação a direita.
%**************************************************************************************************

function matrixT_Stereo= fGeraMatrizTransformacao_Stereo(handles)

% Monta a matriz de rotação da câmera direita com relação ao sist. de coordenadas da cãmera esquerda:

if handles.carregaCalibracaoFromFile
    matrixT_Stereo= fRodrigues(handles.rotStereo);
else
    angRot_X= deg2rad(handles.rotStereo(1));
    angRot_Y= deg2rad(handles.rotStereo(2));
    angRot_Z= deg2rad(handles.rotStereo(3));

    % Gera a matrix de rotação da câmera direita com relação à esquerda:
    rotX= rotx(angRot_X);
    rotY= rotx(angRot_Y);
    rotZ= rotx(angRot_Z);

    % Gera a matriz de rotação da câmera esquerda:
    rot= rotX*rotY*rotZ;

    % Extrai a matriz de translação da câmera esquerda:
    trans= handles.transStereo;

    % Gera a matriz de transformação da câmera esquerda com relação ao mundo:
    matrixT_Stereo= [rot trans'; [0 0 0 1]];   
end

angRot_X= handles.rotStereo(1);
angRot_Y= handles.rotStereo(2);
angRot_Z= handles.rotStereo(3);

% Gera a matrix de rotação da câmera direita com relação à esquerda:
rotX= rotx(angRot_X);
rotY= rotx(angRot_Y);
rotZ= rotx(angRot_Z);

% Gera a matriz de rotação da câmera esquerda:
rot= rotX*rotY*rotZ;

% Extrai a matriz de translação da câmera esquerda:
trans= handles.transStereo;

% Gera a matriz de transformação da câmera esquerda com relação ao mundo:
matrixT_Stereo= [rot trans'; [0 0 0 1]]; 

end