function [p_left_2D p_right_2D distanciaNominal]= fGeraCoordenadasPlanoImagem(pontos3D, paramStereo, ...
                                                                              matrizT_World, ...
                                                                              matrizT_Stereo, ... 
                                                                              carregaPontosFromFile, ...
                                                                              HabShowPontosPlanoImagem)
clc;

% Extraindo os parâmetros par varáveis locais: 
pixelSize= paramStereo.pixelSize;

% Tamanho do sensor em mm:
sensorSize= paramStereo.sensorSize(1);

% Define a origen das coordenadas x,y no plano sensor:
sensorOrigin_L= paramStereo.sensorOrigin_L;
sensorOrigin_R= paramStereo.sensorOrigin_R;

% Origem do sistema de coordenadas do plano sensor:
u0_L= paramStereo.sensorOrigin_L(1);
v0_L= paramStereo.sensorOrigin_L(2);
u0_R= paramStereo.sensorOrigin_R(1);
v0_R= paramStereo.sensorOrigin_R(2);


% COmprimento focal em pixels para mm:
f_L(1)= paramStereo.comprimentoFocal_L(1);
f_L(2)= paramStereo.comprimentoFocal_L(2);
f_R(1)= paramStereo.comprimentoFocal_R(1);
f_R(2)= paramStereo.comprimentoFocal_R(2);

% Monta a matriz Intrinseca da câmera esquerda com valores em mm:
M_Intrinc_L= [f_L(1)*pixelSize       0             u0_L*pixelSize    0;
                    0          f_L(2)*pixelSize    v0_L*pixelSize    0;
                    0                0                     1         0];

% % Monta a matriz Intrinseca da câmera direita:
M_Intrinc_R= [f_R(1)*pixelSize       0             u0_R*pixelSize    0;
                    0          f_R(2)*pixelSize    v0_R*pixelSize    0;
                    0                0                     1         0];

% Calcula a matriz inversa da câmera esquerda com relação ao mundo:
% matrizT_World_inv= inv(matrizT_World);

% Matriz estéreo neutra para testes:
%  matrizT_Stereo= [eye(4,3) [-500 0 0 1]'];

% Atenbção, como os pontos 3D carregados de arquivo já estão com a 
% corrigida, não pe necessário repassar as distorção para a tringulação:
distorcaoLente_L= [0 0 0 0 0]';
distorcaoLente_R= [0 0 0 0 0]';

if ~carregaPontosFromFile   
    % Para cada ponto de entrada é encontrado a sua projeção nos planos imagens
    % equerdo e direito. Apenas depois de conhecidas as coordenadas dos planos
    % imagens, elas sevirão para gerar a simulação para cada um desses pontos:
    numDistancias= size(pontos3D,1);
    for ctDist=1:numDistancias
        % Gera uma coordenada homogênea para o ponto P no espaço 3D. As coordenadas já estão em mm:    
         P_HC_left_3D=[pontos3D(ctDist,:) 1]';

        
        % Transformar o ponto P com relação ao sistema de coordenadas da câmera esquerda 
        % (Verificar a página 323 do livro do Peter Corke). A Matriz de projeção M da câmera 
        % esquerda é calculada por:
        P_HC_right_3D= matrizT_Stereo*P_HC_left_3D;
        
%         M= M_Intrinc_L*inv(matrizT_Stereo);

        % As coordenadas homogêneas do ponto mapeado no sistema de referência da cãmera esquerda é
        % determinado usando a matriz M e o ponto P com relaçãop a câmera direita:
        p_left_2D_H= M_Intrinc_L*P_HC_left_3D;
        xL= p_left_2D_H(1);
        yL= p_left_2D_H(2);
        wL= p_left_2D_H(3);

        % Converte de homogêneo para cartesiano e em pixel com relação ao sensor de imagem da câmera esquerda:
        uL(ctDist)= ((xL/wL)/pixelSize);
        vL(ctDist)= ((yL/wL)/pixelSize); 

        % As coordenadas homogêneas do ponto mapeado no sistema de referência da cãmera direita é:
        p_right_2D_H= M_Intrinc_R*P_HC_right_3D; 
        xR= p_right_2D_H(1);
        yR= p_right_2D_H(2);
        wR= p_right_2D_H(3);

        % Converte de homogêneo para cartesiano e em pixel com relação ao sensor de imagem da câmera direita:
        uR(ctDist)= ((xR/wR)/pixelSize);
        vR(ctDist)= ((yR/wR)/pixelSize);
    end
    p_left_2D= [uL; vL];
    p_right_2D= [uR; vR]; 
    distanciaNominal= pontos3D(:,3);
else
    % Neste caso utiliza os pontos 3D carregados de um arquivo referentes à uma nuvem de pontos previamente gerada.
    % Define o número de pontos para simulação:
    [numPontos numCoords]= size(pontos3D);    

    % Para cada ponto 3D será encontrada su arespectiva coordenada, em pixel, no plano imagem: 
    for ctPonto=1:numPontos       
        % Carrehga os pontos 3D numa variável auxilia. Gera uma coordenada homogênea para o ponto P no espaço 3D.
        % Lembra que a biblioteca Yves Bouguet gera a transformação da cãmera direita com relação a esquerda,
        % ous eja, a câmera esquerda é a referência:    
        P_HC_left_3D=[pontos3D(ctPonto,:) 1]';

        % Transformar o ponto P com relação ao sistema de coordenadas da câmera esquerda 
        % (Verificar a página 323 do livro do Peter Corke). Aqui a
        % tranformação é direta conforma explicitado na documentação da
        % bilbioteca Yves Bouguet, ver:
        % http://robots.stanford.edu/cs223b04/JeanYvesCalib/htmls/example5.html.
        P_HC_right_3D= matrizT_Stereo*P_HC_left_3D;
        
        % As coordenadas homogêneas do ponto 2D da câmera esquerda é
        % determinado usando a matriz "M_Intrinc_L" e o ponto P com relação à câmera esquerda:
        p_left_2D_H= M_Intrinc_L*P_HC_left_3D;
        xL= p_left_2D_H(1);
        yL= p_left_2D_H(2);
        wL= p_left_2D_H(3);

        % Converte o ponto 2D de homogêneo para cartesiano e em pixel:
        uL(ctPonto)= ((xL/wL)/pixelSize);
        vL(ctPonto)= ((yL/wL)/pixelSize); 

        % O mesmo procedimento é feito para a câmera direita:
        p_right_2D_H= M_Intrinc_R*P_HC_right_3D; 
        xR= p_right_2D_H(1);
        yR= p_right_2D_H(2);
        wR= p_right_2D_H(3);

        % Converte o ponto 2D de homogêneo para cartesiano e em pixel:
        uR(ctPonto)= ((xR/wR)/pixelSize);
        vR(ctPonto)= ((yR/wR)/pixelSize);
    end 
    p_left_2D= [uL; vL];
    p_right_2D= [uR; vR]; 
    distanciaNominal= pontos3D(:,3);    
end

 

if HabShowPontosPlanoImagem
    close all;
    fig= figure;
    fig.Position= [1117 300 1391 900];  

    % Plota o ponto na tela como se fosse o plano imagem do sensor, a origem do plano
    % coordenado u e v está no canto superior esquerdo:
    subplot(1,2,1);
    plot(p_left_2D(1,:), p_left_2D(2,:), '.r', 'MarkerSize', 15);
    msgTexto=sprintf('Plano Imagem Esquerdo.');
    title(msgTexto);
    xlabel('X - Pixels');
    ylabel('Y - Pixels');
    xlim([0 2047]);
    ylim([0 2047]);
%     xlim([-1024 1024]);
%     ylim([-1024 1024]);
    grid on;
    % axis equal;

    h1= gca;
    % Inverte o eixo vertical, para colocar a origem do sensor no canto superior esquerdo:
    set(h1,'YDir','reverse');


    % Plota o ponto na tela como se fosse o plano imagem dos ensor, a origem do plano
    % coordenado u e v está no canto superior esquerdo:
    subplot(1,2,2);
    plot(p_right_2D(1,:), p_right_2D(2,:), '.b', 'MarkerSize', 15);
    msgTexto=sprintf('Plano Imagem Direito.');
    title(msgTexto);
    xlabel('X - Pixels');
    ylabel('Y - Pixels');
    xlim([0 2047]);
    ylim([0 2047]);
%      xlim([-1024 1024]);
%      ylim([-1024 1024]);
    grid on;
    % axis equal;
    h2= gca;
    % Inverte o eixo vertical, para colocar a origem do sensor no canto superior esquerdo:
    set(h2,'YDir','reverse');
end

end