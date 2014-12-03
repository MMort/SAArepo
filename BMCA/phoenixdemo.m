% this demonstrates a little part of the data in the
% phoenix data structure read with readPhoenix
% 11/2005 Marcus Vitek

%phoenix = readPhoenix('S0.15');
load phoenix.mat
sub = phoenix.subjectData;
num = 8;
figure(1);
phoenix.data(:,(1:100))=[];
% Latenz(phoenix.data(1,:), phoenix.data(8,(100:end)));
Latenz(phoenix.data(1,:), phoenix.data(8,:));

for foo = 1:num
    subplot(num,1,foo);
    grid on
    plot(phoenix.data(foo,:));
    %axis off;
    %title(phoenix.eegChanInfoFix(foo).act);
    %ylabel('µV');
    ylabel(phoenix.eegChanInfoFix(foo).act);
    set(get(gca,'YLabel'),'Rotation',0.0)
    %axis off;
end
subplot(num,1,1);
grid on
title(['BMCA ' num2str(sub.eegNr) '-' num2str(sub.subNr) '-' num2str(sub.subsubNr) ' ' sub.firstName ' ' sub.name] , 'Fontweight', 'bold');
