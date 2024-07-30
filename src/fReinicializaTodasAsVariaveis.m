function handles= fReinicializaTodasAsVariaveis(handles)

% Uma forma segura de reinicialiar as variáveis é eliminar o seu campo 
% da variável global handles. Conforme abaixo:
if isfield(handles, 'cicloFinalizado')
    handles.cicloFinalizado= 0;
end

if isfield(handles, 'filePC_Ok')
    handles.filePC_Ok= 0;
end

if isfield(handles, 'fileImageL')
    handles= rmfield(handles, 'fileImageL');
end

if isfield(handles, 'pathFileImageL')
    handles= rmfield(handles, 'pathFileImageL');
end

if isfield(handles, 'imageL')
    handles= rmfield(handles, 'imageL');
end

if isfield(handles, 'fileImageL_Ok')
    handles.fileImageL_Ok= 0;
end

if isfield(handles, 'fileImageR')
    handles= rmfield(handles, 'fileImageR');
end

if isfield(handles, 'pathFileImageR')
    handles= rmfield(handles, 'pathFileImageR');
end

if isfield(handles, 'imageR')
    handles= rmfield(handles, 'imageR');
end

if isfield(handles, 'fileImageR_Ok')
    handles.fileImageR_Ok= 0;
end

if isfield(handles, 'laserLineL')
    handles= rmfield(handles, 'laserLineL');
end

if isfield(handles, 'laserLineR')
    handles= rmfield(handles, 'laserLineR');
end


if isfield(handles, 'laserLineSegmentada_L')
    handles= rmfield(handles, 'laserLineSegmentada_L');
end

if isfield(handles, 'laserLineSegmentada_R')
    handles= rmfield(handles, 'laserLineSegmentada_R');
end


if isfield(handles, 'PtsSegmentadosNaoNulos_L')
    handles= rmfield(handles, 'PtsSegmentadosNaoNulos_L');
end

if isfield(handles, 'PtsSegmentadosNaoNulos_R')
    handles= rmfield(handles, 'PtsSegmentadosNaoNulos_R');
end

if isfield(handles, 'linhasEps')
    handles= rmfield(handles, 'linhasEps');
end

if isfield(handles, 'linhasEpsDiscr')
    handles= rmfield(handles, 'linhasEpsDiscr');
end

if isfield(handles, 'ptsHomologosL')
    handles= rmfield(handles, 'ptsHomologosL');
end

if isfield(handles, 'ptsHomologosR')
    handles= rmfield(handles, 'ptsHomologosR');
end

if isfield(handles, 'ptsStereo3D_L')
    handles= rmfield(handles, 'ptsStereo3D_L');
end

if isfield(handles, 'ptsStereo3D_R')
    handles= rmfield(handles, 'ptsStereo3D_R');
end

if isfield(handles, 'PC_Stereo')
    handles= rmfield(handles, 'PC_Stereo');
end

if isfield(handles, 'PtsCorrespondentes3D')
    handles= rmfield(handles, 'PtsCorrespondentes3D');
end


%************** Desabilita os principais botões *************************** 
handles.pbProcessaLinhaLaser.Enable= 'off';

handles.pbShowLaserLines.Enable= 'off';

handles.pbSaveLinesToFileTxt.Enable= 'off';


% Obriga a segmentar novamente os canais:
handles.pbSegmentaLinhaLaser.Enable= 'off';

handles.pbSavePontosStereoSegmentados.Enable= 'off';


handles.pbDetectaPontosHomologos.Enable= 'off';

% Força efetuar nova triangulação:                                                     
handles.pbEfetuaTriangulacao.Enable= 'off';

handles.pbDetectaPtsCorrespondentes3D.Enable= 'off';

handles.pbExibePtosCorrespondentes3D.Enable= 'off';

handles.pbSavePcs.Enable= 'off';

handles.pbSalvaPontosAjustados.Enable= 'off';

end