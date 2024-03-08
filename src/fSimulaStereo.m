
function [pc ctPC]= fSimulaStereo(handles)

clc;

% Extraindo os parâmetros par varáveis locais: 
pixelSize= handles.pixelSize;

% Tamanho do sensor em pixels:
sensorSize= handles.sensorSize(1)*pixelSize;

% Origem do sistema de coordenadas do plano sensor:
u0_L= handles.sensorOrigin_L(1)*handles.pixelSize;
yo_L= handles.sensorOrigin_L(2)*handles.pixelSize;
u0_R= handles.sensorOrigin_R(1)*handles.pixelSize;
yo_R= handles.sensorOrigin_R(2)*handles.pixelSize;


% COmprimento focal em pixels para mm:
f_L= handles.comprimentoFocal_L(1)*handles.pixelSize;
f_R= handles.comprimentoFocal_R(1)*handles.pixelSize;

% Chama a função que gera a matriz de transformação homogênea da câmera esquerda com relação ao ao sist. de coordenadas do mundo:
matrizT_World= fGeraMatrizTransformacao_LeftCamWorld(handles);

% Chama a função que gera a matriz de transformação Stereo, ou seja a transformação da câmera direita com relação à cÂmera esquerda:
matrizT_Stereo= fGeraMatrizTransformacao_Stereo(handles);

% Coordenadas dos pontos 3D no espaço:
if handles.carregaPontosFromFile
    P3D= handles.pontos3D;
else
    P3D= handles.xyz;
end

% Gera as coordenadas do ponto 3D no plano imagem, ainda em mm, para a scam. esquerda e direita:
[p_left p_right]= fGeraCoordenadasPlanoImagem_mm(f_L, f_R, matrizT_World, matrizT_Stereo, P3D, ...
                                                 handles.sensorSize, handles.pixelSize, ... 
                                                 handles.sensorOrigin_L, handles.sensorOrigin_R);

Este software não está finalizado!!!!
                                             
% Define o ângulo de varredura azimutal em função da distância Y do LiDAR ao objeto e a largura X do objeto: 
distanciaY= handles.distanciaLidarObjeto;
larguraX= handles.larguraObjeto; 

% Define o Ângulo de varredura vertical em função da distância Y do LiDAR ao objeto e da altura Z do objeto:
alturaZ= handles.alturaObjeto;

if (larguraX==0)
    msgbox('Largura X do objeto não pode ser zero!!', 'Erro', 'error', 'modal');
    pc= 0;
    ctPC= handles.ctPC;
    return;
elseif (distanciaY==0)
    msgbox('Distânica Y do objeto não pode ser zero!!', 'Erro', 'error', 'modal');
    pc= 0;
    ctPC= handles.ctPC;
    return;
elseif (alturaZ==0)    
    msgbox('Altura Z do objeto não pde ser zero!!', 'Erro', 'error', 'modal');
    pc= 0;
    ctPC= handles.ctPC;
    return;    
end

% Resolução do azimute:
resAzim= handles.resolucaoAzimute; % graus;

% resolução elevação:
resElevacao= 2; % graus;

% Define o ângulo de elevação calculado a partir da distância Y e altura Z: 
elevacaoGraus= (atand((alturaZ/2)/distanciaY))*2;

% Define os ângulos, canais, de elevação:
switch true
    case elevacaoGraus>=30
        elevacaoGraus= handles.canal.elevacao;
    case elevacaoGraus<30 && elevacaoGraus>=26
        elevacaoGraus= handles.canal.elevacao(2:15);
    case elevacaoGraus<26 && elevacaoGraus>=22
        elevacaoGraus= handles.canal.elevacao(3:14);
    case elevacaoGraus<22 && elevacaoGraus>=18
        elevacaoGraus= handles.canal.elevacao(4:13);
    case elevacaoGraus<18 && elevacaoGraus>=14
        elevacaoGraus= handles.canal.elevacao(5:12);
    case elevacaoGraus<14 && elevacaoGraus>=10
        elevacaoGraus= handles.canal.elevacao(6:11);
    case elevacaoGraus<10 && elevacaoGraus>=6
        elevacaoGraus= handles.canal.elevacao(7:10);
    case elevacaoGraus<6 && elevacaoGraus>=2
        elevacaoGraus= handles.canal.elevacao(8:9);
    case elevacaoGraus<2 && elevacaoGraus>0
        elevacaoGraus= handles.canal.elevacao(8);        
    otherwise
        if elevacaoGraus==0
            msgbox('Ângulo de elevação igual a zero!!', 'Erro', 'error', 'modal');
            pc= 0;
            ctPC= handles.ctPC;
            return;
        else
            msgbox('Erro na determinação do ângulo de elevação!!', 'Erro', 'error', 'modal');
            pc= 0;
            ctPC= handles.ctPC;
            return;
        end
end

% Converte a elevação para radianos:
elevacao= (elevacaoGraus/180)*pi; % Em radianos.

% Ângulo de varredura azimutal do LiDAR calculado a partir da distância Y e largura X: 
varredura= atand((larguraX/2)/distanciaY); 
azimGraus= -varredura:resAzim:varredura; % Em graus

% Posição, numeração física, e ângulo de elevação do LiDAR:
% canalID= handles.canal.ID;
% elevacao= handles.canal.elevacao;
% elevacao= (elevacao/180)*pi;

% Correções a serem aplicadas:
correcaoVerticalMetros= handles.canal.correcaoVertical/1000;
correcaoHorizontalMetros= handles.canal.correcaoHorizontal/1000;
offsetRangeMetros= handles.canal.offsetRange/1000;
fatorEscalaRangeMetros= handles.canal.fatorEscalaRange; % Fator de escala é adimensional.
correcaoAzimute= deg2rad(handles.canal.correcaoAzimute);

% Define o ruído na distânica, range:
ruidoRange= floor(handles.ruidoRange);

if ruidoRange==0
    msgbox('Ângulo de elevação igual a zero!!', 'Erro', 'error', 'modal');
    pc= 0;
    ctPC= handles.ctPC;
    return;
else

for(i=1:length(elevacao))
   % Insere o ruído no azimute:
   ruidoAzimute= (-1 + 2*rand(1,length(azimGraus)))*handles.ruidoAzimute;
   azimGraus= azimGraus + ruidoAzimute;
   
   % Converte o azimute para radianos:
   azim= (azimGraus/180)*pi;
    
   % Insere ruído no range:
   ruidoR= randi([-ruidoRange,ruidoRange],1,length(azim))/1000;
   
   % Calcula o range a partir de um Y fixo, simulando um plano:
   R(i,:)= distanciaY./(cos(azim)*cos(elevacao(i)))+(ruidoR);
   
   % Determina os pontos x, y e z a partir das coordenadas esféricas:
   x= (fatorEscalaRangeMetros(i)*R(i,:) - offsetRangeMetros(i)).*sin(azim)*cos(elevacao(i) - correcaoAzimute(i)) - correcaoHorizontalMetros(i)*sin(elevacao(i) - correcaoAzimute(i));
   y= (fatorEscalaRangeMetros(i)*R(i,:) - offsetRangeMetros(i)).*cos(azim)*cos(elevacao(i) - correcaoAzimute(i)) - correcaoHorizontalMetros(i)*cos(elevacao(i) - correcaoAzimute(i));
   z= (fatorEscalaRangeMetros(i)*R(i,:) - offsetRangeMetros(i)).*sin(elevacao(i)) + correcaoVerticalMetros(i);
    
   xyz(i,:,:)= [x; y; z]';
   
   ctPC= handles.ctPC + 1;
end

% Gera nuvem de pontos simulada:
pc= pointCloud(xyz);

msg= sprintf('PC simulada %d ok!', ctPC);
msgbox(msg, 'Ok', 'warn', 'modal');

end