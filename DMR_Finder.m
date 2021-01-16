function varargout = DMR_Finder(varargin)
% DMR_FINDER MATLAB code for DMR_Finder.fig
%      DMR_FINDER, by itself, creates a new DMR_FINDER or raises the existing
%      singleton*.
%
%      H = DMR_FINDER returns the handle to a new DMR_FINDER or the handle to
%      the existing singleton*.
%
%      DMR_FINDER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DMR_FINDER.M with the given input arguments.
%
%      DMR_FINDER('Property','Value',...) creates a new DMR_FINDER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before DMR_Finder_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to DMR_Finder_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help DMR_Finder

% Last Modified by GUIDE v2.5 25-Aug-2020 13:20:33

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @DMR_Finder_OpeningFcn, ...
                   'gui_OutputFcn',  @DMR_Finder_OutputFcn, ...
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



function NumOfTreatmentSamples_Callback(hObject, eventdata, handles)
% hObject    handle to NumOfTreatmentSamples (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NumOfTreatmentSamples as text
%        str2double(get(hObject,'String')) returns contents of NumOfTreatmentSamples as a double


% --- Executes during object creation, after setting all properties.
function NumOfTreatmentSamples_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NumOfTreatmentSamples (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit Controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUiControlBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function NumOfControlSamples_Callback(hObject, eventdata, handles)
% hObject    handle to NumOfControlSamples (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NumOfControlSamples as text
%        str2double(get(hObject,'String')) returns contents of NumOfControlSamples as a double
NumOfControlSamples=get(handles.NumOfControlSamples,'string');
if isnan(str2double(NumOfControlSamples))==1
    set(handles.NumOfControlSamples,'string','Please Enter Number Of Control Samples');
end

% --- Executes during object creation, after setting all properties.
function NumOfControlSamples_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NumOfControlSamples (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit Controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUiControlBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function NumberOfTreatmentSamples_Callback(hObject, eventdata, handles)
% hObject    handle to NumberOfTreatmentSamples (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NumberOfTreatmentSamples as text
%        str2double(get(hObject,'String')) returns contents of NumberOfTreatmentSamples as a double
NumOfTreatmentSamples=get(handles.NumberOfTreatmentSamples,'string');
if isnan(str2double(NumOfTreatmentSamples))==1
    set(handles.NumberOfTreatmentSamples,'string','Please Enter Number Of Treatment Samples');
end

% --- Executes during object creation, after setting all properties.
function NumberOfTreatmentSamples_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NumberOfTreatmentSamples (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit Controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUiControlBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes just before DMR_Finder is made visible.
function DMR_Finder_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to DMR_Finder (see VARARGIN)

% Choose default command line output for DMR_Finder
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes DMR_Finder wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = DMR_Finder_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if exist('Control')
     A = dir( 'Control' );
    for k = 1:length(A)
        if k>2
            n2=k-2;
        str=strcat('Control/Sample',num2str(n2));
            if exist(str)
                B=dir(str);
               for x = 1:length(B)
                   if x>2
                       n1=x-2;
                   str1=strcat(str,'/Chromosome',num2str(n1));
                   if exist(str1)
                       C=dir(str1);
                       for y=1:length(C)
                            if y>2
                                delete([ str1 '/' C(y).name]);
                            end
                       end
                   end
                   rmdir(str1);
                   end
               end
               rmdir(str);
            end
        end
    end
    rmdir('Control')
end
if exist('Treatment')
     A = dir( 'Treatment' );
    for k = 1:length(A)
        if k>2
            n2=k-2;
        str=strcat('Treatment/Sample',num2str(n2));
            if exist(str)
                B=dir(str);
               for x = 1:length(B)
                   if x>2
                       n1=x-2;
                   str1=strcat(str,'/Chromosome',num2str(n1));
                   if exist(str1)
                       C=dir(str1);
                       for y=1:length(C)
                            if y>2
                                delete([ str1 '/' C(y).name]);
                            end
                       end
                   end
                   rmdir(str1);
                   end
               end
               rmdir(str);
            end
        end
    end
    rmdir('Treatment')
end  

if exist('models')
     A = dir( 'models' );
    for k = 1:length(A)
        if k>2
            n2=k-2;
        str=strcat('models/model',num2str(n2),'.txt');
        delete(str);
        end
    end
    rmdir('models')
end



mkdir('models')
mkdir('DMRs');
mkdir('ModelCells');
NumOfTreatmentSamples=get(handles.NumberOfTreatmentSamples,'string');
NumOfControlSamples=get(handles.NumOfControlSamples,'string');
NumOfChromosoms=get(handles.NumOfChromosoms,'string');
for i=1:str2double(NumOfControlSamples)
    str1=strcat('Sample',num2str(i));
     for j=1:str2double(NumOfChromosoms)
        str2=strcat('Chromosome',num2str(j));
        str=strcat(str1,'/',str2);
        mkdir('Control/',str);
     end
end
for i=1:str2double(NumOfTreatmentSamples)
    str1=strcat('Sample',num2str(i));
    for j=1:str2double(NumOfChromosoms)
        str2=strcat('Chromosome',num2str(j));
        str=strcat(str1,'/',str2);
        mkdir('Treatment/',str);
    end
end
 set(handles.pushbutton1,'enable','off');
 set(handles.text4,'visible','on');


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
NumOfTreatmentSamples=get(handles.NumberOfTreatmentSamples,'string');
NumOfControlSamples=get(handles.NumOfControlSamples,'string');
NumOfChromosoms=get(handles.NumOfChromosoms,'string');
set(handles.text4,'string','Busy...');
RenameData('Control');
RenameData('Treatment');
main(NumOfTreatmentSamples,NumOfControlSamples,NumOfChromosoms);
set(handles.text4,'string','Done! DMRs Are In DMRs Folders');


function NumOfChromosoms_Callback(hObject, eventdata, handles)
% hObject    handle to NumOfChromosoms (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NumOfChromosoms as text
%        str2double(get(hObject,'String')) returns contents of NumOfChromosoms as a double


% --- Executes during object creation, after setting all properties.
function NumOfChromosoms_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NumOfChromosoms (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit Controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUiControlBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
