function [X_L_sim X_R_sim residuo_X_L residuo_X_R]= fSimulaPontos3DStereo(ptoPlanoImagem_left, ...
                                                                          ptoPlanoImagem_right, ...
                                                                          pontos3D, ...
                                                                          paramStereo, ...
                                                                          incerteza, ... 
                                                                          carregaCalibracaoFromFile, ...
                                                                          numSimulacoes, ...
                                                                          HabShowPontos3D, ...
                                                                          fatorK_int, ...
                                                                          fatorK_ext)
clc;

% Fatores K define os fatores de ambrangência para cada um dos parãmetros.
% Para facilitar a análise de qual incerteza é mais significativa.
% 0: elimina a incerteza;
% 1: incerteza normal;
% >1: Amplifica a incertez
% O fator K= 0.333 é decorrente do fator de abrangência da calibração Yves Bouguet, pois ele afirma
% que os erros são 3 sigmas.
% fatorK_ext_rot= 0.0;
% fatorK_ext_transl= 0.333;
% fatorK_int_focal= 0.333;
% fatorK_int_disp= 0.2;
% fatorK_int_xy= 0.2;

hab_erro_rotacao= 0;



% **************************** Carrega os parâmetros estéreo:
% Carrega o comprimento focal já em mm: 
f_L= [paramStereo.comprimentoFocal_L(1) paramStereo.comprimentoFocal_L(2)];
f_R= [paramStereo.comprimentoFocal_R(1) paramStereo.comprimentoFocal_R(2)];

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
        % Incerteza da disparidade:
        ud= incerteza.Disparidade*fatorK_int;

        % Incerteza na localização da coordenada x no plano imagem em pixels:
        ux= (incerteza.X/pixelSize)*fatorK_int;

        % Incerteza na localização da coordenada y no plano imagem em pixels:
        uy= (incerteza.Y/pixelSize)*fatorK_int;

        % Incerteza do comprimento focal em pixels:                                              
        uf_L(1)= (incerteza.ComprimentoFocal_L(1))*fatorK_int;
        uf_L(2)= (incerteza.ComprimentoFocal_L(2))*fatorK_int;       
        uf_R(1)= (incerteza.ComprimentoFocal_R(1))*fatorK_int;
        uf_R(2)= (incerteza.ComprimentoFocal_R(2))*fatorK_int;   
        
        % Incerteza no baseline, esta incerteza utliza a mesma incerteza decorrente da tranlação.
        % Isto porque o cálculo do baseline é pfeito pela translação da cam. R com relação a cam. L.
        % Manter em milímetros, pois a calibração fornece a translação em mm:
        ut= (incerteza.TranslacaoStereo)*fatorK_ext;

        % Incerteza no vetor de rotação:
        uR= ((incerteza.RotacaoStereo)*fatorK_ext)*hab_erro_rotacao;

        %******************* Insere os erros em função da incerteza:
        % Inserindo erro no comprimento focal através de uma variação aleatória com diustribuição normal:
        f_L_sim(1)= f_L(1) + uf_L(1)*randn();
        f_L_sim(2)= f_L(2) + uf_L(2)*randn();
        f_R_sim(1)= f_R(1) + uf_R(1)*randn();
        f_R_sim(2)= f_R(2) + uf_R(2)*randn();
        
        f_L_1_aux(ctSim)= f_L_sim(1);
        f_L_2_aux(ctSim)= f_L_sim(2);
        f_R_1_aux(ctSim)= f_R_sim(1);
        f_R_2_aux(ctSim)= f_R_sim(2);
        

        % Inserindo erro nas coordenadas da origem do sensor:
        u0_L_sim= u0_L + ux*randn();
        v0_L_sim= v0_L + uy*randn();
        u0_R_sim= u0_R + ux*randn();
        v0_R_sim= v0_R + uy*randn();

        % Inserindo erro no vetor translação: 
        t_sim= t + ut.*randn(3,1);

        % Inserindo erro no vetor de rotação:
        vetorR_sim= vetorR + uR.*randn(3,1);

        % Insere a incerteza em cada pontos do plano imagem esquerdo e direito, o valor do ponto está em pixels,
        % desta forma a incertez também deverá estar em pixels:
        [nPontos ncoords]= size(pontos3D);
        ponto_L_sim(1,:)= round(ponto_L(1,:) + ux*randn());
        ponto_L_sim(2,:)= round(ponto_L(2,:) + uy*randn());

        ponto_R_sim(1,:)= round(ponto_R(1,:) + ux*randn());
        ponto_R_sim(2,:)= round(ponto_R(2,:) + uy*randn());

        % Nã há necessiade de inserir a distorção das lentes, uma vez que os
        % dados usados pata gerar o 3D já estavam com a distorção corrigida:
        distorcaoLente_L_sim= [0 0 0 0 0]'; 
        %distorcaoLente_L_sim= distorcao_L;
        distorcaoLente_R_sim= [0 0 0 0 0]';
        %distorcaoLente_R_sim= distorcao_R;
        
        skell_L_sim= skell_L;
        skell_R_sim= skell_R;

        % Chama a função "stereo_triangulation" Bouguet para determinar a projeção dos pontos 3D referentes a imagem esquerda e direita,
        
        habilitaErro_sim= 1; % Parâmetro "habilitaErro_sim" é apenas para testes!!!

        if habilitaErro_sim
            [X_L_aux, X_R_aux] = fStereoTriangulation(ponto_L_sim, ...
                                                      ponto_R_sim, ...
                                                      vetorR_sim, t_sim, ... 
                                                      f_L_sim', [u0_L_sim; v0_L_sim],  distorcaoLente_L_sim, skell_L_sim, ...
                                                      f_R_sim', [u0_R_sim; v0_R_sim],  distorcaoLente_R_sim, skell_R_sim);
        else
            [X_L_aux, X_R_aux] = fStereoTriangulation(ponto_L, ...
                                                      ponto_R, ...
                                                      vetorR, t, ... 
                                                      f_L', [u0_L; v0_L],  distorcaoLente_L_sim, skell_L_sim, ...
                                                      f_R', [u0_R; v0_R],  distorcaoLente_R_sim, skell_R_sim);                                              
        end
        
        % Guarda o valor simulado na variável de saída:
        X_L_sim(ctPonto, ctSim, :)= X_L_aux';
        X_R_sim(ctPonto, ctSim, :)= X_R_aux';
        
        % Sendo que os pontos 3D de entrada representam uma curva ajustada, então a diferença entre esses
        % pontos e o simulado deve ser chamado de resíduo:
        residuo_X_L(ctPonto, ctSim, :)= X_L_aux' - pontos3D(ctPonto,:);
        residuo_X_R(ctPonto, ctSim, :)= X_R_aux' - pontos3D(ctPonto,:);

        ax(ctPonto)= mean(X_L_sim(ctPonto,:,1));
        bx(ctPonto)= std(X_L_sim(ctPonto,:,1));

        ay(ctPonto)= mean(X_L_sim(ctPonto,:,2));
        by(ctPonto)= std(X_L_sim(ctPonto,:,2));

        az(ctPonto)= mean(X_L_sim(ctPonto,:,3));
        bz(ctPonto)= std(X_L_sim(ctPonto,:,3));
    end
end


if HabShowPontos3D
    close all;
    plot3(pontos3D(:,1), pontos3D(:,2), pontos3D(:,3), 'or', 'MarkerSize', 6, 'LineWidth', 2);
    hold on;
    xlabel('X (mm)');
    ylabel('Y (mm)');
    zlabel('Z (mm)');
    grid on; 
    plot3(X_L_sim(:,:,1), X_L_sim(:,:,2), X_L_sim(:,:,3), '.b');  
    axis equal;
end

end