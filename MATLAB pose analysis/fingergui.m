function varargout = fingergui(varargin)





% FINGERGUI MATLAB code for fingergui.fig
%      FINGERGUI, by itself, creates a new FINGERGUI or raises the existing
%      singleton*.
%
%      H = FINGERGUI returns the handle to a new FINGERGUI or the handle to
%      the existing singleton*.
%
%      FINGERGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FINGERGUI.M with the given input arguments.
%
%      FINGERGUI('Property','Value',...) creates a new FINGERGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before fingergui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to fingergui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help fingergui

% Last Modified by GUIDE v2.5 06-Nov-2013 15:02:38

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @fingergui_OpeningFcn, ...
                   'gui_OutputFcn',  @fingergui_OutputFcn, ...
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


% --- Executes just before fingergui is made visible.
function fingergui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to fingergui (see VARARGIN)

%handles.LEN = 14;
%handles.HEIGHT = 2;
%handles.WIDTH = 2;
%handles.N = 100;

handles.fingers = gethand();
handles.topIn = 0;
handles.bottomIn = 0;

redraw(handles);

%pose = getpose(0,handles.N);
%fingerdraw(pose,handles.LEN,handles.HEIGHT);


%axis([0,handles.LEN,-handles.LEN+handles.HEIGHT,handles.HEIGHT]);
%axis square
%axis equal
view(3)
set(gca,'dataaspectratio',[1 1 1])


% Choose default command line output for fingergui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes fingergui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = fingergui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


handles=guidata(hObject);

axis manual
cla;
hold on

axes(handles.axes1);

handles.topIn = get(hObject,'Max')-get(hObject,'Value');
redraw(handles);

%pose = getpose(get(hObject,'Max')-get(hObject,'Value'),handles.N);
%fingerdraw(pose,handles.LEN,handles.HEIGHT);

hold off
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

handles.hListener1 = handle.listener(hObject,'ActionEvent',@slider1_Callback);
setappdata(hObject,'sliderListener',handles.hListener1);


% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1


% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

handles=guidata(hObject);

axis manual
cla;
hold on
axes(handles.axes1);

handles.bottomIn = get(hObject,'Max')-get(hObject,'Value');
redraw(handles);

%pose = getpose(get(hObject,'Max')-get(hObject,'Value'),handles.N);
%fingerdraw(pose,handles.LEN,handles.HEIGHT);

hold off
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

handles.hListener2 = handle.listener(hObject,'ActionEvent',@slider2_Callback);
setappdata(hObject,'sliderListener',handles.hListener2);

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

%--- general redrawing function
function redraw(handles)

for i=1:length(handles.fingers)
    pose = handles.fingers(i).posefun([handles.topIn,handles.bottomIn]);
    fingerdraw(handles.fingers(i),pose);
end

