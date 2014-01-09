function cmakemovie(movname,varhead,file,figname,islog,dim,mlen)
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
varhead=strcat(varhead,'*');
load(file,varhead);
li = whos(varhead);
if isempty(li)
    warning('No variable names with  varhead found in the file.');
    return;
end

% initial the figure
h = figure('NumberTitle','OFF','Name',figname);
l = round(dim*27):round(dim*175);
tvar= eval(li(1).name);
if islog
    tvar(tvar<1)=1;
    ih= imagesc(log(tvar(l,l)));
else
    ih= imagesc(tvar(l,l));
end
%ih= imagesc(tvar);
set(gca,'YDir','Normal');
ax = gca;
colorbar;
title(figname);
mov(1)=getframe(h);
% yt = get(gca,'ytick');
% xt = get(gca,'xtick');
% start to make movie
len = length(li);
if len>mlen
    len = mlen;
end
for iter = 2:len
    tvar= eval(li(iter).name);
    if islog
        tvar(tvar<1)=1;
        tvar = log(tvar);
    end
    set(ih,'CData',tvar(l,l));
    %set(ih,'CData',tvar);
    xlabel(ax,['Time : ',datestr(clock)]);
    title(ax,[figname,' step = ',int2str(iter)]);
    drawnow;
    mov(iter) = getframe(h);
end
movie2avi(mov, movname, 'compression', 'None');



