function fGeraTabelaExcell(estatistica)

clc;

dp_x= estatistica.dp_L.x;
min_x= estatistica.min_L.x;
max_x= estatistica.max_L.x;

dp_z= estatistica.dp_L.z;
min_z= estatistica.max_L.z;
max_z= estatistica.min_L.z;

distancia= estatistica.distancia_L;

colName= {'Distância (m)', 'DP X (mm)', 'DP Z (mm)', 'Resíduo Min X (mm)', 'Resíduo Min Z (mm)', 'Resíduo Max X (mm)', 'Resíduo Max Z (mm)'};
t= table(distancia', dp_x', dp_z', min_x', min_z', max_x', max_z');
t.Properties.VariableNames= colName;

% Arredonda os valores para duas casa decimais:
t.("Distância (m)")= round(t.("Distância (m)"), 1);
t.("DP X (mm)")= round(t.("DP X (mm)"), 1);
t.("DP Z (mm)")= round(t.("DP Z (mm)"), 1);
t.("Resíduo Max X (mm)")= round(t.("Resíduo Max X (mm)"), 1);
t.("Resíduo Max Z (mm)")= round(t.("Resíduo Max Z (mm)"), 1);
t.("Resíduo Min X (mm)")= round(t.("Resíduo Min X (mm)"), 1);
t.("Resíduo Min Z (mm)")= round(t.("Resíduo Min Z (mm)"), 1);


% Salva tabela no formato Excell:
fileName= sprintf('tabelDadosExperimentais.xlsx');
fullFileName= fullfile('D:\Moacir\OneDrive\Particulares\Projetos\Matlab\programas_GUI\simula_Stereo_GUI\out', fileName);

% Verificar se o arquivo existe, se ele existir será deletado antes dos dados serem salvos:
if isfile(fullFileName)   
    msg= sprintf('O arquivo "%s" já existe. Deseja deletar?', fileName);    
    answer = questdlg(msg, 'Deletar arquivo existente?', 'Sim','Não','Sim');
    % Handle response
    switch answer
        case 'Sim'
            % Deletar o arquivo
            delete(fullFileName);
            % Salva a tabela:
            writetable(t, fullFileName);
        case 'Não'
            msgbox('O arquivo .xlsx não foi salvo', 'Warn', 'warn')
            return;
    end
else
    % Salva a tabela:
    writetable(t, fullFileName);
end

end