function Data = mr_gui()
  
    % creation and initialization part
    Data.tag = 'mr_gui';
    ss = get(0,'ScreenSize');
    Data.hfm = figure('Position',[1 1 1480 581],'Name','Main Figure'); % ...creating main figure
    p = get(Data.hfm,'Position');
    Data.ah2 = axes('units', 'normalized', 'position', [0.1 0.41 0.693 0.216])
Data.ah3 = axes('units', 'normalized', 'position', [0.1 0.09 0.693 0.216])
    Data.hpp2 = uicontrol('Style','pushbutton','String','Load-EMG','Position',[15 512 70 30],... %...absolute position to the figures client
         'Callback', {@pp2,Data.hfm}); %...call function pp2 and passing parameter Data.f by pushing this button

    set(Data.hfm,'UserData',Data); %...write initial data to main figure userdata
%end main function

%==========
function pp1(obj,event,h) % ...called by pushbutton 1
    Data =h;
    index_selected = get(obj,'Value');
    list = get(obj,'String');
    item_selected = list{index_selected}; 
    [Messbeginn Messende] = Messzeiten( Data.daten.data(1,:));
    
    plot(Data.ah2, Data.daten.data(index_selected+1,:) );
    [latenz1, latenz2, entspannungslatenz] = Latenz (Data.daten.data(index_selected+1,:),Messbeginn, Messende);
    [RMS, peak_row, peak_col, Max_p_y,Max_p_x, Median_p, ben_y]=Amplitude_Frequency_analysis(Data.daten.data(index_selected+1,:), Messbeginn, Messende, Data.input1);

    tab1 = uitable('Position', [1202 212 255 145]);
    complexData1(:,1) = [{'RMS'} {'Max. Amplitude, x [s]'} {'Max. Amplitude, y [µV]'} {'FFT Max Amplitude, y'} {'FFT Max Amplitude, x [Hz]'} {'FFT Median'} {'Amplitude zu best. ZP'} {'Latenz von Start'} {'Latenz von Event'} {'Entspannungslatenz'}];
    complexData1(:,2)=  [{RMS} {peak_row/1024} {peak_col} {Max_p_y} {Max_p_x} {Median_p} {ben_y} {latenz1} {latenz2} {entspannungslatenz}];
    set(tab1, 'Data', complexData1);
    set(tab1, 'ColumnName', {'Value-Name', 'Value'}); 
    %set(h,'UserData',Data);
    h=Data;
%end pp1 function

function pp3(obj,event,h) % ...called by pushbutton 1
    Data =h;
    index_selected = get(obj,'Value');
    list = get(obj,'String');
    item_selected = list{index_selected}; 
    
    
    plot(Data.ah3, Data.daten.data(index_selected+1,:));
    [Messbeginn Messende] = Messzeiten( Data.daten.data(1,:));
    [latenz1, latenz2, entspannungslatenz] = Latenz (Data.daten.data(index_selected+1,:),Messbeginn, Messende);
    [RMS, peak_row, peak_col, Max_p_y,Max_p_x, Median_p, ben_y]=Amplitude_Frequency_analysis(Data.daten.data(index_selected+1,:), Messbeginn, Messende, Data.input2);

    tab2 = uitable('Position', [1211 20 255 145]);
    complexData1(:,1) = [{'RMS'} {'Max. Amplitude, x [s]'} {'Max. Amplitude, y [µV]'} {'FFT Max Amplitude, y'} {'FFT Max Amplitude, x [Hz]'} {'FFT Median'} {'Amplitude zu best. ZP'} {'Latenz von Start'} {'Latenz von Event'} {'Entspannungslatenz'}];
    complexData1(:,2)=  [{RMS} {peak_row/1024} {peak_col} {Max_p_y} {Max_p_x} {Median_p} {ben_y} {latenz1} {latenz2} {entspannungslatenz}];
    set(tab2, 'Data', complexData1);
    set(tab2, 'ColumnName', {'Value-Name', 'Value'}); 
    h=Data;
    %set(h,'UserData',Data);
%end pp3 function

function etb1(obj,event,h) % ...called by edit text
    h.input1 = get(obj,'String');
    h.hpp1 = uicontrol('Style','listbox','String',{'Touch', 'Press', 'Tap', 'Gon1', 'Gon2', 'RSCM', 'RTrBr', 'RBiBr', 'RWe', 'RWf', 'RInt', 'RRect', 'RPsp', 'RQ', 'RAdd', 'RH', 'RTa', 'RTs', 'LSCM', 'LTiBr', 'LBiBr', 'LWe', 'LWf', 'LInt', 'LRect', 'LPsp', 'LQ', 'LAdd', 'LH', 'LTa', 'LTs' },'Position',[18 231 72 131],... %...absolute position to the figures client
         'Callback', {@pp1,h}); 
    %set(h,'UserData',Data);
%end pp1 function

function etb2(obj,event,h) % ...called by edit text
    h.input2 = get(obj,'String');
    h.hpp3 = uicontrol('Style','listbox','String',{'Touch', 'Press', 'Tap', 'Gon1', 'Gon2', 'RSCM', 'RTrBr', 'RBiBr', 'RWe', 'RWf', 'RInt', 'RRect', 'RPsp', 'RQ', 'RAdd', 'RH', 'RTa', 'RTs', 'LSCM', 'LTiBr', 'LBiBr', 'LWe', 'LWf', 'LInt', 'LRect', 'LPsp', 'LQ', 'LAdd', 'LH', 'LTa', 'LTs' },'Position',[19 47 72 144],... %...absolute position to the figures client
         'Callback', {@pp3,h}); 
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

    ah1 = axes('units', 'normalized', 'position', [0.1 0.7 0.693 0.216])
    plot(ah1, x.phoenix.data(1,:));
    
    Data.input1=0;
    Data.input2=0;
    Data.tb1 = uicontrol('Style', 'edit',  'Position', [1346 366 60 20],'Callback', {@etb1, Data});
    Data.text1 = uicontrol('Style', 'text', 'String', 'Zeitpunkt in Abtastpunkt:','Position',[1203 369 130 15]);
    Data.tb2 = uicontrol('Style', 'edit',  'Position', [1351 177 60 20],'Callback', {@etb2, Data});
    Data.text2 = uicontrol('Style', 'text', 'String', 'Zeitpunkt in Abtastpunkt:','Position',[1204 178 130 15]);

    
    Data.hpp1 = uicontrol('Style','listbox','String',{'Touch', 'Press', 'Tap', 'Gon1', 'Gon2', 'RSCM', 'RTrBr', 'RBiBr', 'RWe', 'RWf', 'RInt', 'RRect', 'RPsp', 'RQ', 'RAdd', 'RH', 'RTa', 'RTs', 'LSCM', 'LTiBr', 'LBiBr', 'LWe', 'LWf', 'LInt', 'LRect', 'LPsp', 'LQ', 'LAdd', 'LH', 'LTa', 'LTs' },'Position',[18 231 72 131],... %...absolute position to the figures client
         'Callback', {@pp1,Data}); %...call function pp1 and passing parameter Data.f by pushing this button
    
     Data.hpp3 = uicontrol('Style','listbox','String',{'Touch', 'Press', 'Tap', 'Gon1', 'Gon2', 'RSCM', 'RTrBr', 'RBiBr', 'RWe', 'RWf', 'RInt', 'RRect', 'RPsp', 'RQ', 'RAdd', 'RH', 'RTa', 'RTs', 'LSCM', 'LTiBr', 'LBiBr', 'LWe', 'LWf', 'LInt', 'LRect', 'LPsp', 'LQ', 'LAdd', 'LH', 'LTa', 'LTs' },'Position',[19 47 72 144],... %...absolute position to the figures client
         'Callback', {@pp3,Data}); %...call function pp1 and passing parameter Data.f by pushing this button


    h=Data;
    %set(h,'UserData',Data); %...write actual data to main figure userdata
%end pp2 function