function makemmovie(movname,varhead,file,figname,islog)
% function MAKEMMOVIE
% Make movie with a series of variables with name 'varhead' in 'file'.
% using mesh.
% Usage: makemmovie(movname,varhead,file,figname)
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
varhead=strcat(varhead,'*');
load(file,varhead);
li = whos(varhead);
if isempty(li)
    warning('No variable names with  varhead found in the file.');
    return;
end

% initial the figure
h = figure('NumberTitle','OFF','Name',figname);
l = 27:175;
tvar= eval(li(floor(end/10)+1).name);
ma = 2*max(max(tvar));
mi = 2*min(min(tvar));
if islog
    tvar(tvar<1)=1;
    ih= mesh(log(tvar(l,l)));
else
    ih= mesh(tvar(l,l));
end

ax = gca;
colorbar;
set(ax,'Zlim',[mi ma]);
title(figname);
mov(1)=getframe(h);
% yt = get(gca,'ytick');
% xt = get(gca,'xtick');
% start to make movie
len = length(li);
for iter = 2:len
    tvar= eval(li(iter).name);
    if islog
        tvar(tvar<1)=1;
        tvar = log(tvar);
    end
    set(ih,'CData',tvar(l,l),'ZData',tvar(l,l));
    xlabel(ax,['Time : ',datestr(clock)]);
    title(ax,[figname,' step = ',int2str(iter)]);
    drawnow;
    mov(iter) = getframe(h);
end
movie2avi(mov, movname, 'compression', 'None');



