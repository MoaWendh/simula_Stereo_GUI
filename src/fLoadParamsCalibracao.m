function [paramCalib loadParamCalibOk]= fLoadParamsCalibracao(pathCalibrationFile)

pathFile= fullfile(pathCalibrationFile,'*.mat');
[fileName, path]= uigetfile(pathFile);

if ~fileName
    msgbox('Cancelada abertura do arquivo de calibração', '', 'warn', 'modal');
    paramCalib= 0;
    loadParamCalibOk= 0;
    return;
end

pathFile= fullfile(path, fileName);
load(pathFile);

paramCalib.rotStereo= om;
paramCalib.transStereo= T;

paramCalib.sensorOrigin_L= cc_left;
paramCalib.sensorOrigin_R= cc_right;

paramCalib.comprimentoFocal_L= fc_left;
paramCalib.comprimentoFocal_R= fc_right;

paramCalib.skew_L= alpha_c_left;
paramCalib.skew_R= alpha_c_right;

paramCalib.Distortion_L= kc_left;
paramCalib.radialDistortion_L= kc_left(1:2,1);
paramCalib.tangencialDistortion_L= kc_left(3:4,1);

paramCalib.Distortion_R= kc_right;
paramCalib.radialDistortion_R= kc_right(1:2,1);
paramCalib.tangencialDistortion_R= kc_right(3:4,1);

paramCalib.incerteza_ComprimentoFocal_L= fc_left_error;
paramCalib.incerteza_ComprimentoFocal_R= fc_right_error;

paramCalib.incerteza_RotStereo= om_error;
paramCalib.incerteza_Translacao= T_error;

loadParamCalibOk= 1;
end