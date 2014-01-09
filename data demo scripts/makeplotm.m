function makeplotm(movname,varhead,file,figname)
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
tvar= eval(li(1).name);
ih= plot(tvar(int16(end/2),l));
set(gca,'YDir','Normal');
ax = gca;
set(ax,'YLim',[0 3e20])
colorbar;
title(figname);
mov(1)=getframe(h);

% start to make movie
len = length(li);
for iter = 2:len
    tvar= eval(li(iter).name);
    set(ih,'YData',tvar(int16(end/2),l));
    xlabel(ax,int2str(iter));
    drawnow;
    mov(iter) = getframe(h);
end
movie2avi(mov, movname, 'compression', 'None');

