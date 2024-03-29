function [p_left_out p_right_out]= fGeraCoordenadasPlanoImagem_mm(f_L, f_R, matrizT_World, matrizT_Stereo, P, sensorSize, pixelSize, sensorOrigin_L, sensorOrigin_R)
clc;

% Monta a matriz Intrinseca da câmera esquerda:
K_L= [f_L     0   -sensorOrigin_L(1)*pixelSize;
       0     f_L   -sensorOrigin_L(2)*pixelSize;
       0      0             1                   ];

% Monta a matriz Intrinseca da câmera direita:
K_R= [f_R     0   -sensorOrigin_R(1)*pixelSize;
       0     f_R   -sensorOrigin_R(2)*pixelSize;
       0      0             1                   ];


% Calcula a inversar da matriz de referência da câmera esquerda com relação ao mundo:
matrizT_World_inv= inv(matrizT_World);

[numPontos3D c]= size(P);

for ctPt=1:numPontos3D
    % Gera uma coordenada homogênea para o ponto P. Como a entrada é em metros, as coordenadas do ponto são convertidas para mm:
    P_H0=[P(ctPt,:)*1000 1];
    
    % Transformar o ponto P com relação ao sistema de cooredanadas da câmera esquerda (Verificar a página 323 do livro do Peter Corke):
    P_HC_left(ctPt,:)= matrizT_World_inv*P_H0'; 

    % Transformar o ponto P com relação ao sistema de cooredanadas da câmera direita (Verificar a página 323 do livro do Peter Corke):
    P_HC_rigth(ctPt,:)= inv(matrizT_Stereo)*P_HC_left(ctPt,:)';

    % Acha as coordenadas no plano imagem esquerdo em mm:
    p_left(ctPt,:)= K_L*P_HC_left(ctPt,1:3)'/P_HC_left(ctPt,3);
    p_left_out(ctPt,1)= p_left(ctPt,1)/pixelSize;
    p_left_out(ctPt,2)= p_left(ctPt,2)/pixelSize;

    % Acha as coordenadas no plano imagem direito em mm:
    p_right(ctPt,:)= K_R*P_HC_rigth(ctPt,1:3)'/P_HC_rigth(ctPt,3);   
    p_right_out(ctPt,1)= p_right(ctPt,1)/pixelSize;
    p_right_out(ctPt,2)= p_right(ctPt,2)/pixelSize;
end

close all;
figure
subplot(1,2,1);
plot(p_left_out(:,1), p_left_out(:,2), '.r', 'MarkerSize', 10);
xlabel('X - Pixels');
ylabel('Y - Pixels');
axis equal;

subplot(1,2,2);
plot(p_right_out(:,1), p_right_out(:,2), '.b', 'MarkerSize', 10);
xlabel('X - Pixels');
ylabel('Y - Pixels');
axis equal;

end