function [p_left p_right]= fGeraCoordenadasPlanoImagem_mm(f, matrizT_World, matrizT_Stereo, P)

M= [f   0   0;
    0   f   0;
    0   0   1];

% Gera uma coordenada homogênea para o ponto P:
P_H0=[P 1];

% Transforma as coordenadas do ponto P_H0, que está em relação ao mundo, com relação ao sistema de
% coordenadas da câmera, P_HC, esquerda:
% 1°) encontrar a inversar da matriz de referência da câmera esquerda com relação ao mundo:
matrizT_World_inv= inv(matrizT_World(:,1:3));

% 2º) Transformar o ponto P com relação ao sistema de cooredanadas da câmera:
% Verificar a página 323 do livro do Peter Corke:
P_HC= matrizT_World_inv*P_H0';  

% Achar as coordenadas no plano imagem em mm:
p_left= M*P_HC;

p_right= M*matrixT_Stereo*matrixT_World*P';



end