function varargout = SingingEvaluation(varargin)
% SINGINGEVALUATION MATLAB code for SingingEvaluation.fig
%      SINGINGEVALUATION, by itself, creates a new SINGINGEVALUATION or raises the existing
%      singleton*.
%
%      H = SINGINGEVALUATION returns the handle to a new SINGINGEVALUATION or the handle to
%      the existing singleton*.
%
%      SINGINGEVALUATION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SINGINGEVALUATION.M with the given input arguments.
%
%      SINGINGEVALUATION('Property','Value',...) creates a new SINGINGEVALUATION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SingingEvaluation_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SingingEvaluation_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SingingEvaluation

% Last Modified by GUIDE v2.5 22-May-2018 01:24:34

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SingingEvaluation_OpeningFcn, ...
                   'gui_OutputFcn',  @SingingEvaluation_OutputFcn, ...
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


% --- Executes just before SingingEvaluation is made visible.
function SingingEvaluation_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SingingEvaluation (see VARARGIN)

% Choose default command line output for SingingEvaluation
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes SingingEvaluation wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = SingingEvaluation_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 [data1, fs1] = wavread('502.wav');
[ps1, nf1] = yaapt(data1, fs1, 1, [], 0, 2);  %用 yaapt（）函数计算音高轨迹.计算的音调跟踪被保存在长度为 nf的阵列音高中.
Pitch_fixed1=ptch_fix(ps1);
[data2, fs2] = wavread('501-voice.wav');
[ps2, nf2] = yaapt(data2, fs2, 1, [], 0, 2);  %用 yaapt（）函数计算音高轨迹.计算的音调跟踪被保存在长度为 nf的阵列音高中.
Pitch_fixed2=ptch_fix(ps2);
RMSe1=sqrt(sum((Pitch_fixed2-Pitch_fixed1).^2)/301)
[data2, fs2] = wavread('503-voice.wav');
[ps2, nf2] = yaapt(data2, fs2, 1, [], 0, 2);  %用 yaapt（）函数计算音高轨迹.计算的音调跟踪被保存在长度为 nf的阵列音高中.
Pitch_fixed2=ptch_fix(ps2);
RMSe2=sqrt(sum((Pitch_fixed2-Pitch_fixed1).^2)/301)
a=RMSe2/RMSe1*100
set(handles.edit1,'String',num2str(a))



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
