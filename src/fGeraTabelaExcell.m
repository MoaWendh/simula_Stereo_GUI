function fGeraTabelaExcell(estatistica)

clc;

dp_x= estatistica.dp_L.x;
min_x= estatistica.min_L.x;
max_x= estatistica.max_L.x;

dp_z= estatistica.dp_L.z;
min_z= estatistica.min_L.z;
max_z= estatistica.max_L.z;

distancia= estatistica.distancia_L;

distanciaNominal= round(estatistica.distancia_L);

colName= {'Distância nominal (m)','Distância simulada (m)', 'DP X (mm)', 'Resíduo Min X (mm)', 'Resíduo Max X (mm)', 'DP Z (mm)', 'Resíduo Min Z (mm)', 'Resíduo Max Z (mm)'};
t= table(distanciaNominal', distancia', dp_x', min_x', max_x', dp_z', min_z', max_z');
t.Properties.VariableNames= colName;

% Arredonda os valores para duas casa decimais:
t.("Distância nominal (m)")= round(t.("Distância nominal (m)"), 2);
% t.("Distância simulada (m)")= round(t.("Distância simulada (m)"), 2);
t.("DP X (mm)")= round(t.("DP X (mm)"), 2);
t.("DP Z (mm)")= round(t.("DP Z (mm)"), 2);
t.("Resíduo Max X (mm)")= round(t.("Resíduo Max X (mm)"), 2);
t.("Resíduo Max Z (mm)")= round(t.("Resíduo Max Z (mm)"), 2);
t.("Resíduo Min X (mm)")= round(t.("Resíduo Min X (mm)"), 2);
t.("Resíduo Min Z (mm)")= round(t.("Resíduo Min Z (mm)"), 2);


% Salva tabela no formato Excell:
fileName= sprintf('tabelDadosExperimentais.xlsx');
fullFileName= fullfile('D:\Moacir\OneDrive\Particulares\Projetos\Matlab\programas_GUI\simula_Stereo_GUI\out', fileName);

% Verificar se o arquivo existe, se ele existir será deletado antes dos dados serem salvos:
if isfile(fullFileName)
    % Verifica se o arquivo está aberto antes de salvar:
    % Tentar abrir o arquivo para leitura
    [fileID, message] = fopen(fullFileName, 'r');
    if fileID == -1
        % Se fileID for -1, significa que ocorreu um erro ao tentar abrir o arquivo
        msg= sprintf('O arquivo está aberto por outro processo, feche antes de salvar!!');
        msgbox(msg, 'Warn', 'warn', 'modal');
        return;
    else
        fclose(fileID); % Fecha o arquivo
    end      
    
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