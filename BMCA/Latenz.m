function[] = Latenz(event, channel)
% Zeitraum vom Beginn des Messbereiches bis zum Beginn der Muskelaktivität im
% Kanal x ODER y ODER z ODER ...
x = find(event>0);
starttrigger = min(x);
%channel=channel(50:end)
x = find((channel>20)|(channel<-20))
startactivity = min(x);
%startactivity = startactivity +100;

latenz = startactivity - starttrigger;

% Zeitraum von einem zuvor berechneten Zeitpunkt bis zum nächsten Beginn der
% Muskelaktivität im Kanal x ODER y ODER z ODER ...
% Beispiel:
% x = Latenz von Beginn des Messbereiches bis Beginn der Muskelaktivität im
% Kanal 10 oder 11
% Latenz von x bis Beginn der Muskelaktivität im Kanal 12

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

% Entspannungslatenz für einen bestimmten Kanal

% Zeitpunkt der maximalen Amplitude (siehe 3.3.2)
end