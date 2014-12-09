function[latenz1, latenz2, entspannungslatenz] = Latenz(channel1, Messbeginn, Messende)
% Zeitraum vom Beginn des Messbereiches bis zum Beginn der Muskelaktivität im
% Kanal x ODER y ODER z ODER ...

% load phoenix.mat
% channel1=phoenix.data(8,:);
% [Messbeginn Messende] = Messzeiten (phoenix.data(1,:));
% plot(channel1);


mean_Beginn = mean(channel1(250:Messbeginn));
std_Beginn = std(channel1(250:Messbeginn));
std_alles = std(channel1(250:end));

%kein signal (nur rauschen)
if(std_alles<1)
    latenz1 = NaN;
    latenz2=NaN;
    entspannungslatenz=NaN;
    return;
end

threashold_pos_Begin = mean_Beginn + 6 * std_Beginn;
threashold_min_Begin = mean_Beginn - 6*std_Beginn;
x = find((channel1(250:end)>threashold_pos_Begin)|(channel1(250:end)<threashold_min_Begin));
if(isempty(x))
    latenz1 = NaN;
else
    y=(min(x)+250);
    latenz1 = y/1024;
end



% Zeitraum von einem zuvor berechneten Zeitpunkt bis zum nächsten Beginn der
% Muskelaktivität im Kanal x ODER y ODER z ODER ...
% Beispiel:
% x = Latenz von Beginn des Messbereiches bis Beginn der Muskelaktivität im
% Kanal 10 oder 11
% Latenz von x bis Beginn der Muskelaktivität im Kanal 12
x = find((channel1(Messbeginn:Messende)>threashold_pos_Begin)|(channel1(Messbeginn:Messende)<threashold_min_Begin));
if(isempty(x))
    latenz2 = NaN;
else
    y=(min(x));
    latenz2 = y/1024;
end

% Tabelle der Entspannungslatenz ab einem definierbaren Zeitpunkt (entweder
% Beginn der Aufnahme oder variabler Zeitpunkt x wie oben)
% > Es soll hier eine Tabelle ausgegeben werden mit den Kanalnummern und der
% Zeit bis zur Entspannung der Muskelaktivität (z.B. unter einen gewissen ?VLevel)
% in Sekunden
% > Konnte bis zum Ende des jeweiligen Messzeitraumes keine Entspannung
% aufgefunden werden, soll "n/a" statt einer Zeit angegeben werden
% > Beispiel:
% LSCM 5.256 (nach ca. 5 Sekunden entspannt)
% LDELT 0.000 (war immer entspannt)
% LBIBR n/a (konnte während des Messzeitraumes nicht entspannt werden)

x = find((channel1(250:end)<threashold_pos_Begin)|(channel1(250:end)>threashold_min_Begin));
if(isnan(latenz1))
    entspannungslatenz=0;
elseif (isempty(x))
    entspannungslatenz=NaN;
else
    x = find((channel1(Messende:end)>threashold_pos_Begin)|(channel1(Messende:end)<threashold_min_Begin));
    y=max(x);
    entspannungslatenz=y/1024;
end

end