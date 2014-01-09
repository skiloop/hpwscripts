function loadAllDatFile(cdir)
% LOADALLDATFILE
% load all dat-file in 'dir'
%
if ~isdir(cdir) 
    disp(cdir);
    error('input is not dir!');
end

oldir = pwd;
cd(cdir);
if exist('DataList.dat','file');
    delete DataList.dat;
end
filelist = dir('*.dat');
len = length(filelist);
for i=1:len
    load(filelist(i).name,'-ascii');
end
if len~=0;
    save res;
end
cd(oldir);

