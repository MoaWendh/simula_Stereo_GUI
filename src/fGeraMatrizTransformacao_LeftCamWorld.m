%**************************************************************************************************
% Moacir Wendhausen
% Esta função gera a matriz de transformação da câmera qesquerda com relação ao Mundo.
%**************************************************************************************************

function matrixT_World= fGeraMatrizTransformacao_LeftCamWorld(rotLeftCamWorld, transLeftCamWorld)

% Monta a matriz de rotação da câmera esquerda com relação ao sist. de coordenadas do mundo:
angRotLeftCam_X= deg2rad(rotLeftCamWorld(1));
angRotLeftCam_Y= deg2rad(rotLeftCamWorld(2));
angRotLeftCam_Z= deg2rad(rotLeftCamWorld(3));

% Gera a matrix d erotação para cada eixo da câmera esquerda:
rotX= rotx(angRotLeftCam_X);
rotY= rotx(angRotLeftCam_Y);
rotZ= rotx(angRotLeftCam_Z);

% Gera a matriz de rotação da câmera esquerda:
rotLeftCam= rotX*rotY*rotZ;

% Extrai a matriz de translação da câmera esquerda:
transLeftCam= transLeftCamWorld;

% Gera a matriz de transformação da câmera esquerda com relação ao mundo:
matrixT_World= [rotLeftCam transLeftCam'; [0 0 0 1]];   

end