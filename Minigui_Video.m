function varargout = Minigui_Video(varargin)
% MINIGUI_VIDEO MATLAB code for Minigui_Video.fig
%      MINIGUI_VIDEO, by itself, creates a new MINIGUI_VIDEO or raises the existing
%      singleton*.
%
%      H = MINIGUI_VIDEO returns the handle to a new MINIGUI_VIDEO or the handle to
%      the existing singleton*.
%
%      MINIGUI_VIDEO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MINIGUI_VIDEO.M with the given input arguments.
%
%      MINIGUI_VIDEO('Property','Value',...) creates a new MINIGUI_VIDEO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Minigui_Video_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Minigui_Video_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Minigui_Video

% Last Modified by GUIDE v2.5 23-May-2013 09:26:12

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Minigui_Video_OpeningFcn, ...
                   'gui_OutputFcn',  @Minigui_Video_OutputFcn, ...
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


function Minigui_Video_OpeningFcn(hObject, eventdata, handles, varargin)
handleResults=getappdata(0,'handleResults'); 
ResultsSim=getappdata(handleResults,'ResultsSim');
CumlDistance=ResultsSim.CumlDistance;
time=ResultsSim.time;%seconds
set(handles.Fcell_edit,'String',length(CumlDistance))
set(handles.Frames_edit,'String',10)
%%
NoFrames=str2double(get(handles.Frames_edit,'String'));
Time_step_frames=time(end)/3600/NoFrames;%hours
set(handles.Display_text,'String',['The video will display one frame every ',sprintf('%.1f',Time_step_frames),' hour(s)'])
handles.output = hObject;
guidata(hObject, handles);

function varargout = Minigui_Video_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

function Fcell_edit_Callback(hObject, eventdata, handles)
function Fcell_edit_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Frames_edit_Callback(hObject, eventdata, handles)
update(hObject, eventdata, handles);
function Frames_edit_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function video(~, ~, handles)
%% Load data
handleResults=getappdata(0,'handleResults'); 
ResultsSim=getappdata(handleResults,'ResultsSim');
X=ResultsSim.X;
Z=ResultsSim.Z;
Y=ResultsSim.Y;
CumlDistance=ResultsSim.CumlDistance;
Depth=ResultsSim.Depth;
Width=ResultsSim.Width;
VX=ResultsSim.VX;
time=ResultsSim.time;%seconds
D=ResultsSim.D;
Fcell=str2double(get(handles.Fcell_edit,'String'));
%%
NoFrames=str2double(get(handles.Frames_edit,'String'));
Time_step_frames=time(end)/3600/NoFrames;%hours
set(handles.Display_text,'String',['The video will display one frame every ',sprintf('%.1f',Time_step_frames),' hour(s)'])
%%
opengl('software')
%hf=figure('color','w','Position',[700 50 700 500]);
hf=figure('color','w');
subaxis(1,1,1,'MR',0.035,'ML',0.18,'MB',0,'MT',0);
axis off
font = 'Helvetica'; fontsize = 12;
%% Drawing cells
%% cubes
colormap([0.6 1 1;0.57 0.97 1;0.54 0.94 1;0.51 0.9 1;0.49 0.89 1;0.46 0.88 1;0.43 0.83 1;0.4 0.8 1;0.39 0.79 1;0.375 0.775000035762787 1;0.362500011920929 0.762499988079071 1;0.349999994039536 0.75 1;0.337500005960464 0.737500011920929 1;0.325000017881393 0.725000023841858 1;0.3125 0.712500035762787 1;0.300000011920929 0.700000047683716 1;0.287499994039536 0.6875 1;0.275000005960464 0.675000011920929 1;0.262500017881393 0.662500023841858 1;0.25 0.650000035762787 1;0.237499997019768 0.637500047683716 1;0.225000008940697 0.625 1;0.212500005960464 0.612500011920929 1;0.200000002980232 0.600000023841858 1;0.1875 0.587500035762787 1;0.174999997019768 0.575000047683716 1;0.162500008940697 0.5625 1;0.150000005960464 0.550000011920929 1;0.137500002980232 0.537500023841858 1;0.125 0.525000035762787 1;0.112500004470348 0.512499988079071 1;0.100000001490116 0.5 1;0.0874999985098839 0.487500011920929 1;0.0750000029802322 0.475000023841858 1;0.0625 0.462500005960464 1;0.0500000007450581 0.450000017881393 1;0.0375000014901161 0.4375 1;0.025000000372529 0.425000011920929 1;0.0125000001862645 0.412499994039536 1;0 0.400000005960464 1;0 0.387500017881393 0.987500011920929;0 0.375 0.975000023841858;0 0.362500011920929 0.962499976158142;0 0.349999994039536 0.949999988079071;0 0.337500005960464 0.9375;0 0.325000017881393 0.925000011920929;0 0.3125 0.912500023841858;0 0.300000011920929 0.899999976158142;0 0.287499994039536 0.887499988079071;0 0.275000005960464 0.875;0 0.262500017881393 0.862500011920929;0 0.25 0.850000023841858;0 0.237499997019768 0.837500035762787;0 0.225000008940697 0.824999988079071;0 0.212500005960464 0.8125;0 0.200000002980232 0.800000011920929;0 0.174999997019768 0.775000035762787;0 0.150000005960464 0.75;0 0.125 0.72;0 0.1 0.700000047683716;0 0.075 0.675;0 0.05 0.65;0 0.025 0.625;0 0 0.6]);
xo=0;
%% Cells to plot
for k=1:Fcell%length(CumlDistance)%Fcell
    if k>1
        xo=CumlDistance(k-1);
    end
    x(:,k)=[xo CumlDistance(k) CumlDistance(k) xo];
    y(:,k)=[Width(k) Width(k) Width(k) Width(k)];
    z(:,k)=[-Depth(k) -Depth(k) 0 0 ]; %[0 0 Depth(k) Depth(k)];
    colorp(:,k)=[VX(k) VX(k) VX(k) VX(k)];%%VX=Vmag before
    yb(:,k)=[0 0 Width(k) Width(k)];
    yf(:,k)=[0 0 0 0];
    zb(:,k)=[-Depth(k) -Depth(k) -Depth(k) -Depth(k)];%[0 0 0 0];
    zt(:,k)=[0 0 0 0];%[Depth(k) Depth(k) Depth(k) Depth(k)];
end
%%
counter=1;
Dt=time(2)-time(1);%sec
%%  Plot
for t=0:round(Time_step_frames*3600):length(time)*Dt
    if round(t/Dt+1)<=length(time)
    scatter3(X(round(t/Dt+1),:)/1000,Y(round(t/Dt+1),:),Z(round(t/Dt+1),:),1.3*20,'y','MarkerFaceColor','flat','MarkerEdgeColor',[0 0 0]);
    colormap([0.6 1 1;0.57 0.97 1;0.54 0.94 1;0.51 0.9 1;0.49 0.89 1;0.46 0.88 1;0.43 0.83 1;0.4 0.8 1;0.39 0.79 1;0.375 0.775000035762787 1;0.362500011920929 0.762499988079071 1;0.349999994039536 0.75 1;0.337500005960464 0.737500011920929 1;0.325000017881393 0.725000023841858 1;0.3125 0.712500035762787 1;0.300000011920929 0.700000047683716 1;0.287499994039536 0.6875 1;0.275000005960464 0.675000011920929 1;0.262500017881393 0.662500023841858 1;0.25 0.650000035762787 1;0.237499997019768 0.637500047683716 1;0.225000008940697 0.625 1;0.212500005960464 0.612500011920929 1;0.200000002980232 0.600000023841858 1;0.1875 0.587500035762787 1;0.174999997019768 0.575000047683716 1;0.162500008940697 0.5625 1;0.150000005960464 0.550000011920929 1;0.137500002980232 0.537500023841858 1;0.125 0.525000035762787 1;0.112500004470348 0.512499988079071 1;0.100000001490116 0.5 1;0.0874999985098839 0.487500011920929 1;0.0750000029802322 0.475000023841858 1;0.0625 0.462500005960464 1;0.0500000007450581 0.450000017881393 1;0.0375000014901161 0.4375 1;0.025000000372529 0.425000011920929 1;0.0125000001862645 0.412499994039536 1;0 0.400000005960464 1;0 0.387500017881393 0.987500011920929;0 0.375 0.975000023841858;0 0.362500011920929 0.962499976158142;0 0.349999994039536 0.949999988079071;0 0.337500005960464 0.9375;0 0.325000017881393 0.925000011920929;0 0.3125 0.912500023841858;0 0.300000011920929 0.899999976158142;0 0.287499994039536 0.887499988079071;0 0.275000005960464 0.875;0 0.262500017881393 0.862500011920929;0 0.25 0.850000023841858;0 0.237499997019768 0.837500035762787;0 0.225000008940697 0.824999988079071;0 0.212500005960464 0.8125;0 0.200000002980232 0.800000011920929;0 0.174999997019768 0.775000035762787;0 0.150000005960464 0.75;0 0.125 0.72;0 0.1 0.700000047683716;0 0.075 0.675;0 0.05 0.65;0 0.025 0.625;0 0 0.6]);
    %% Drawing cubes
    patch(x,y,z,colorp) %Back face
    hold on
    patch(x,yb,zb,colorp)%Bottom face
    patch(x,yb,zt,'w','FaceAlpha',0.02)%Top face
    patch(x,yf,z,'w','FaceAlpha',0.02) %Front face
    bar=colorbar('CLim',[0 1.2]);
    colorbar('XTick',[0:0.2:1.2],'YTickLabel',[0:0.2:1.2])
    bar=colorbar('location','NorthOutside');
    set(get(bar,'xlabel'),'String', 'Cell Velocity [m/s]');clear bar;%Velocity=Vmag
    bar=findobj(gcf,'Tag','Colorbar');
    set(bar,'Position',[0.73 0.03 0.25 0.016]);
    hold off
    title(['Time=',num2str(round((time(round(t/Dt+1))/3600)*10)/10),' hours','   ','Egg diameter=',num2str(round(D(round(t/Dt+1))*10)/10),' mm'],'FontSize',fontsize)
    %% 
    xlim([0 CumlDistance(Fcell)]); 
    ylim([0 max(Width(1:Fcell))]);
    zlim([-max(Depth(1:Fcell)) 0]);
    %% Aspect
    %   zamp=0.07;%0.07
    %   yamp=3;%3
    %   daspect([0.1 yamp zamp])
    %   daspect([1 450 3000])
    daspect([1 100 1])
    grid off
    box on
    view([-13 21])
    %%
    xlabel('Distance in X(km)','FontSize',fontsize);
    ylabel('Width(m)','FontSize',fontsize);
    zlabel('Water depth(m)','FontSize',fontsize);
    set(gca,'FontSize',fontsize)
    %%
    M(counter)=getframe(gcf);
    counter=counter+1;
    end
end  

[h, w, p] = size(M(1).cdata);
% resize figure based on frame's w x h, and place at (150, 150)
%set(hf,'Position', [150 150 w h]);
set(hf,'Position', [150 500 w h]);
axis off
% Place frames at bottom left
%movie(hf,M,1,1,[0 0 w h]);

%% Save the movie
%[file,path] = uiputfile('*.avi','Save the movie as');
%strFilename=fullfile(path,file);
hFluEggGui=getappdata(0,'hFluEggGui');
Folderpath=getappdata(hFluEggGui, 'Folderpath');
movie2avi(M,[Folderpath,'animation' '.avi'], 'compression', 'None','fps',2);%Saving the movie

function update(~, ~, handles)
handleResults=getappdata(0,'handleResults'); 
ResultsSim=getappdata(handleResults,'ResultsSim');
time=ResultsSim.time;%seconds
NoFrames=str2double(get(handles.Frames_edit,'String'));
Time_step_frames=time(end)/3600/NoFrames;%hours
set(handles.Display_text,'String',['The video will display one frame every ',sprintf('%.1f',Time_step_frames),' hour(s)'])

% --- Executes on button press in Video_button.
function Video_button_Callback(hObject, eventdata, handles)
 video(hObject, eventdata, handles);
