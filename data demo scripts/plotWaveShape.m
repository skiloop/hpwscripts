function plotWaveShape(name)
%
% plot wave shape in sub folders
%
load Res Ey
h = figure('Name',name);
plot(Ey(:,[30 40]))
xlabel('x')
ylabel('Ey/(Vm^{-1})');
title(name);
grid on;
set(gca,'xlim',[1 length(Ey)]);
legend('center','10 cells from center')
print(h,'-dtiff',strcat(name,'.tiff'));
