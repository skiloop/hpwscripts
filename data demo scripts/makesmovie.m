function makesmovie(movname,varhead,file,figname,islog,~)
% function MAKEMOVIE
% Make movie with a series of variables with name 'varhead' in 'file'.
% Usage: makemovie(movname,varhead,file,figname)
% Inputs:
%       movname ------ name of output file in format of '*.avi'
%       varhead ------ key charaters of variable name
%          file ------ Matlab mat-file to be load from (not with .mat)
%       figname ------ name of figure
% Outputs:
%       an avi-file with name movname.avi
%
% by skiloop@126.com
% 2011/12/19 09:40
%

% check if inputs are all chars
if ~ischar(varhead)||~ischar(file)||~ischar(movname)||~ischar(figname)
    error('All inputs are required to be char!');
end

% check if file exist
file = strcat(file,'.mat');
if ~exist(file,'file');
    error('File not exist!\nPlease check the file and rerun the program!');
end

% load variables
% strcat(varhead,'*');
% load(file,varhead);
li = whos('-file',file,strcat(varhead,'*'));
if isempty(li)
    warning('No variable names with  varhead found in the file.');
    return;
end

% initial the figure
h = figure('NumberTitle','OFF','Name',figname);
%l = round(dim*27):round(dim*175);
load(file,'-mat',li(1).name);
tvar= eval(li(1).name);
[xl,yl]=size(tvar);
% if islog
%     tvar(tvar<1)=1;
%     ih= imagesc(log(tvar(l,l)));
% else
%     ih= imagesc(tvar(l,l));
% end
sideWidth=5;
ir=sideWidth:xl-sideWidth;
jr=sideWidth:yl-sideWidth;
ih= imagesc(tvar(ir,jr)');
set(gca,'YDir','Normal');
ax = gca;
colorbar;
title(figname);
mov(1)=getframe(h);
% yt = get(gca,'ytick');
% xt = get(gca,'xtick');
% start to make movie
len = length(li)-2;
clear(li(1).name);
for iter = 1:len
    varname=strcat(varhead,int2str(iter));
    load(file,'-mat',varname);
    tvar= eval(varname);
    if islog
        tvar(tvar<1)=1;
        tvar = log(tvar);
    end
    %set(ih,'CData',tvar(l,l));
    set(ih,'CData',tvar(ir,jr)');
    xlabel(ax,['Time : ',datestr(clock)]);
    title(ax,[figname,' step = ',int2str(iter)]);
    drawnow;
    mov(iter) = getframe(h);
    clear(varname);
end
movie2avi(mov, movname, 'compression', 'None');



