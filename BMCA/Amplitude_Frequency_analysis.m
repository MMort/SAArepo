%ES WURDEN BISHER ALLE WERTE EINES CHANNELS MIT EINBEZOGEN (KEIN TRIGGER - WINDOWING)!

clc
load phoenix.mat
start = 7;  %Ab diesem Datensatz wird ausgegeben
num = 10;   %Bis zu diesem Datensatz wird ausgegeben
figure(1);

% x = find(data(1,:)>0);
% starttrigger = min(x);
% if (x ~= 0)
    for foo = start:num  %%foo = 1:num
        [peak_col,peak_row] = max(phoenix.data(foo,:)); %findet nicht immer den max-wert... 
        RMS = sqrt(mean(phoenix.data(foo,:).^2));       %Root mean square eines ges. Kanals
        
        subplot(num+1-start,2,foo+1-start);
        hold on
        plot(abs(phoenix.data(foo,:)));
        plot(peak_row,peak_col,'r*');
        plot(0:10:length(phoenix.data(foo,:)),RMS,'g-')
        title(['RMS: ',num2str(RMS),'   Max. Amplitude, x: ',num2str(peak_row),' y:',num2str(peak_col)]) 
        hold off
    end
    for foo = start:num  %%foo = 1:num
        Power = abs(fft(phoenix.data(foo,:)));   %Powersprektrum der gewählten Kanäle
        Median_p = median(Power(1,1:6700));      %Median von Power (1:6700 , weil sonst Spiegelung miteinbezogen wird=
    
        subplot(num+1-start,2,foo+start+1-num);
        hold on
        plot(Power);
        plot(Median_p,0:500:30000,'r-')
        hold off
        title(['Median: ',num2str(Median_p)]) 
        axis([0 6700 0 30000])
    end
% end