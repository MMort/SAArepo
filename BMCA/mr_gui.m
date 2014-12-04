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
    Data.hpp2 = uicontrol('Style','pushbutton','String','Load-EMG','Position',[15 512 70 30],... %...absolute position to the figures client
         'Callback', {@pp2,Data.hfm}); %...call function pp2 and passing parameter Data.f by pushing this button
    Data.ha1 = axes('Position',[0.2 0.2 0.6 0.6]); grid on %...relative position to the figures client and turn on grid lines
   
    % add other objects to the figure (timer, uicontrols, etc. - see matlab help)
    % ... e.g.: Data.ht1 = timer('TimerFcn',{@t1,Data.hfm},'Period',0.05,'ExecutionMode','fixedRate');
    
    % end of creation and initialization part
    set(Data.hfm,'UserData',Data); %...write initial data to main figure userdata
%end main function

%==========
function pp1(obj,event,h) % ...called by pushbutton 1
    Data =h;
    index_selected = get(obj,'Value');
    list = get(obj,'String');
    item_selected = list{index_selected}; 
    subplot(3,1,2)
    plot(Data.daten.data(index_selected+1,:));
    l = Latenz (Data.daten.data(1,:), Data.daten.data(index_selected+1,:));
    %subplot(3,1,3)
    %tab1 = uitable('Parent', f);
    tab1 = uitable('Position', [430 15 182 181]);
    complexData1(1,1) = {'Latenz'};
    complexData1(1,2)=  {l};
    set(tab1, 'Data', complexData1);
    set(tab1, 'ColumnName', {'Value-Name', 'Value'}); 
%end pp1 function

function etb(obj,event,h) % ...called by edit text
    h.input = get(obj,'String');
    h.hpp1 = uicontrol('Style','listbox','String',{'Touch', 'Press', 'Tap', 'Gon1', 'Gon2', 'RSCM', 'RTrBr', 'RBiBr', 'RWe', 'RWf', 'RInt', 'RRect', 'RPsp', 'RQ', 'RAdd', 'RH', 'RTa', 'RTs', 'LSCM', 'LTiBr', 'LBiBr', 'LWe', 'LWf', 'LInt', 'LRect', 'LPsp', 'LQ', 'LAdd', 'LH', 'LTa', 'LTs' },'Position',[17 214 70 280],... %...absolute position to the figures client
         'Callback', {@pp1,h}); %...call function pp1 and passing parameter Data.f by pushing this button
    
    h=Data;
    %set(h,'UserData',Data);
%end pp1 function

%==========
function pp2(obj,event,h) % ...called by pushbutton 2
    Data = get(h,'UserData'); %...read actual data from main figure userdata
    [fn,pn] = uigetfile();
    file = [pn fn];
    x = load(file);
    
    Data.daten = x.phoenix;
    p = get(Data.hfm,'Position');

    subplot(3,1,1)
    grid on
    plot(x.phoenix.data(1,:));
    Data.hpp1 = uicontrol('Style','listbox','String',{'Touch', 'Press', 'Tap', 'Gon1', 'Gon2', 'RSCM', 'RTrBr', 'RBiBr', 'RWe', 'RWf', 'RInt', 'RRect', 'RPsp', 'RQ', 'RAdd', 'RH', 'RTa', 'RTs', 'LSCM', 'LTiBr', 'LBiBr', 'LWe', 'LWf', 'LInt', 'LRect', 'LPsp', 'LQ', 'LAdd', 'LH', 'LTa', 'LTs' },'Position',[17 214 70 280],... %...absolute position to the figures client
         'Callback', {@pp1,Data}); %...call function pp1 and passing parameter Data.f by pushing this button
    
    Data.tb = uicontrol('Style', 'edit',  'Position', [330 171 60 20],'Callback', {@etb, Data});
    Data.text = uicontrol('Style', 'text', 'String', 'Zeitpunkt in Sekunden:','Position',[191 174 130 15]);

    
    set(h,'UserData',Data); %...write actual data to main figure userdata
%end pp2 function