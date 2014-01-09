function makeplot(movname,varhead,file,figname,step)
% function MAKEMOVIE
% Make movie with a series of variables with name 'varhead' in 'file'.
% Usage: makemovie(movname,varhead,file)
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
varheads=strcat(varhead,'*');
li = whos('-file',file,varheads);
if isempty(li)
    warning('No variable names with  varhead found in the file.');
    return;
end

% initial the figure
h = figure('NumberTitle','OFF','Name',figname);
load(file,li(1).name);
tvar= eval(li(1).name);
% ih= plot(tvar(int16(end/2),l));
ih= plot(tvar);
ax = gca;
% set(ax,'YLim',[-1 1]);
title(figname);
mov(1)=getframe(h);

% start to make movie
len = length(li);
for iter = 1:len
    ffname=strcat(varhead,int2str(iter*step));
    load(file,ffname);
    tvar= eval(ffname);
    set(ih,'YData',tvar);
    xlabel(ax,['Time : ',datestr(clock)]);
    title(ax,[figname,' step = ',int2str(iter*step)]);
    drawnow;
    mov(iter) = getframe(h);
end
% movie2avi(mov, movname, 'compression', 'None');

