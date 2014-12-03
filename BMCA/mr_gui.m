function Data = mr_gui()
% mr_gui is an example for building guis without matlab guide.
% additionally storing all variables in a datastructur embedded in userdata of the main figure.
% the example shows a figure with 2 pushbuttons and 1 axes:
%   by pushbutton 1 axis x-limit can be changed to 2
%   by pushbutton 2 axis x-limit can be reset to 1
    
    % creation and initialization part
    Data.tag = 'mr_gui';
    ss = get(0,'ScreenSize');
    Data.hfm = figure('Position',[ss(3)/2 ss(4)/2 ss(3)/2 ss(4)/2],'Name','Main Figure'); % ...creating main figure
    p = get(Data.hfm,'Position');
    Data.hpp1 = uicontrol('Style','listbox','String','PP1','Position',[0 p(4)-30 70 30],... %...absolute position to the figures client
         'Callback', {@pp1,Data.hfm}); %...call function pp1 and passing parameter Data.f by pushing this button
    Data.hpp2 = uicontrol('Style','pushbutton','String','PP2','Position',[p(3)-70 p(4)-30 70 30],... %...absolute position to the figures client
         'Callback', {@pp2,Data.hfm}); %...call function pp2 and passing parameter Data.f by pushing this button
    Data.ha1 = axes('Position',[0.2 0.2 0.6 0.6]); grid on %...relative position to the figures client and turn on grid lines
   
    % add other objects to the figure (timer, uicontrols, etc. - see matlab help)
    % ... e.g.: Data.ht1 = timer('TimerFcn',{@t1,Data.hfm},'Period',0.05,'ExecutionMode','fixedRate');
    
    % end of creation and initialization part
    set(Data.hfm,'UserData',Data); %...write initial data to main figure userdata
%end main function

%==========
function pp1(obj,event,h) % ...called by pushbutton 1
    Data = get(h,'UserData'); %...read actual data from main figure userdata
    
    % üplace your code here...
    % example: set XLim of axis ha1
    set(Data.ha1,'XLim',[0 2])
    %...
    [fn,pn] = uigetfile();
    file = [pn fn];
    Data.daten = load(file);
    set(h,'UserData',Data); %...write actual data to main figure userdata
%end pp1 function

%==========
function pp2(obj,event,h) % ...called by pushbutton 2
    Data = get(h,'UserData'); %...read actual data from main figure userdata
    
    % üplace your code here...
    % reset XLim of axis ha1
    set(Data.ha1,'XLim',[0 1])
    %...
    
    set(h,'UserData',Data); %...write actual data to main figure userdata
%end pp2 function