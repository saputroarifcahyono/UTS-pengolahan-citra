function varargout = UTS(varargin)
% UTS MATLAB code for UTS.fig
%      UTS, by itself, creates a new UTS or raises the existing
%      singleton*.
%
%      H = UTS returns the handle to a new UTS or the handle to
%      the existing singleton*.
%
%      UTS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in UTS.M with the given input arguments.
%
%      UTS('Property','Value',...) creates a new UTS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before UTS_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to UTS_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help UTS

% Last Modified by GUIDE v2.5 05-May-2021 09:43:03

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @UTS_OpeningFcn, ...
                   'gui_OutputFcn',  @UTS_OutputFcn, ...
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


% --- Executes just before UTS is made visible.
function UTS_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to UTS (see VARARGIN)

% Choose default command line output for UTS
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes UTS wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = UTS_OutputFcn(hObject, eventdata, handles) 
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
[filename,pathname] = uigetfile('*.jpg;*.jpeg;*.png;.*tif');
 
try
    Img = imread(fullfile(pathname,filename));
    [~,~,m] = size(Img);
    if m == 3
        axes(handles.axes1)
        imshow(Img)
        handles.Img = Img;
        guidata(hObject, handles)
    end
catch
    msgbox('Please insert RGB Image')
end

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
popup1 = get(handles.popupmenu1,'value')
popup2 = get(handles.popupmenu2,'value')
popup3 = get(handles.popupmenu3,'value')

try
    if (popup1 == 1)                        %Normal
        if (popup2 == 1)                    %Histogram1
            if (popup3 == 1)                %RGB
                Img = handles.Img;
                axes(handles.axes1)
                cla('reset')
                imshow(Img)

                R = Img(:,:,1);
                G = Img(:,:,2);
                B = Img(:,:,3);

                axes(handles.axes2)
                cla('reset')
                h = histogram(R(:),256);
                h.FaceColor = [1 0 0];
                h.EdgeColor = 'r';
                hold on

                h = histogram(G(:),256);
                h.FaceColor = [0 1 0];
                h.EdgeColor = 'g';

                h = histogram(B(:),256);
                h.FaceColor = [0 0 1];
                h.EdgeColor = 'b';
                grid on
                set(gca,'Xlim',[0 255])
                hold off
            elseif (popup3 == 2)            %Grayscale
                Img = handles.Img;
                Gray = rgb2gray(Img);

                axes(handles.axes1)
                cla('reset')
                imshow(Gray)

                axes(handles.axes2)
                cla('reset')
                h = histogram(Gray(:),256);
                h.FaceColor = [0.5 0.5 0.5];
                h.EdgeColor = [0.5 0.5 0.5];
                set(gca,'Xlim',[0 255])
                grid on

            else (popup3 == 3)              %Binary
                Gray = handles.Img;
                bw = im2bw(Gray,graythresh(Gray));

                axes(handles.axes1)
                cla('reset')
                imshow(bw)

                axes(handles.axes2)
                h = histogram(double(bw(:)),2);
                h.FaceColor = [0 0 0];
                h.EdgeColor = [0 0 0];
                set(gca,'Xlim',[0 1])
                grid on
            end
        else (popup2 == 2)                  %Histogram2
            if (popup3 == 1)                %RGB
                Img = handles.Img;
                axes(handles.axes1)
                cla('reset')
                imshow(Img)

                axes(handles.axes2)
                cla('reset')
                imhist(Img);

            elseif (popup3 == 2)            %Grayscale
                Img = handles.Img;
                Gray = rgb2gray(Img);

                axes(handles.axes1)
                cla('reset')
                imshow(Gray)

                axes(handles.axes2)
                cla('reset')
                imhist(Gray);

            else (popup3 == 3)              %Binary
                Gray = handles.Img;
                bw = im2bw(Gray,graythresh(Gray));

                axes(handles.axes2)
                cla('reset')
                imhist(bw);
            end
        end
    else (popup1 == 2)                      %Complement
        Img = handles.Img;
        Img_Comp = imcomplement(Img);
        if (popup2 == 1)                    %Histogram1
            if (popup3 == 1)                %RGB
                axes(handles.axes1)
                cla('reset')
                imshow(Img_Comp)

                R = Img_Comp(:,:,1);
                G = Img_Comp(:,:,2);
                B = Img_Comp(:,:,3);

                axes(handles.axes2)
                cla('reset')
                h = histogram(R(:),256);
                h.FaceColor = [1 0 0];
                h.EdgeColor = 'r';
                hold on

                h = histogram(G(:),256);
                h.FaceColor = [0 1 0];
                h.EdgeColor = 'g';

                h = histogram(B(:),256);
                h.FaceColor = [0 0 1];
                h.EdgeColor = 'b';
                set(gca,'Xlim',[0 255])
                grid on
                hold off
            elseif (popup3 == 2)            %Grayscale
                Gray_Comp = rgb2gray(Img_Comp);
                axes(handles.axes1)
                cla('reset')
                imshow(Gray_Comp)

                axes(handles.axes2)
                cla('reset')
                h = histogram(Gray_Comp(:),256);
                h.FaceColor = [0.5 0.5 0.5];
                h.EdgeColor = [0.5 0.5 0.5];
                set(gca,'Xlim',[0 255])
                grid on
            else (popup3 == 3)              %Binary
                Gray_Comp = handles.Img;
                bw_Comp = im2bw(Gray_Comp,graythresh(Gray_Comp));
                axes(handles.axes1)
                cla('reset')
                imshow(bw_Comp)

                axes(handles.axes2)
                h = histogram(double(bw_Comp(:)),2);
                h.FaceColor = [0 0 0];
                h.EdgeColor = [0 0 0];
                set(gca,'Xlim',[0 1])
                grid on
            end
        else (popup2 == 2)                  %Histogram2
            if (popup3 == 1)                %RGB
                axes(handles.axes1)
                cla('reset')
                imshow(Img_Comp)

                axes(handles.axes2)
                cla('reset')
                imhist(Img_Comp);

            elseif (popup3 == 2)            %Grayscale
                Gray_Comp = rgb2gray(Img_Comp);
                axes(handles.axes1)
                cla('reset')
                imshow(Gray_Comp)

                axes(handles.axes2)
                cla('reset')
                imhist(Gray_Comp);

            else (popup3 == 3)              %Binary
                Gray_Comp = handles.Img;
                bw_Comp = im2bw(Gray_Comp,graythresh(Gray_Comp));
                axes(handles.axes1)
                cla('reset')
                imshow(bw_Comp)

                axes(handles.axes2)
                cla('reset')
                imhist(bw_Comp);

            end
        end
    end
catch
    msgbox('Please insert RGB Image')
end
