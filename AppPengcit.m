function varargout = AppPengcit(varargin)
% APPPENGCIT MATLAB code for AppPengcit.fig
%      APPPENGCIT, by itself, creates a new APPPENGCIT or raises the existing
%      singleton*.
%
%      H = APPPENGCIT returns the handle to a new APPPENGCIT or the handle to
%      the existing singleton*.
%
%      APPPENGCIT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in APPPENGCIT.M with the given input arguments.
%
%      APPPENGCIT('Property','Value',...) creates a new APPPENGCIT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before AppPengcit_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to AppPengcit_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help AppPengcit

% Last Modified by GUIDE v2.5 17-Nov-2020 13:54:41

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @AppPengcit_OpeningFcn, ...
                   'gui_OutputFcn',  @AppPengcit_OutputFcn, ...
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


% --- Executes just before AppPengcit is made visible.
function AppPengcit_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to AppPengcit (see VARARGIN)

% Choose default command line output for AppPengcit
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes AppPengcit wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = AppPengcit_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pilihGambar.
function pilihGambar_Callback(hObject, eventdata, handles)
% hObject    handle to pilihGambar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global gg gc;
gg = 2;
h=guidata(gcbo);
set(h.message_text,'String','');  % Clear Messages
h.image_filename=1;
h.image_pathname=1;
[filename, pathname] = uigetfile( ...
       {'*.bmp;*.tif;*.jpg;*.pcx;*.png;*.hdf;*.xwd;*.ras;*.pbm;*.pgm;*.ppm;*.pnm', 'All MATLAB SUPPORTED IMAGE Files (*.bmp,*.tif,*.jpg,*.pcx,*.png,*.hdf,*.xwd,*.ras,*.pbm,.pgm,*.ppm,*.pnm)'} ...
        ,'Pilih gambar');     % Load Image file and path names
    if filename~=0
        gg=1;
        h.image_filename=filename;  % Image file name
        h.image_pathname=pathname;  % Image path name
        axes(h.axes1);
        image_1=imread([pathname filename]); % Load Image
        imshow(image_1);                     % Show Loaded Image
        h.image_1=image_1;
        axes(h.axes2);
        cla;
        gc=0;
        h.axis12=0;
        guidata(gcbo,h);
    end

% --- Executes on button press in transformGambar.
function transformGambar_Callback(hObject, eventdata, handles)
% hObject    handle to transformGambar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global gg gc;
gc=0;
h=guidata(gcbo);
if  gg~=2 
    h=guidata(gcbo);
    image_1=h.image_1;  % Get Image 1
    hb(1)=num_check(h.derajatRotasi); % Rotation
    hb(2)=num_check(h.skalaX); % Scale in x-direction
    hb(3)=num_check(h.skalaY); % Scale in y-direction
    hb(4)=num_check(h.bengkokX); % Shear
    hb(5)=num_check(h.bengkokY);
    hb(6)=num_check(h.translasiY);
    hb(7)=num_check(h.translasiY);
    hb(8)=num_check(h.gaussSigma);
    hb(9)=num_check(h.gaussSize);
    hb(10)=num_check(h.avgSize);
    hb(11)=num_check(h.sharpenRad);
    hc=sum(hb);
    switch hc
        case 0
            a=str2num(get(h.skalaX,'String'));  
            b=str2num(get(h.bengkokX,'String'));
            c=str2num(get(h.bengkokY,'String'));
            d=str2num(get(h.skalaY,'String'));
            e=str2num(get(h.translasiX,'String'));
            f=str2num(get(h.translasiX,'String'));
            aa = str2num(get(h.avgSize,'String'));
            bb = str2num(get(h.gaussSize,'String'));
            cc = str2num(get(h.gaussSigma,'String'));
            dd = str2num(get(h.sharpenRad,'String'));
            th=str2num(get(h.derajatRotasi,'String'));  %2*pi/10;
            img_temp = imageresize(image_1, a, d);
            img_temp = imagetranslation(img_temp, e, f);
            img_temp = imagerotation(img_temp, th);
            img_temp = imageshearing(img_temp, b, c);
            if aa > 0
                img_temp = imageavgblur(img_temp, aa);
            end
            if bb > 0 && cc > 0
                img_temp = imagegaussblur(img_temp, bb, cc);
            end
            if dd > 0
                img_temp = imagesharpen(img_temp, dd);
            end
            [image_2] = img_temp;
            h.image_2=image_2;
            axes(h.axes2);
            imshow(image_2,[]);
            gc=1;
            set(h.message_text,'String','Selesai');
            guidata(gcbo,h);    
        otherwise
            set(h.message_text,'String','Error');
    end
end

% --- Executes on button press in simpanGambar.
function simpanGambar_Callback(hObject, eventdata, handles)
% hObject    handle to simpanGambar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global gc;
h=guidata(gcbo);
set(h.message_text,'String',''); 
if   gc~=0
    pathname=h.image_pathname;
    [filename, pathname] = uiputfile('*.*', 'Simpan Hasil Gambar');
    CMap=colormap(h.axes1);
	h.savedimage_filename=filename;
	h.savedimage_pathname=pathname;
	imwrite(h.image_2,CMap,[pathname filename]);
	savedto=['Gambar disimpan di:    ' pathname filename];
    set(h.message_text,'String',savedto); 
end

function skalaX_Callback(hObject, eventdata, handles)
% hObject    handle to skalaX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of skalaX as text
%        str2double(get(hObject,'String')) returns contents of skalaX as a double


% --- Executes during object creation, after setting all properties.
function skalaX_CreateFcn(hObject, eventdata, handles)
% hObject    handle to skalaX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function skalaY_Callback(hObject, eventdata, handles)
% hObject    handle to skalaY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of skalaY as text
%        str2double(get(hObject,'String')) returns contents of skalaY as a double


% --- Executes during object creation, after setting all properties.
function skalaY_CreateFcn(hObject, eventdata, handles)
% hObject    handle to skalaY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function translasiX_Callback(hObject, eventdata, handles)
% hObject    handle to translasiX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of translasiX as text
%        str2double(get(hObject,'String')) returns contents of translasiX as a double


% --- Executes during object creation, after setting all properties.
function translasiX_CreateFcn(hObject, eventdata, handles)
% hObject    handle to translasiX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function bengkokX_Callback(hObject, eventdata, handles)
% hObject    handle to bengkokX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of bengkokX as text
%        str2double(get(hObject,'String')) returns contents of bengkokX as a double


% --- Executes during object creation, after setting all properties.
function bengkokX_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bengkokX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function translasiY_Callback(hObject, eventdata, handles)
% hObject    handle to translasiY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of translasiY as text
%        str2double(get(hObject,'String')) returns contents of translasiY as a double


% --- Executes during object creation, after setting all properties.
function translasiY_CreateFcn(hObject, eventdata, handles)
% hObject    handle to translasiY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function bengkokY_Callback(hObject, eventdata, handles)
% hObject    handle to bengkokY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of bengkokY as text
%        str2double(get(hObject,'String')) returns contents of bengkokY as a double


% --- Executes during object creation, after setting all properties.
function bengkokY_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bengkokY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function derajatRotasi_Callback(hObject, eventdata, handles)
% hObject    handle to derajatRotasi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of derajatRotasi as text
%        str2double(get(hObject,'String')) returns contents of derajatRotasi as a double


% --- Executes during object creation, after setting all properties.
function derajatRotasi_CreateFcn(hObject, eventdata, handles)
% hObject    handle to derajatRotasi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function hb=num_check(ha);
% This function checks the validation of the entered transformation
% parameters
% ha is the handle to be checked
% hb is a flag, 1 for correct range, 0 for incorrect range.
h=guidata(gcbo);
ba=get(ha,'String');
bb=str2num(ba);
hb=0;
if isempty(bb) | ba=='i' | ba=='j'
    axes(h.axes2);
    cla;
    set(h.message_text,'String','Masukkan Angka saja');
    switch ha
        case h.xscale
            set(ha,'String','1');
        case h.yscale
            set(ha,'String','1');
        otherwise
            set(ha,'String','0');
    end
    hb=1;
    %break
end
%hb=ha;
%guidata(gcbo,h);



function avgSize_Callback(hObject, eventdata, handles)
% hObject    handle to avgSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of avgSize as text
%        str2double(get(hObject,'String')) returns contents of avgSize as a double


% --- Executes during object creation, after setting all properties.
function avgSize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to avgSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit9_Callback(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit9 as text
%        str2double(get(hObject,'String')) returns contents of edit9 as a double


% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function gaussSize_Callback(hObject, eventdata, handles)
% hObject    handle to gaussSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of gaussSize as text
%        str2double(get(hObject,'String')) returns contents of gaussSize as a double


% --- Executes during object creation, after setting all properties.
function gaussSize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gaussSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function gaussSigma_Callback(hObject, eventdata, handles)
% hObject    handle to gaussSigma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of gaussSigma as text
%        str2double(get(hObject,'String')) returns contents of gaussSigma as a double


% --- Executes during object creation, after setting all properties.
function gaussSigma_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gaussSigma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function sharpenRad_Callback(hObject, eventdata, handles)
% hObject    handle to sharpenRad (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sharpenRad as text
%        str2double(get(hObject,'String')) returns contents of sharpenRad as a double


% --- Executes during object creation, after setting all properties.
function sharpenRad_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sharpenRad (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
