function handles= fReinicializaVariaveis(handles)

% Uma forma segura de reinicialiar as variáveis é eliminar o seu campo 
% da variável global handles. Conforme abaixo:

if isfield(handles, 'pontos3D_sim')
     handles= rmfield(handles, 'pontos3D_sim');
     handles.pontos3D_sim= str2num(handles.editCoordenadasXYZ.String);
end

if isfield(handles, 'pontos3D')
     handles= rmfield(handles, 'pontos3D');
end


if isfield(handles, 'ptoPlanoImagem_left')
     handles= rmfield(handles, 'ptoPlanoImagem_left');
end

if isfield(handles, 'ptoPlanoImagem_right')
     handles= rmfield(handles, 'ptoPlanoImagem_right');
end

if isfield(handles, 'distanciaNominal')
     handles= rmfield(handles, 'distanciaNominal');
end

handles.pbAnalisaIncertezas.Enable= 'off'; 


end