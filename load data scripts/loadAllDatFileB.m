function loadAllDatFileB(cdir,varhead)
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
filelist = dir(strcat(varhead,'*'));
len = length(filelist);
for i=1:len
    fname = filelist(i).name;
    if strcmp(fname(end-2:end),'dat')~=0
        load(filelist(i).name,'-ascii');
    end
end
if len~=0;
    save(varhead);
end
cd(oldir);

