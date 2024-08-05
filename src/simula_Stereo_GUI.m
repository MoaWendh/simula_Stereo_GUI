function varargout = simula_Stereo_GUI(varargin)
% SIMULA_STEREO_GUI MATLAB code for simula_Stereo_GUI.fig
%      SIMULA_STEREO_GUI, by itself, creates a new SIMULA_STEREO_GUI or raises the existing
%      singleton*.
%
%      H = SIMULA_STEREO_GUI returns the handle to a new SIMULA_STEREO_GUI or the handle to
%      the existing singleton*.
%
%      SIMULA_STEREO_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SIMULA_STEREO_GUI.M with the given input arguments.
%
%      SIMULA_STEREO_GUI('Property','Value',...) creates a new SIMULA_STEREO_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before simula_Stereo_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to simula_Stereo_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help simula_Stereo_GUI

% Last Modified by GUIDE v2.5 03-Aug-2024 20:07:29

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @simula_Stereo_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @simula_Stereo_GUI_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before simula_Stereo_GUI is made visible.
function simula_Stereo_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to simula_Stereo_GUI (see VARARGIN)

%*************** Dados usuário abaixo **************************************
% Definição de alguns nomes de folder para sereme gerados:
%handles.pathBase= 'C:\Projetos\Matlab\programas_GUI\simula_Stereo_GUI\src\in';
handles.pathBase= 'D:\Moacir\OneDrive\Particulares\Projetos\Matlab\programas_GUI\simula_Stereo_GUI\in'
handles.pathCalibrationFile= 'D:\Moacir\ensaios\dados_vigentes\Calibracao\Estereo\26_08_2023_A\bouguet';

handles.ArquivoCalibracaoOk= 0;

% Choose default command line output for simula_Stereo_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);


% UIWAIT makes simula_Stereo_GUI wait for user response (see UIRESUME)
% uiwait(handles.botton);


% --- Outputs from this function are returned to the command line.
function varargout = simula_Stereo_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



% --- Executes during object creation, after setting all properties.
function editIncertezaX_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editIncertezaX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

handles.incerteza.X= str2double(hObject.String);

% Update handles structure
guidata(hObject, handles);



function editDistanciaObjetoZ_Callback(hObject, eventdata, handles)




% --- Executes on button press in pbSair.
function pbSair_Callback(hObject, eventdata, handles)
% hObject    handle to pbSair (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Calback que chama fechamento do programa:
handles.botton.HandleVisibility= 'on';
clc;
close all;
clear;


% --- Executes on button press in pbSimulaPontos3D.
function pbSimulaPontos3D_Callback(hObject, eventdata, handles)
% hObject    handle to pbSimulaPontos3D (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 
% if handles.carregaPontosFromFile
%     handles.pontos3D= handles.pontos3D_real;
% else
%     handles.pontos3D= handles.pontos3D_sim;
% end


[handles.X_L_sim handles.X_R_sim handles.residuo_X_L handles.residuo_X_R]= fSimulaPontos3DStereo(handles.ptoPlanoImagem_left, ...
                                                                                                 handles.ptoPlanoImagem_right, ...
                                                                                                 handles.pontos3D, ...
                                                                                                 handles.paramStereo, ...
                                                                                                 handles.incerteza, ...
                                                                                                 handles.carregaCalibracaoFromFile, ...
                                                                                                 handles.numSimulacoes, ...
                                                                                                 handles.HabShowPontos3D, ...
                                                                                                 handles.fatorK_Intrinseco,...
                                                                                                 handles.fatorK_Extrinseco);
                                                     
                                                     
handles.pbAnalisaIncertezas.Enable= 'on';                                               
handles.pbSalvaTabelaExcell.Enable= 'off';

% Update handles structure
guidata(hObject, handles);




function editPixelSize_Callback(hObject, eventdata, handles)
% hObject    handle to editPixelSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editPixelSize as text
%        str2double(get(hObject,'String')) returns contents of editPixelSize as a double

handles.paramStereo.pixelSize= str2double(hObject.String);

% Update handles structure
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function editPixelSize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editPixelSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

handles.paramStereo.pixelSize= str2double(hObject.String);

% Update handles structure
guidata(hObject, handles);


function editIncertezaY_Callback(hObject, eventdata, handles)
% hObject    handle to editIncertezaY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editIncertezaY as text
%        str2double(get(hObject,'String')) returns contents of editIncertezaY as a double


% Reinicializa algumas variáveis:
handles= fReinicializaVariaveis(handles);

handles.incerteza.Y= str2double(hObject.String);

handles.editIncertezaDisparidade.String= num2str(sqrt(handles.incerteza.X^2 + handles.incerteza.Y^2));

% Update handles structure
guidata(hObject, handles);



% --- Executes during object creation, after setting all properties.
function editIncertezaY_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editIncertezaY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

handles.incerteza.Y= str2double(hObject.String);

% Update handles structure
guidata(hObject, handles);



function editIncertezaX_Callback(hObject, eventdata, handles)
% hObject    handle to editIncertezaX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editIncertezaX as text
%        str2double(get(hObject,'String')) returns contents of editIncertezaX as a double


% Reinicializa algumas variáveis:
handles= fReinicializaVariaveis(handles);

handles.incerteza.X= str2double(hObject.String);

handles.editIncertezaDisparidade.String= num2str(sqrt(handles.incerteza.X^2 + handles.incerteza.Y^2));

% Update handles structure
guidata(hObject, handles);


function editIncertezaDisparidade_Callback(hObject, eventdata, handles)
% hObject    handle to editIncertezaDisparidade (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editIncertezaDisparidade as text
%        str2double(get(hObject,'String')) returns contents of editIncertezaDisparidade as a double

handles.incerteza.Disparidade= str2double(hObject.String);

% Update handles structure
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function editIncertezaDisparidade_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editIncertezaDisparidade (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

handles.incerteza.Disparidade= str2double(hObject.String);

% Update handles structure
guidata(hObject, handles);




function editBaseLine_Callback(hObject, eventdata, handles)
% hObject    handle to editBaseLine (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editBaseLine as text
%        str2double(get(hObject,'String')) returns contents of editBaseLine as a double


handles.paramStereo.baseLine= str2double(hObject.String);

% Update handles structure
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function editBaseLine_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editBaseLine (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

handles.paramStereo.baseLine= str2double(hObject.String);

% Update handles structure
guidata(hObject, handles);


function editComprimentoFocal_L_Callback(hObject, eventdata, handles)
% hObject    handle to editComprimentoFocal_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editComprimentoFocal_L as text
%        str2double(get(hObject,'String')) returns contents of editComprimentoFocal_L as a double

% Carrega o coprimento focal convertido em mm:
handles.paramStereo.comprimentoFocal_L= [str2double(hObject.String) str2double(hObject.String)];

% Update handles structure
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function editComprimentoFocal_L_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editComprimentoFocal_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% Carrega o coprimento focal convertido em mm:
handles.paramStereo.comprimentoFocal_L= [str2double(hObject.String) str2double(hObject.String)];

% Update handles structure
guidata(hObject, handles);


function editCoordenadasXYZ_Callback(hObject, eventdata, handles)
% hObject    handle to editCoordenadasXYZ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editCoordenadasXYZ as text
%        str2double(get(hObject,'String')) returns contents of editCoordenadasXYZ as a double


% Reinicializa algumas variáveis:
handles= fReinicializaVariaveis(handles);

handles.pontos3D_sim= str2num(hObject.String);

% Update handles structure
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function editCoordenadasXYZ_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editCoordenadasXYZ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

handles.pontos3D_sim= str2num(hObject.String);

% Update handles structure
guidata(hObject, handles);



function editIncertezaComprimentoFocal_L_Callback(hObject, eventdata, handles)
% hObject    handle to editIncertezaComprimentoFocal_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editIncertezaComprimentoFocal_L as text
%        str2double(get(hObject,'String')) returns contents of editIncertezaComprimentoFocal_L as a double

handles.incerteza.ComprimentoFocal_L= [str2double(hObject.String) str2double(hObject.String)]; 

% Update handles structure
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function editIncertezaComprimentoFocal_L_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editIncertezaComprimentoFocal_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

handles.incerteza.ComprimentoFocal_L= [str2double(hObject.String) str2double(hObject.String)];

% Update handles structure
guidata(hObject, handles);


function editIncertezaBaseline_X_Callback(hObject, eventdata, handles)
% hObject    handle to editIncertezaBaseline_X (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editIncertezaBaseline_X as text
%        str2double(get(hObject,'String')) returns contents of editIncertezaBaseline_X as a double

handles.incerteza.TranslacaoStereo= str2double(hObject.String); 

% Update handles structure
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function editIncertezaBaseline_X_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editIncertezaBaseline_X (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

handles.incerteza.TranslacaoStereo= str2double(hObject.String); 

% Update handles structure
guidata(hObject, handles);



function editRotacaoStereo_Callback(hObject, eventdata, handles)
% hObject    handle to editRotacaoStereo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editRotacaoStereo as text
%        str2double(get(hObject,'String')) returns contents of editRotacaoStereo as a double

handles.paramStereo.matrizR= str2num(hObject.String);

% Formata para exibir o resultado na saída:
formato='%15.4f'; 
str_A= num2str(handles.paramStereo.matrizR(1,:), formato);
str_B= num2str(handles.paramStereo.matrizR(2,:), formato);
str_C= num2str(handles.paramStereo.matrizR(3,:), formato );
msg= sprintf('  %s\n  %s\n  %s\n',str_A, str_B, str_C);
handles.outRotacaoStereo.String= str2mat(msg);

% Update handles structure
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function editRotacaoStereo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editRotacaoStereo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

handles.paramStereo.matrizR= str2num(hObject.String);


% Update handles structure
guidata(hObject, handles);



function editTranslacaoStereo_Callback(hObject, eventdata, handles)
% hObject    handle to editTranslacaoStereo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editTranslacaoStereo as text
%        str2double(get(hObject,'String')) returns contents of editTranslacaoStereo as a double

handles.paramStereo.vetorT= str2num(hObject.String);

% Formata para exibir o resultado na saída:
formato='%15.4f'; 
str= num2str(handles.paramStereo.vetorT, formato);
msg= sprintf('  %s',str);
handles.outTranslacaoStereo.String= str2mat(msg);

% Update handles structure
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function editTranslacaoStereo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editTranslacaoStereo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

handles.paramStereo.vetorT= str2num(hObject.String);

% Update handles structure
guidata(hObject, handles);



function editSensorSize_Callback(hObject, eventdata, handles)
% hObject    handle to editSensorSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editSensorSize as text
%        str2double(get(hObject,'String')) returns contents of editSensorSize as a double

handles.paramStereo.sensorSize= str2num(hObject.String);

% Update handles structure
guidata(hObject, handles);



% --- Executes during object creation, after setting all properties.
function editSensorSize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editSensorSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

handles.paramStereo.sensorSize= str2num(hObject.String);

% Update handles structure
guidata(hObject, handles);



function editOrigemSenror_L_Callback(hObject, eventdata, handles)
% hObject    handle to editOrigemSenror_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editOrigemSenror_L as text
%        str2double(get(hObject,'String')) returns contents of editOrigemSenror_L as a double

val= str2num(hObject.String);
handles.paramStereo.sensorOrigin_L= val;

% Update handles structure
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function editOrigemSenror_L_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editOrigemSenror_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


val= str2num(hObject.String);
handles.paramStereo.sensorOrigin_L= val;

% Update handles structure
guidata(hObject, handles);



function editDistorcaoRadial_L_Callback(hObject, eventdata, handles)
% hObject    handle to editDistorcaoRadial_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editDistorcaoRadial_L as text
%        str2double(get(hObject,'String')) returns contents of editDistorcaoRadial_L as a double

val= str2num(hObject.String);

handles.paramStereo.radialDistortion_L= val;

% Update handles structure
guidata(hObject, handles);



% --- Executes during object creation, after setting all properties.
function editDistorcaoRadial_L_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editDistorcaoRadial_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

val= str2num(hObject.String);

handles.paramStereo.radialDistortion_L= val;

% Update handles structure
guidata(hObject, handles);



function editDistorcaoTangencial_L_Callback(hObject, eventdata, handles)
% hObject    handle to editDistorcaoTangencial_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editDistorcaoTangencial_L as text
%        str2double(get(hObject,'String')) returns contents of editDistorcaoTangencial_L as a double

val= str2num(hObject.String);

handles.paramStereo.tangencialDistortion_L= val;

% Update handles structure
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function editDistorcaoTangencial_L_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editDistorcaoTangencial_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

val= str2num(hObject.String);

handles.paramStereo.tangencialDistortion_L= val;

% Update handles structure
guidata(hObject, handles);




function editRotacaoLeftCam_World_Callback(hObject, eventdata, handles)
% hObject    handle to editRotacaoLeftCam_World (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editRotacaoLeftCam_World as text
%        str2double(get(hObject,'String')) returns contents of editRotacaoLeftCam_World as a double

handles.paramStereo.rotLeftCamWorld= str2num(hObject.String);

% Formata para exibir o resultado na saída:
formato='%15.4f'; 
str_A= num2str(handles.paramStereo.rotLeftCamWorld(1,:), formato);
str_B= num2str(handles.paramStereo.rotLeftCamWorld(2,:), formato);
str_C= num2str(handles.paramStereo.rotLeftCamWorld(3,:), formato );
msg= sprintf('  %s\n  %s\n  %s\n',str_A, str_B, str_C);
handles.outRotacaoWorld.String= str2mat(msg);


% Update handles structure
guidata(hObject, handles);




% --- Executes during object creation, after setting all properties.
function editRotacaoLeftCam_World_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editRotacaoLeftCam_World (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

handles.paramStereo.rotLeftCamWorld= str2num(hObject.String);

% Formata para exibir o resultado na saída:
formato='%15.4f'; 
str_A= num2str(handles.paramStereo.rotLeftCamWorld(1,:), formato);
str_B= num2str(handles.paramStereo.rotLeftCamWorld(2,:), formato);
str_C= num2str(handles.paramStereo.rotLeftCamWorld(3,:), formato );
msg= sprintf('  %s\n  %s\n  %s\n',str_A, str_B, str_C);
handles.outRotacaoWorld.String= str2mat(msg);

% Update handles structure
guidata(hObject, handles);



function editTranslacaoLeftCam_World_Callback(hObject, eventdata, handles)
% hObject    handle to editTranslacaoLeftCam_World (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editTranslacaoLeftCam_World as text
%        str2double(get(hObject,'String')) returns contents of editTranslacaoLeftCam_World as a double

handles.paramStereo.transLeftCamWorld= str2num(hObject.String);

% Formata para exibir o resultado na saída:
formato='%15.4f'; 
str= num2str(handles.paramStereo.transLeftCamWorld, formato);
msg= sprintf('  %s',str);
handles.outTranslacaoWorld.String= str2mat(msg);

% Update handles structure
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function editTranslacaoLeftCam_World_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editTranslacaoLeftCam_World (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

handles.paramStereo.transLeftCamWorld= str2num(hObject.String);

% Formata para exibir o resultado na saída:
formato='%15.4f'; 
str= num2str(handles.paramStereo.transLeftCamWorld, formato);
msg= sprintf('  %s',str);
handles.outTranslacaoWorld.String= str2mat(msg);

% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in rdCarregaArquivoPtos3D.
function rdCarregaArquivoPtos3D_Callback(hObject, eventdata, handles)
% hObject    handle to rdCarregaArquivoPtos3D (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rdCarregaArquivoPtos3D

if hObject.Value
    handles.pbLoadPontos3D.Enable= 'on';
    handles.editCoordenadasXYZ.Enable= 'off';
    handles.pbCalaculaPontosNoPlanoImagem.Enable= 'off';
    handles.rdSimulaPontoComIncrementoDaDistancia.Enable= 'off';    
    handles.editIncrementoDistancia.Enable= 'off';
    handles.editDistanciaMaxima.Enable= 'off'; 
    handles.panelSimulaUnicoPonto.Enable= 'off';
    handles.editNumeroDeSimulacoes.String= '1';
    handles.editNumeroDeSimulacoes.Enable= 'off';
else
    handles.pbLoadPontos3D.Enable= 'off';
    handles.editCoordenadasXYZ.Enable= 'on';
    handles.pbCalaculaPontosNoPlanoImagem.Enable= 'on';   
    handles.rdSimulaPontoComIncrementoDaDistancia.Enable= 'on'; 
    handles.panelSimulaUnicoPonto.Enable= 'on';  
    handles.editNumeroDeSimulacoes.String= '10';
    handles.editNumeroDeSimulacoes.Enable= 'on';
    
    if handles.HabilitaIncrementoDistancia
        handles.editIncrementoDistancia.Enable= 'on';
        handles.editDistanciaMaxima.Enable= 'on';
    end    
end

handles.carregaPontosFromFile= hObject.Value;
handles.pbSimulaPontos3D.Enable= 'off';
handles.pbAnalisaIncertezas.Enable= 'off'; 

handles.numSimulacoes= str2num(handles.editNumeroDeSimulacoes.String);

% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in pbLoadPontos3D.
function pbLoadPontos3D_Callback(hObject, eventdata, handles)
% hObject    handle to pbLoadPontos3D (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.pontos3D_real= fCarregPontos3D(handles);

handles.pbCalaculaPontosNoPlanoImagem.Enable= 'on';

% Update handles structure
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function rdCarregaArquivoPtos3D_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rdCarregaArquivoPtos3D (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

handles.carregaPontosFromFile= hObject.Value;

% Update handles structure
guidata(hObject, handles);



% --- Executes on button press in rdLoadParamsCalibracao.
function rdLoadParamsCalibracao_Callback(hObject, eventdata, handles)
% hObject    handle to rdLoadParamsCalibracao (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rdLoadParamsCalibracao

if hObject.Value
    handles.pbLoadParametrosCalibracao.Enable= 'on';
    handles.pbCalaculaPontosNoPlanoImagem.Enable= 'on';    
    handles.editRotacaoStereo.Enable= 'off';    
    handles.editTranslacaoStereo.Enable= 'off'; 
    handles.editComprimentoFocal_L.Enable= 'off'; 
    handles.editComprimentoFocal_R.Enable= 'off';
    handles.editOrigemSenror_L.Enable= 'off';
    handles.editOrigemSenror_R.Enable= 'off';     
    handles.editDistorcaoRadial_L.Enable= 'off';
    handles.editDistorcaoRadial_R.Enable= 'off';    
    handles.editDistorcaoTangencial_L.Enable= 'off';
    handles.editDistorcaoTangencial_R.Enable= 'off';     
    handles.editIncertezaComprimentoFocal_L.Enable= 'off';
    handles.editIncertezaComprimentoFocal_R.Enable= 'off';     
    handles.editIncertezaBaseline_X.Enable= 'off';
    handles.editBaseLine.Enable= 'off';
    handles.editIncertezaDisparidade.Enable= 'off';
else
    handles.pbLoadParametrosCalibracao.Enable= 'off';
    handles.pbCalaculaPontosNoPlanoImagem.Enable= 'on';
    handles.editRotacaoStereo.Enable= 'on';
    handles.editTranslacaoStereo.Enable= 'on';
    handles.editComprimentoFocal_L.Enable= 'on';
    handles.editComprimentoFocal_R.Enable= 'on'; 
    handles.editOrigemSenror_L.Enable= 'on';
    handles.editOrigemSenror_R.Enable= 'on';    
    handles.editDistorcaoRadial_L.Enable= 'on';
    handles.editDistorcaoRadial_R.Enable= 'on';    
    handles.editDistorcaoTangencial_L.Enable= 'on';
    handles.editDistorcaoTangencial_R.Enable= 'on';    
    handles.editIncertezaComprimentoFocal_L.Enable= 'on';
    handles.editIncertezaComprimentoFocal_R.Enable= 'on';    
    handles.editIncertezaBaseline_X.Enable= 'on'; 
    handles.editBaseLine.Enable= 'on';
    handles.editIncertezaDisparidade.Enable= 'on';    
    
    handles.paramStereo.matrizR= str2num(handles.editRotacaoStereo.String);
    formato='%15.4f'; 
    str_A= num2str(handles.paramStereo.matrizR(1,:), formato);
    str_B= num2str(handles.paramStereo.matrizR(2,:), formato);
    str_C= num2str(handles.paramStereo.matrizR(3,:), formato );
    msg= sprintf('  %s\n  %s\n  %s\n',str_A, str_B, str_C);
    handles.outRotacaoStereo.String= str2mat(msg);
        
    handles.paramStereo.vetorT= str2num(handles.editTranslacaoStereo.String);
    formato='%15.4f'; 
    str= num2str(handles.paramStereo.vetorT, formato);
    msg= sprintf('  %s',str);
    handles.outTranslacaoStereo.String= str2mat(msg);   
end


% Formata para exibir o resultado na saída:
formato='%15.4f'; 
str_A= num2str(handles.paramStereo.rotLeftCamWorld(1,:), formato);
str_B= num2str(handles.paramStereo.rotLeftCamWorld(2,:), formato);
str_C= num2str(handles.paramStereo.rotLeftCamWorld(3,:), formato );
msg= sprintf('  %s\n  %s\n  %s\n',str_A, str_B, str_C);
handles.outRotacaoWorld.String= str2mat(msg);

% Formata para exibir o resultado na saída:
formato='%15.4f'; 
str= num2str(handles.paramStereo.transLeftCamWorld, formato);
msg= sprintf('  %s',str);
handles.outTranslacaoWorld.String= str2mat(msg);

handles.carregaCalibracaoFromFile= hObject.Value;

handles.pbSimulaPontos3D.Enable= 'off';
handles.pbAnalisaIncertezas.Enable= 'off'; 

% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in pbLoadParametrosCalibracao.
function pbLoadParametrosCalibracao_Callback(hObject, eventdata, handles)
% hObject    handle to pbLoadParametrosCalibracao (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc;

% Chama a função para carregar os parêmtros de calibração do sistema
% estéreo, considerando apenas a calibração Bouguet:
[paramCalib loadParamCalibOk]= fLoadParamsCalibracao(handles.pathCalibrationFile);

if ~loadParamCalibOk
    return;
end

% ********************** Carrega alguns parâmetros ************************************
% Vetor de rotação estéreo:
handles.paramStereo.vetorR= paramCalib.rotStereo;

% Define os parâmetros carregados:
handles.paramStereo.matrizR= fRodrigues(paramCalib.rotStereo);

% Carrega o vetor de translação:
handles.paramStereo.vetorT= paramCalib.transStereo;

% Calcula o baseline em mm a partir dos dados de calibração:
handles.paramStereo.baseLine= sqrt(handles.paramStereo.vetorT(1)^2 + handles.paramStereo.vetorT(2)^2 + handles.paramStereo.vetorT(3)^2);

% Carrega s coordendas do sensor a partir do arquivo de calibração:
handles.paramStereo.sensorOrigin_L= paramCalib.sensorOrigin_L;
handles.paramStereo.sensorOrigin_R= paramCalib.sensorOrigin_R;

% Carrega os valores dos comprimentos focais das duas lentes R e L e coverte em :
handles.paramStereo.comprimentoFocal_L= paramCalib.comprimentoFocal_L;
handles.paramStereo.comprimentoFocal_R= paramCalib.comprimentoFocal_R;

% Carrega a distorção radial e tangencial e o skell do arquivo de calibração para a câmera esquerda:
handles.paramStereo.distorcaoLente_L= paramCalib.Distortion_L;
handles.paramStereo.radialDistortion_L= paramCalib.radialDistortion_L;
handles.paramStereo.tangencialDistortion_L= paramCalib.tangencialDistortion_L;
handles.paramStereo.skell_L= paramCalib.skew_L;

% Carrega a distorção radial e tangencial e o skell do arquivo de calibração para a câmera direita:
handles.paramStereo.distorcaoLente_R= paramCalib.Distortion_R;
handles.paramStereo.radialDistortion_R= paramCalib.radialDistortion_R;
handles.paramStereo.tangencialDistortion_R= paramCalib.tangencialDistortion_R;
handles.paramStereo.skell_R= paramCalib.skew_R;


% ********************** Carrega as incertezas *****************************************
% Carrega a incerteza no comprimento focal a partir da calibração e converte em pixel:
handles.incerteza.ComprimentoFocal_L= paramCalib.incerteza_ComprimentoFocal_L;
handles.incerteza.ComprimentoFocal_R= paramCalib.incerteza_ComprimentoFocal_R;

% Carrega a incerteza na rotação entre uma câmera e outra a partir da calibração:
handles.incerteza.RotacaoStereo= paramCalib.incerteza_RotStereo;

% Carrega a incerteza na translação entre uma câmera e outra a partir da calibração:
handles.incerteza.TranslacaoStereo= paramCalib.incerteza_Translacao;
                                                                                                       
% ********************** Atualiza algunsparêmtros no painel GUI  **********************
handles.editIncertezaComprimentoFocal_L.String= sprintf('%4.4f', handles.incerteza.ComprimentoFocal_L(1)*handles.paramStereo.pixelSize);
handles.editIncertezaComprimentoFocal_R.String= sprintf('%4.4f', handles.incerteza.ComprimentoFocal_R(1)*handles.paramStereo.pixelSize);
handles.editComprimentoFocal_L.String= num2str(handles.paramStereo.comprimentoFocal_L(1)*handles.paramStereo.pixelSize); 
handles.editComprimentoFocal_R.String= num2str(handles.paramStereo.comprimentoFocal_R(1)*handles.paramStereo.pixelSize); 
handles.editBaseLine.String= num2str(handles.paramStereo.baseLine);

handles.editIncertezaBaseline_X.String= sprintf('%4.4f',handles.incerteza.TranslacaoStereo(1));
handles.editIncertezaBaseline_Y.String= sprintf('%4.4f',handles.incerteza.TranslacaoStereo(2));
handles.editIncertezaBaseline_Z.String= sprintf('%4.4f',handles.incerteza.TranslacaoStereo(3));
handles.editOrigemSenror_L.String= [sprintf('%4.4f    ',handles.paramStereo.sensorOrigin_L(1)) sprintf('%4.4f',handles.paramStereo.sensorOrigin_L(2))];
handles.editOrigemSenror_R.String= [sprintf('%4.4f    ',handles.paramStereo.sensorOrigin_R(1)) sprintf('%4.4f',handles.paramStereo.sensorOrigin_R(2))];

% handles.editIncertezaDisparidade.String= sprintf('',handles.incerteza.RotacaoStereo);

% Para exibir os valores da matriz de rotação estéreo:
str_A= sprintf('%8.4f %8.4f %8.4f', handles.paramStereo.matrizR(1,1), handles.paramStereo.matrizR(1,2), handles.paramStereo.matrizR(1,3));
str_B= sprintf('%8.4f %8.4f %8.4f', handles.paramStereo.matrizR(2,1), handles.paramStereo.matrizR(2,2), handles.paramStereo.matrizR(2,3));
str_C= sprintf('%8.4f %8.4f %8.4f', handles.paramStereo.matrizR(3,1), handles.paramStereo.matrizR(3,2), handles.paramStereo.matrizR(3,3));
msg= sprintf('  %s\n  %s\n  %s\n',str_A, str_B, str_C);
handles.outRotacaoStereo.String= msg; %str2mat(msg);

% Para exibir os valores do vetor de translação estéreo:
msg= sprintf('%8.2f %8.2f %8.2f', handles.paramStereo.vetorT(1), handles.paramStereo.vetorT(2), handles.paramStereo.vetorT(3));
handles.outTranslacaoStereo.String= msg;

if ~handles.carregaPontosFromFile
    handles.pbCalaculaPontosNoPlanoImagem.Enable= 'on';
end

% Para exibir os valores do vetor de rotação world:
formato='%15.4f'; 
str_A= num2str(handles.paramStereo.rotLeftCamWorld(1,:), formato);
str_B= num2str(handles.paramStereo.rotLeftCamWorld(2,:), formato);
str_C= num2str(handles.paramStereo.rotLeftCamWorld(3,:), formato );
msg= sprintf('  %s\n  %s\n  %s\n',str_A, str_B, str_C);
handles.outRotacaoWorld.String= str2mat(msg);

% Para exibir os valores do vetor de translação world:
formato='%15.4f'; 
str= num2str(handles.paramStereo.transLeftCamWorld, formato);
msg= sprintf('  %s',str);
handles.outTranslacaoWorld.String= str2mat(msg);

handles.ArquivoCalibracaoOk= 1;

handles.pbSalvaTabelaExcell.Enable= 'off';

% Update handles structure
guidata(hObject, handles);




% --- Executes during object creation, after setting all properties.
function rdLoadParamsCalibracao_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rdLoadParamsCalibracao (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

if hObject.Value
    handles.pbLoadParametrosCalibracao.Enable= 'on';
    handles.editRotacaoStereo.Enable= 'off';    
    handles.editTranslacaoStereo.Enable= 'off'; 
else
    handles.pbLoadParametrosCalibracao.Enable= 'off';
    handles.editRotacaoStereo.Enable= 'on'; 
    handles.editTranslacaoStereo.Enable= 'on';
end

handles.carregaCalibracaoFromFile= hObject.Value;

% Update handles structure
guidata(hObject, handles);



% --- Executes on button press in pbCalaculaPontosNoPlanoImagem.
function pbCalaculaPontosNoPlanoImagem_Callback(hObject, eventdata, handles)
% hObject    handle to pbCalaculaPontosNoPlanoImagem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

clc;
close all;

% Chama função para reinicializar todas as variáveis:
% if handles.reinicializarVariaveis
%     myAnswer = questdlg('Deseja reinicializar as variáveis globais?', ...
%                         'Menu', 'Sim','Não', 'Sim');
%     switch myAnswer 
%         case 'Sim'
%             handles= fReinicializaTodasAsVariaveis(handles);
%         case 'Não'
%             return;
%         otherwise
%             return;
%     end
% end


% Reinicializa algumas variáveis:
handles= fReinicializaVariaveis(handles);
    
if handles.carregaPontosFromFile && handles.ArquivoCalibracaoOk
    handles.pontos3D= handles.pontos3D_real;
else
    % Incrementa distância para o ponto 3D d entrada.
    % Esta função não vale para o spontos 3D carregados de arquiv0:
    if handles.HabilitaIncrementoDistancia
        handles.pontos3D= fIncrementaDistancia(handles.pontos3D_sim, handles.DistanciaMaximaSim, handles.IncrementoDistancia);
    else
        handles.pontos3D= handles.pontos3D_sim;       
    end
end

% Gera a matriz de transformação homogênea da câmera direita com relação ao mundo:
handles.matrizT_World= [handles.paramStereo.rotLeftCamWorld  handles.paramStereo.transLeftCamWorld'; [0 0 0 1]];   

% Gera a matriz de transformação homogênea da câmera direita com relação ao mundo:
handles.matrizT_Stereo= [handles.paramStereo.matrizR  handles.paramStereo.vetorT; [0 0 0 1]]; 

% Gera as coordenadas do ponto 3D no plano imagem, ainda em mm, para a scam. esquerda e direita:
[handles.ptoPlanoImagem_left handles.ptoPlanoImagem_right handles.distanciaNominal]= fGeraCoordenadasPlanoImagem(handles.pontos3D, ...
                                                                                                                 handles.paramStereo, ...
                                                                                                                 handles.matrizT_World, ...
                                                                                                                 handles.matrizT_Stereo, ...
                                                                                                                 handles.carregaPontosFromFile, ...
                                                                                                                 handles.HabShowPontosPlanoImagem);                                                 
handles.pbSimulaPontos3D.Enable= 'on';

% Update handles structure
guidata(hObject, handles);



function editNumeroDeSimulacoes_Callback(hObject, eventdata, handles)
% hObject    handle to editNumeroDeSimulacoes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editNumeroDeSimulacoes as text
%        str2double(get(hObject,'String')) returns contents of editNumeroDeSimulacoes as a double


% Reinicializa algumas variáveis:
handles= fReinicializaVariaveis(handles);

handles.numSimulacoes= str2num(hObject.String);

% Update handles structure
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function editNumeroDeSimulacoes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editNumeroDeSimulacoes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

handles.numSimulacoes= str2num(hObject.String);

% Update handles structure
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function outTranslacaoWorld_CreateFcn(hObject, eventdata, handles)
% hObject    handle to outTranslacaoWorld (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



function editComprimentoFocal_R_Callback(hObject, eventdata, handles)
% hObject    handle to editComprimentoFocal_R (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editComprimentoFocal_R as text
%        str2double(get(hObject,'String')) returns contents of editComprimentoFocal_R as a double

handles.paramStereo.comprimentoFocal_R= [str2double(hObject.String) str2double(hObject.String)];

% Update handles structure
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function editComprimentoFocal_R_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editComprimentoFocal_R (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

handles.paramStereo.comprimentoFocal_R= [str2double(hObject.String) str2double(hObject.String)];

% Update handles structure
guidata(hObject, handles);



function editOrigemSenror_R_Callback(hObject, eventdata, handles)
% hObject    handle to editOrigemSenror_R (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editOrigemSenror_R as text
%        str2double(get(hObject,'String')) returns contents of editOrigemSenror_R as a double

val= str2num(hObject.String);
handles.paramStereo.sensorOrigin_R= val;

% Update handles structure
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function editOrigemSenror_R_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editOrigemSenror_R (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

val= str2num(hObject.String);
handles.paramStereo.sensorOrigin_R= val;

% Update handles structure
guidata(hObject, handles);


function editDistorcaoRadial_R_Callback(hObject, eventdata, handles)
% hObject    handle to editDistorcaoRadial_R (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editDistorcaoRadial_R as text
%        str2double(get(hObject,'String')) returns contents of editDistorcaoRadial_R as a double

val= str2num(hObject.String);

handles.paramStereo.radialDistortion_R= val;

% Update handles structure
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function editDistorcaoRadial_R_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editDistorcaoRadial_R (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

val= str2num(hObject.String);

handles.paramStereo.radialDistortion_R= val;

% Update handles structure
guidata(hObject, handles);


function editDistorcaoTangencial_R_Callback(hObject, eventdata, handles)
% hObject    handle to editDistorcaoTangencial_R (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editDistorcaoTangencial_R as text
%        str2double(get(hObject,'String')) returns contents of editDistorcaoTangencial_R as a double
val= str2num(hObject.String);

handles.paramStereo.tangencialDistortion_R= val;

% Update handles structure
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function editDistorcaoTangencial_R_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editDistorcaoTangencial_R (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
val= str2num(hObject.String);

handles.paramStereo.tangencialDistortion_R= val;

% Update handles structure
guidata(hObject, handles);



function editIncertezaComprimentoFocal_R_Callback(hObject, eventdata, handles)
% hObject    handle to editIncertezaComprimentoFocal_R (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editIncertezaComprimentoFocal_R as text
%        str2double(get(hObject,'String')) returns contents of editIncertezaComprimentoFocal_R as a double
 
handles.incerteza.ComprimentoFocal_R= [str2double(hObject.String) str2double(hObject.String)]; 

% Update handles structure
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function editIncertezaComprimentoFocal_R_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editIncertezaComprimentoFocal_R (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

handles.incerteza.ComprimentoFocal_R= [str2double(hObject.String) str2double(hObject.String)]; 

% Update handles structure
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function outRotacaoWorld_CreateFcn(hObject, eventdata, handles)
% hObject    handle to outRotacaoWorld (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called




% --- Executes on button press in rdExibePontos3D.
function rdExibePontos3D_Callback(hObject, eventdata, handles)
% hObject    handle to rdExibePontos3D (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rdExibePontos3D


handles.HabShowPontos3D= hObject.Value;

% Update handles structure
guidata(hObject, handles);



% --- Executes during object creation, after setting all properties.
function rdExibePontos3D_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rdExibePontos3D (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

handles.HabShowPontos3D= hObject.Value;

% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in rdExibePontosPanoImagem.
function rdExibePontosPanoImagem_Callback(hObject, eventdata, handles)
% hObject    handle to rdExibePontosPanoImagem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rdExibePontosPanoImagem

handles.HabShowPontosPlanoImagem= hObject.Value;

% Update handles structure
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function rdExibePontosPanoImagem_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rdExibePontosPanoImagem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


handles.HabShowPontosPlanoImagem= hObject.Value;

% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in pbAnalisaIncertezas.
function pbAnalisaIncertezas_Callback(hObject, eventdata, handles)
% hObject    handle to pbAnalisaIncertezas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

clc;
close all;

[estatistica curvaAjustada]= fAnalisaIncertezas(handles.X_L_sim, handles.X_R_sim, handles.numSimulacoes,...
                                                handles.distanciaNominal, handles.CalculaIncerteza_Y, ...
                                                handles.carregaPontosFromFile, handles.pontos3D, ...
                                                handles.residuo_X_L, handles.residuo_X_R);

% Define o valor do eixo coordenado:
[numPontos]= size(handles.X_L_sim, 1);
pontos= 1:1:numPontos;

% Exibe os resultados:
if handles.carregaPontosFromFile
    fPlotAnaliseA(pontos, estatistica, handles.residuo_X_L, handles.residuo_X_R, handles.CalculaIncerteza_Y, handles.X_L_sim, handles.pontos3D);                                              
else    
    if handles.ExibeGraficoComEstatistica && handles.ExibeTabelaComEstatistica
        fPlotAnaliseB(pontos, estatistica, curvaAjustada, handles.CalculaIncerteza_Y);
        fGeraTabelaEstatistica(pontos, estatistica, curvaAjustada, handles.distanciaNominal, handles.CalculaIncerteza_Y);
    elseif handles.ExibeGraficoComEstatistica 
        fPlotAnaliseB(pontos, estatistica, curvaAjustada, handles.CalculaIncerteza_Y);        
    elseif handles.ExibeTabelaComEstatistica 
        fGeraTabelaEstatistica(pontos, estatistica, curvaAjustada, handles.distanciaNominal, handles.CalculaIncerteza_Y);
    end                                           
end

% Gera uma variavel global com a estatistica:
handles.estatistica= estatistica;

handles.pbSalvaTabelaExcell.Enable= 'on';

% Update handles structure
guidata(hObject, handles);



function editIncrementoDistancia_Callback(hObject, eventdata, handles)
% hObject    handle to editIncrementoDistancia (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editIncrementoDistancia as text
%        str2double(get(hObject,'String')) returns contents of editIncrementoDistancia as a double


% Reinicializa algumas variáveis:
handles= fReinicializaVariaveis(handles);

handles.IncrementoDistancia= str2num(hObject.String);

% Update handles structure
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function editIncrementoDistancia_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editIncrementoDistancia (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

handles.IncrementoDistancia= str2num(hObject.String);

% Update handles structure
guidata(hObject, handles);


function editDistanciaMaxima_Callback(hObject, eventdata, handles)
% hObject    handle to editDistanciaMaxima (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editDistanciaMaxima as text
%        str2double(get(hObject,'String')) returns contents of editDistanciaMaxima as a double


% Reinicializa algumas variáveis:
handles= fReinicializaVariaveis(handles);

handles.DistanciaMaximaSim= str2num(hObject.String);


% Update handles structure
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function editDistanciaMaxima_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editDistanciaMaxima (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

handles.DistanciaMaximaSim= str2num(hObject.String);

% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in rdSimulaPontoComIncrementoDaDistancia.
function rdSimulaPontoComIncrementoDaDistancia_Callback(hObject, eventdata, handles)
% hObject    handle to rdSimulaPontoComIncrementoDaDistancia (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rdSimulaPontoComIncrementoDaDistancia
if hObject.Value
    handles.editIncrementoDistancia.Enable= 'on';
    handles.editDistanciaMaxima.Enable= 'on';
else
    handles.editIncrementoDistancia.Enable= 'off';
    handles.editDistanciaMaxima.Enable= 'off';    
end

handles.HabilitaIncrementoDistancia= hObject.Value;
handles.pbSimulaPontos3D.Enable= 'off';

% Update handles structure
guidata(hObject, handles);




% --- Executes during object creation, after setting all properties.
function rdSimulaPontoComIncrementoDaDistancia_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rdSimulaPontoComIncrementoDaDistancia (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

handles.HabilitaIncrementoDistancia= hObject.Value;

% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in rdCalculaIncertezaEmY.
function rdCalculaIncertezaEmY_Callback(hObject, eventdata, handles)
% hObject    handle to rdCalculaIncertezaEmY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rdCalculaIncertezaEmY

handles.CalculaIncerteza_Y= hObject.Value;

% Update handles structure
guidata(hObject, handles);




% --- Executes during object creation, after setting all properties.
function rdCalculaIncertezaEmY_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rdCalculaIncertezaEmY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

handles.CalculaIncerteza_Y= hObject.Value;

% Update handles structure
guidata(hObject, handles);



function editIncertezaBaseline_Y_Callback(hObject, eventdata, handles)
% hObject    handle to editIncertezaBaseline_Y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editIncertezaBaseline_Y as text
%        str2double(get(hObject,'String')) returns contents of editIncertezaBaseline_Y as a double


% --- Executes during object creation, after setting all properties.
function editIncertezaBaseline_Y_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editIncertezaBaseline_Y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editIncertezaBaseline_Z_Callback(hObject, eventdata, handles)
% hObject    handle to editIncertezaBaseline_Z (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editIncertezaBaseline_Z as text
%        str2double(get(hObject,'String')) returns contents of editIncertezaBaseline_Z as a double


% --- Executes during object creation, after setting all properties.
function editIncertezaBaseline_Z_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editIncertezaBaseline_Z (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in rdExibeGraficoComEstatistica.
function rdExibeGraficoComEstatistica_Callback(hObject, eventdata, handles)
% hObject    handle to rdExibeGraficoComEstatistica (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rdExibeGraficoComEstatistica

handles.ExibeGraficoComEstatistica= hObject.Value;

% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in rdExibeTabelaComEstatistica.
function rdExibeTabelaComEstatistica_Callback(hObject, eventdata, handles)
% hObject    handle to rdExibeTabelaComEstatistica (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rdExibeTabelaComEstatistica

handles.ExibeTabelaComEstatistica= hObject.Value;

% Update handles structure
guidata(hObject, handles);




% --- Executes during object creation, after setting all properties.
function rdExibeGraficoComEstatistica_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rdExibeGraficoComEstatistica (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

handles.ExibeGraficoComEstatistica= hObject.Value;

% Update handles structure
guidata(hObject, handles);




% --- Executes during object creation, after setting all properties.
function rdExibeTabelaComEstatistica_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rdExibeTabelaComEstatistica (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

handles.ExibeTabelaComEstatistica= hObject.Value;

% Update handles structure
guidata(hObject, handles);


function editFatorKIntrinseco_Callback(hObject, eventdata, handles)
% hObject    handle to editFatorKIntrinseco (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editFatorKIntrinseco as text
%        str2double(get(hObject,'String')) returns contents of editFatorKIntrinseco as a double


% Reinicializa algumas variáveis:
handles= fReinicializaVariaveis(handles);

if str2num(hObject.String)>=0 && str2num(hObject.String)<=1
    handles.fatorK_Intrinseco= str2num(hObject.String);
else
    hObject.String= num2str(1.0);
    handles.fatorK_Intrinseco= 1.0;
    msgbox('O fator K intrínseco deve ter um valor entre 0 e 1.', 'Warn', 'warn');    
end

% Update handles structure
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function editFatorKIntrinseco_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editFatorKIntrinseco (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

handles.fatorK_Intrinseco= str2num(hObject.String);

% Update handles structure
guidata(hObject, handles);



function editFatorKExtrinseco_Callback(hObject, eventdata, handles)
% hObject    handle to editFatorKExtrinseco (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editFatorKExtrinseco as text
%        str2double(get(hObject,'String')) returns contents of editFatorKExtrinseco as a double


% Reinicializa algumas variáveis:
handles= fReinicializaVariaveis(handles);

if str2num(hObject.String)>=0 && str2num(hObject.String)<=1
    handles.fatorK_Extrinseco= str2num(hObject.String);
else
    hObject.String= num2str(1.0);
    handles.fatorK_Extrinseco= 1.0;
    msgbox('O fator K extrínseco deve ter um valor entre 0 e 1.', 'Warn', 'warn');    
end

% Update handles structure
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function editFatorKExtrinseco_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editFatorKExtrinseco (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

handles.fatorK_Extrinseco= str2num(hObject.String);

% Update handles structure
guidata(hObject, handles);




% --- Executes on button press in pbSalvaTabelaExcell.
function pbSalvaTabelaExcell_Callback(hObject, eventdata, handles)
% hObject    handle to pbSalvaTabelaExcell (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

fGeraTabelaExcell(handles.estatistica);


