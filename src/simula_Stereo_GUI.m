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

% Last Modified by GUIDE v2.5 23-Jan-2024 18:09:56

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
handles.pathBase= 'C:\Projetos\Matlab\programas_GUI\simula_Stereo_GUI\src\in';
handles.pathCalibrationFile= 'D:\Moacir\ensaios\Calibracao\vigente\estereo\bouguet';

% Choose default command line output for simula_Stereo_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

handles.StaticIncertezaDisparidade.String= num2str(sqrt(handles.incertezaX^2 + handles.incertezaY^2));

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

handles.incertezaX= str2double(hObject.String);

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


% --- Executes on button press in pbSimulaIncertezaStereo.
function pbSimulaIncertezaStereo_Callback(hObject, eventdata, handles)
% hObject    handle to pbSimulaIncertezaStereo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

fSimulaStereo(handles);


% Update handles structure
guidata(hObject, handles);







function editPixelSize_Callback(hObject, eventdata, handles)
% hObject    handle to editPixelSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editPixelSize as text
%        str2double(get(hObject,'String')) returns contents of editPixelSize as a double

handles.pixelSize= str2double(hObject.String);

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

handles.pixelSize= str2double(hObject.String);

% Update handles structure
guidata(hObject, handles);


function editIncertezaY_Callback(hObject, eventdata, handles)
% hObject    handle to editIncertezaY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editIncertezaY as text
%        str2double(get(hObject,'String')) returns contents of editIncertezaY as a double

handles.incertezaY= str2double(hObject.String);

if ~handles.rdDefineIncertezaDisparidadeManualmente.Value
    handles.StaticIncertezaDisparidade.String= num2str(sqrt(handles.incertezaX^2 + handles.incertezaY^2));
end

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

handles.incertezaY= str2double(hObject.String);

% Update handles structure
guidata(hObject, handles);



function editIncertezaX_Callback(hObject, eventdata, handles)
% hObject    handle to editIncertezaX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editIncertezaX as text
%        str2double(get(hObject,'String')) returns contents of editIncertezaX as a double

handles.incertezaX= str2double(hObject.String);

if ~handles.rdDefineIncertezaDisparidadeManualmente.Value
    handles.StaticIncertezaDisparidade.String= num2str(sqrt(handles.incertezaX^2 + handles.incertezaY^2));
end

% Update handles structure
guidata(hObject, handles);


function editIncertezaDisparidade_Callback(hObject, eventdata, handles)
% hObject    handle to editIncertezaDisparidade (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editIncertezaDisparidade as text
%        str2double(get(hObject,'String')) returns contents of editIncertezaDisparidade as a double

handles.incertezaDisparidade= str2double(hObject.String);

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


% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in rdDefineIncertezaDisparidadeManualmente.
function rdDefineIncertezaDisparidadeManualmente_Callback(hObject, eventdata, handles)
% hObject    handle to rdDefineIncertezaDisparidadeManualmente (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rdDefineIncertezaDisparidadeManualmente

if hObject.Value
    handles.StaticIncertezaDisparidade.Enable= 'off';
    handles.editIncertezaDisparidade.Enable= 'on';
    handles.incertezaDisparidade= str2double(handles.editIncertezaDisparidade.String);
else
    handles.StaticIncertezaDisparidade.Enable= 'on';
    handles.editIncertezaDisparidade.Enable= 'off'; 
    handles.incertezaDisparidade= num2str(sqrt(handles.incertezaX^2 + handles.incertezaY^2));
   
end

% Update handles structure
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function StaticIncertezaDisparidade_CreateFcn(hObject, eventdata, handles)
% hObject    handle to StaticIncertezaDisparidade (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

handles.incertezaDisparidade= 0.0078;

% Update handles structure
guidata(hObject, handles);




function editBaseLine_Callback(hObject, eventdata, handles)
% hObject    handle to editBaseLine (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editBaseLine as text
%        str2double(get(hObject,'String')) returns contents of editBaseLine as a double


handles.baseLine= str2double(hObject.String);

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

handles.baseLine= str2double(hObject.String);

% Update handles structure
guidata(hObject, handles);


function editComprimentoFocal_Callback(hObject, eventdata, handles)
% hObject    handle to editComprimentoFocal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editComprimentoFocal as text
%        str2double(get(hObject,'String')) returns contents of editComprimentoFocal as a double

handles.comprimentoFocal_L= [str2double(hObject.String) str2double(hObject.String)];
handles.comprimentoFocal_R= [str2double(hObject.String) str2double(hObject.String)];

% Update handles structure
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function editComprimentoFocal_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editComprimentoFocal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

handles.comprimentoFocal_L= [str2double(hObject.String) str2double(hObject.String)];
handles.comprimentoFocal_R= [str2double(hObject.String) str2double(hObject.String)];

% Update handles structure
guidata(hObject, handles);


function editCoordenadasXYZ_Callback(hObject, eventdata, handles)
% hObject    handle to editCoordenadasXYZ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editCoordenadasXYZ as text
%        str2double(get(hObject,'String')) returns contents of editCoordenadasXYZ as a double


handles.xyz= str2num(hObject.String);

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


handles.xyz= str2num(hObject.String);

% Update handles structure
guidata(hObject, handles);



function editIncertezaComprimentoFocal_Callback(hObject, eventdata, handles)
% hObject    handle to editIncertezaComprimentoFocal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editIncertezaComprimentoFocal as text
%        str2double(get(hObject,'String')) returns contents of editIncertezaComprimentoFocal as a double

handles.incertezaComprimentoFocal_L= [str2double(hObject.String) str2double(hObject.String)]; 
handles.incertezaComprimentoFocal_R= [str2double(hObject.String) str2double(hObject.String)]; 

% Update handles structure
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function editIncertezaComprimentoFocal_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editIncertezaComprimentoFocal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

handles.incertezaComprimentoFocal_L= [str2double(hObject.String) str2double(hObject.String)];
handles.incertezaComprimentoFocal_R= [str2double(hObject.String) str2double(hObject.String)]; 

% Update handles structure
guidata(hObject, handles);


function editIncertezaBaseline_Callback(hObject, eventdata, handles)
% hObject    handle to editIncertezaBaseline (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editIncertezaBaseline as text
%        str2double(get(hObject,'String')) returns contents of editIncertezaBaseline as a double

handles.incertezaTranslacaoStereo= str2double(hObject.String); 

% Update handles structure
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function editIncertezaBaseline_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editIncertezaBaseline (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

handles.incertezaTranslacaoStereo= str2double(hObject.String); 

% Update handles structure
guidata(hObject, handles);



function editRotacaoStereo_Callback(hObject, eventdata, handles)
% hObject    handle to editRotacaoStereo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editRotacaoStereo as text
%        str2double(get(hObject,'String')) returns contents of editRotacaoStereo as a double

handles.rotStereo= str2num(hObject.String);

% Formata para exibir o resultado na saída:
formato='%15.4f'; 
str_A= num2str(handles.rotStereo(1,:), formato);
str_B= num2str(handles.rotStereo(2,:), formato);
str_C= num2str(handles.rotStereo(3,:), formato );
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

handles.rotStereo= str2num(hObject.String);


% Update handles structure
guidata(hObject, handles);



function editTranslacaoStereo_Callback(hObject, eventdata, handles)
% hObject    handle to editTranslacaoStereo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editTranslacaoStereo as text
%        str2double(get(hObject,'String')) returns contents of editTranslacaoStereo as a double

handles.transStereo= str2num(hObject.String);

% Formata para exibir o resultado na saída:
formato='%15.4f'; 
str= num2str(handles.transStereo, formato);
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

handles.transStereo= str2num(hObject.String);

% Update handles structure
guidata(hObject, handles);



function editSensorSize_Callback(hObject, eventdata, handles)
% hObject    handle to editSensorSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editSensorSize as text
%        str2double(get(hObject,'String')) returns contents of editSensorSize as a double

handles.sensorSize= str2num(hObject.String);

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

handles.sensorSize= str2num(hObject.String);

% Update handles structure
guidata(hObject, handles);



function editOrigemSenror_Callback(hObject, eventdata, handles)
% hObject    handle to editOrigemSenror (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editOrigemSenror as text
%        str2double(get(hObject,'String')) returns contents of editOrigemSenror as a double

val= str2num(hObject.String);
handles.sensorOrigin_L= val(1);
handles.sensorOrigin_R= val(2);

% Update handles structure
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function editOrigemSenror_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editOrigemSenror (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

val= str2num(hObject.String);
handles.sensorOrigin_L= val(1);
handles.sensorOrigin_R= val(2);

% Update handles structure
guidata(hObject, handles);



function editDistorcaoRadial_Callback(hObject, eventdata, handles)
% hObject    handle to editDistorcaoRadial (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editDistorcaoRadial as text
%        str2double(get(hObject,'String')) returns contents of editDistorcaoRadial as a double

val= str2num(hObject.String);

handles.radialDistortion_L= val;
handles.radialDistortion_R= val;

% Update handles structure
guidata(hObject, handles);



% --- Executes during object creation, after setting all properties.
function editDistorcaoRadial_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editDistorcaoRadial (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

val= str2num(hObject.String);

handles.radialDistortion_L= val;
handles.radialDistortion_R= val;

% Update handles structure
guidata(hObject, handles);



function editDistorcaoTangencial_Callback(hObject, eventdata, handles)
% hObject    handle to editDistorcaoTangencial (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editDistorcaoTangencial as text
%        str2double(get(hObject,'String')) returns contents of editDistorcaoTangencial as a double

val= str2num(hObject.String);

handles.tangencialDistortion_L= val;
handles.tangencialDistortion_R= val;

% Update handles structure
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function editDistorcaoTangencial_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editDistorcaoTangencial (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

val= str2num(hObject.String);

handles.tangencialDistortion_L= val;
handles.tangencialDistortion_R= val;

% Update handles structure
guidata(hObject, handles);




function editRotacaoLeftCam_World_Callback(hObject, eventdata, handles)
% hObject    handle to editRotacaoLeftCam_World (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editRotacaoLeftCam_World as text
%        str2double(get(hObject,'String')) returns contents of editRotacaoLeftCam_World as a double

handles.rotLeftCamWorld= str2num(hObject.String);

% Formata para exibir o resultado na saída:
formato='%15.4f'; 
str_A= num2str(handles.rotLeftCamWorld(1,:), formato);
str_B= num2str(handles.rotLeftCamWorld(2,:), formato);
str_C= num2str(handles.rotLeftCamWorld(3,:), formato );
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

handles.rotLeftCamWorld= str2num(hObject.String);

% Formata para exibir o resultado na saída:
formato='%15.4f'; 
str_A= num2str(handles.rotLeftCamWorld(1,:), formato);
str_B= num2str(handles.rotLeftCamWorld(2,:), formato);
str_C= num2str(handles.rotLeftCamWorld(3,:), formato );
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

handles.transLeftCamWorld= str2num(hObject.String);

% Formata para exibir o resultado na saída:
formato='%15.4f'; 
str= num2str(handles.transLeftCamWorld, formato);
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

handles.transLeftCamWorld= str2num(hObject.String);

% Formata para exibir o resultado na saída:
formato='%15.4f'; 
str= num2str(handles.transLeftCamWorld, formato);
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
else
    handles.pbLoadPontos3D.Enable= 'off';
    handles.editCoordenadasXYZ.Enable= 'on';
end

handles.carregaPontosFromFile= hObject.Value;

% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in pbLoadPontos3D.
function pbLoadPontos3D_Callback(hObject, eventdata, handles)
% hObject    handle to pbLoadPontos3D (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.pontos3D= fCarregPontos3D(handles);

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
    handles.editRotacaoStereo.Enable= 'off';    
    handles.editTranslacaoStereo.Enable= 'off'; 
    handles.editComprimentoFocal.Enable= 'off'; 
    handles.editOrigemSenror.Enable= 'off';
    handles.editDistorcaoRadial.Enable= 'off';
    handles.editDistorcaoTangencial.Enable= 'off';
    handles.editIncertezaComprimentoFocal.Enable= 'off';
    handles.editIncertezaBaseline.Enable= 'off';
else
    handles.pbLoadParametrosCalibracao.Enable= 'off';
    handles.editRotacaoStereo.Enable= 'on'; 
    handles.editTranslacaoStereo.Enable= 'on';
    handles.editComprimentoFocal.Enable= 'on'; 
    handles.editOrigemSenror.Enable= 'on';
    handles.editDistorcaoRadial.Enable= 'on';
    handles.editDistorcaoTangencial.Enable= 'on';
    handles.editIncertezaComprimentoFocal.Enable= 'on';
    handles.editIncertezaBaseline.Enable= 'on'; 
    
    handles.rotStereo= str2num(handles.editRotacaoStereo.String);
    formato='%15.4f'; 
    str_A= num2str(handles.rotStereo(1,:), formato);
    str_B= num2str(handles.rotStereo(2,:), formato);
    str_C= num2str(handles.rotStereo(3,:), formato );
    msg= sprintf('  %s\n  %s\n  %s\n',str_A, str_B, str_C);
    handles.outRotacaoStereo.String= str2mat(msg);
        
    handles.transStereo= str2num(handles.editTranslacaoStereo.String);
    formato='%15.4f'; 
    str= num2str(handles.transStereo, formato);
    msg= sprintf('  %s',str);
    handles.outTranslacaoStereo.String= str2mat(msg);   
end

handles.carregaCalibracaoFromFile= hObject.Value;

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

% Define os parâmetros carregados:
handles.rotStereo= fRodrigues(paramCalib.rotStereo);

% Para exibir os valores da matriz de rotação:
format short;
formato='%15.4f'; 
str_A= num2str(handles.rotStereo(1,:), formato);
str_B= num2str(handles.rotStereo(2,:), formato);
str_C= num2str(handles.rotStereo(3,:), formato );
msg= sprintf('  %s\n  %s\n  %s\n',str_A, str_B, str_C);
handles.outRotacaoStereo.String= str2mat(msg);

% Carrega o vetor de translação:
handles.transStereo= paramCalib.transStereo';

% Para exibir os valores do vertor de translação:
formato='%15.4f'; 
str= num2str(handles.transStereo', formato);
msg= sprintf('  %s',str);
handles.outTranslacaoStereo.String= str2mat(msg);


handles.sensorOrigin_L= paramCalib.sensorOrigin_L;
handles.sensorOrigin_R= paramCalib.sensorOrigin_R;

handles.comprimentoFocal_L= paramCalib.comprimentoFocal_L;
handles.comprimentoFocal_R= paramCalib.comprimentoFocal_R;

handles.radialDistortion_L= paramCalib.radialDistortion_L;
handles.tangencialDistortion_L= paramCalib.tangencialDistortion_L;

handles.radialDistortion_R= paramCalib.radialDistortion_R;
handles.tangencialDistortion_R= paramCalib.tangencialDistortion_R;

handles.incertezaComprimentoFocal_L= paramCalib.incerteza_ComprimentoFocal_L;
handles.incertezaComprimentoFocal_R= paramCalib.incerteza_ComprimentoFocal_R;

handles.incertezaRotacaoStereo= paramCalib.incerteza_RotStereo;
handles.incertezaTranslacaoStereo= paramCalib.incerteza_Translacao;


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

