function pontos3D= fCarregPontos3D(handles)
clc;

% Define o path para a leitura do arquivo:
path= fullfile(handles.pathBase,'*.txt');
[file path]= uigetfile(path);

if ~file
    msgbox('Leitura do arquivo de dados cancelada!', ' ', 'warn', 'modal');
    pontos3D= [0 0 0];
    return;
end

nameFile= fullfile(path,file);

% Define o formato dos dados do arquivo de entrada:
formatSpec = '%f %f %f';
% Define a tabulação dos dados de saída: 
sizePontos3D = [3 inf];
% Abre o arfquivo
fid= fopen(nameFile,'r');
% Carrega os dados, faz um scan, no arquivo de saída:
[pontos3D, cout]= fscanf(fid, formatSpec, sizePontos3D);
% Fecha o arquivo:
fclose(fid);
% Coloca os dados na saída:
pontos3D= pontos3D';
end