function plotcapwave(nocpwl,name)
%
%
load Res ce1 ce10 ce50
f = 5e8;
T = 1/f;
dt = T/nocpwl;
t  = (0:length(ce1)-1)*dt;
t = t/1e-9;
h = figure('Name',name,'NumberTitle','OFF');
plot(t,ce1,'.-r',t,ce10,'--b',t,ce50,'.g');
title(name);
legend('1m','10m','50m');
xlabel('t/ns');
ylabel('Ez/(Vm^{-1})');
grid on
print(h,'-dtiff',strcat(name,'.tiff'));
%% close look
len = 1000;
l=max(find(abs(ce1)>=1e-5, 1, 'first' )-100,1); l1 = l:l+len;
l=max(find(abs(ce10)>=1e-5, 1, 'first' )-80,1); l2 = l:l+len;
l=max(find(abs(ce50)>=1e-5, 1, 'first' )-50,1); l3 = l:l+len;
% plot ce1
h1 = figure('name','A closer look');
subplot(3,1,1);plot(l1,ce1(l1));
xlabel('step | figure of Ey at 1 m');ylabel('V/m');grid on;set(gca,'xlim',[l1(1) l1(end)]);
title(name)
subplot(3,1,2);plot(l2,ce10(l2));
xlabel('step | figure of Ey at 10 m');ylabel('V/m');grid on;set(gca,'xlim',[l2(1) l2(end)]);
subplot(3,1,3);plot(l3,ce50(l3));
xlabel('step | figure of Ey at 50 m');ylabel('V/m');grid on;set(gca,'xlim',[l3(1) l3(end)]);
print(h1,'-dtiff',strcat(name,'(Closer look).tiff'));