function [X_L_sim X_R_sim]= fSimulaIncertezaStereo(ptoPlanoImagem_left, ptoPlanoImagem_right, ...
                                           pontos3D, paramStereo, incerteza, ... 
                                           carregaCalibracaoFromFile, numSimulacoes, ...
                                           HabShowPontos3D)
clc;

% **************************** Carrega os parâmetros estéreo:
% Carrega o comprimento focal já em mm: 
f_L= paramStereo.comprimentoFocal_L;
f_R= paramStereo.comprimentoFocal_R;

% Extraindo os parâmetros par varáveis locais: 
pixelSize= paramStereo.pixelSize;

% Tamanho do sensor em mm:
sensorSize= paramStereo.sensorSize(1);

% Origem do sensor:
u0_L= (paramStereo.sensorOrigin_L(1));
v0_L= (paramStereo.sensorOrigin_L(2));

u0_R= (paramStereo.sensorOrigin_R(1));
v0_R= (paramStereo.sensorOrigin_R(2));

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

[dims numPontos]= size(ptoPlanoImagem_left);

for ctPonto=1:numPontos
    ponto_L= ptoPlanoImagem_left(:,ctPonto);
    ponto_R= ptoPlanoImagem_right(:,ctPonto);
    
    % Executa "numSimulacoes" conforme definido na interface GUI:
    for ctSim= 1:numSimulacoes
        % ******************* Definição das incertezas:
        % Incerteza do comprimento focal:                                              
        uf= incerteza.ComprimentoFocal_L(1)/3;

        % Incerteza da disparidade:
        ud= incerteza.Disparidade;

        % Incerteza na localização da coordenada x no plano imagem:
        ux= incerteza.X;

        % Incerteza na localização da coordenada y no plano imagem:
        uy= incerteza.Y;

        % Incerteza no baseline, esta incerteza utliza a mesma incerteza decorrente da tranlação.
        % Isto porque o cálculo do baseline é pfeito pela translação da cam. R com relação a cam. L:
        ut= incerteza.TranslacaoStereo/3;

        % Incerteza no vetor de rotação:
        uR= incerteza.RotacaoStereo/3;

        rng shuffle;

        %******************* Insere os erros em função da incerteza:
        % Inserindo erro no comprimento focal através de uma variação aleatória com diustribuição normal:
        f_L(1)= f_L(1) + uf*randn();
        f_L(2)= f_L(2) + uf*randn();
        f_R(1)= f_R(1) + uf*randn();
        f_R(2)= f_R(2) + uf*randn();

        % Inserindo erro nas coordenadas da origem do sensor:
        u0_L= u0_L + ux*randn();
        v0_L= v0_L + uy*randn();
        u0_R= u0_R + ux*randn();
        v0_R= v0_R + uy*randn();

        % Inserindo erro no vetor translação: 
        t= t + ut.*randn(3,1);

        % Inserindo erro no vetor de rotação:
%         vetorR= vetorR + uR.*randn(3,1);

        % Insere a incerteza em cada pontos do plano imagem esquerdo e direito:
        [nPontos ncoords]= size(pontos3D);
        ponto_L(1,:)= ponto_L(1,:) + ux*randn(1, nPontos);
        ponto_L(2,:)= ponto_L(2,:) + uy*randn(1, nPontos);

        ponto_R(1,:)= ponto_R(1,:) + ux*randn(1, nPontos);
        ponto_R(2,:)= ponto_R(2,:) + uy*randn(1, nPontos);

        % Nã há necessiade de inserir a distorção das lentes, uma vez que os
        % dados usados pata gerar o 3D já estavam com a distorção corrigida:
        distorcaoLente_L= [0 0 0 0 0]';
        distorcaoLente_R= [0 0 0 0 0]';

        % Chama a função "stereo_triangulation" Bouguet para determinar a projeção dos pontos 3D referentes a imagem esquerda e direita, 
        [X_L_aux, X_R_aux] = fStereoTriangulation(ponto_L, ...
                                                  ponto_R, ...
                                                  vetorR, t, ... 
                                                  f_L', [u0_L; v0_L],  distorcaoLente_L, skell_L, ...
                                                  f_R', [u0_R; v0_R],  distorcaoLente_R, skell_R);
        X_L_sim(ctPonto,ctSim,:)= X_L_aux';
        X_R_sim(ctPonto,ctSim,:)= X_R_aux';    
    end
end
close all;

if HabShowPontos3D
    close all;
    plot3(pontos3D(:,1), pontos3D(:,2), pontos3D(:,3), 'or', 'MarkerSize', 6, 'LineWidth', 2);
    hold on;
    xlabel('X (mm)');
    ylabel('Y (mm)');
    zlabel('Z (mm)');
    grid on; 
    axis equal;
    plot3(X_R_sim(:,:,1), X_R_sim(:,:,2), X_R_sim(:,:,3), '.b');                 
end


end