%ES WURDEN BISHER ALLE WERTE EINES CHANNELS MIT EINBEZOGEN (KEIN TRIGGER - WINDOWING)!
function[RMS, peak_row, peak_col, Max_p_y,Max_p_x, Median_p, ben_y] = Amplitude_Frequency_analysis(channel, Messbeginn, Messende, Benutzerdefinierter_Zeitpunkt)

%Amplitude
    [peak_col,peak_row] = max(channel(Messbeginn:Messende)); %findet nicht immer den max-wert... 
    RMS = sqrt(mean(channel(Messbeginn:Messende).^2));       %Root mean square eines ges. Kanals
    if(Benutzerdefinierter_Zeitpunkt==0)
        ben_y = NaN;
    else
        ben_y = channel(str2num(Benutzerdefinierter_Zeitpunkt));
    end
   % subplot(num+1-start,2,foo+1-start);
        
 %Frequenz      
    Power = abs(fft(channel));   %Powersprektrum der gewählten Kanäle
    Median_p = median(Power(1,1:(length(Power)/2)));      %Median von Power (1:6700 , weil sonst Spiegelung miteinbezogen wird=
    [Max_p_y Max_p_x] = max(Power(1,1:(length(Power)/2)));
end