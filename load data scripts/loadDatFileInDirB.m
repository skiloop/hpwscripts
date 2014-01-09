function loadDatFileInDirB(cdir,varhead)
% function LOADDATFILEINDIR
% load dat-files in sundir of 'dir'
% usage: loadDatFileInDir(dir)

if ~isdir(cdir) 
    error('input is not dir!');
end

loadAllDatFileB(cdir,varhead);

subdir = dir(cdir);
len    = length(subdir);
for i=1:len; 
    if isdir(subdir(i).name)&&strcmp(subdir(i).name,'..')==0&&isdir(subdir(i).name)&&strcmp(subdir(i).name,'.')==0
        loadDatFileInDirB(subdir(i).name,varhead);
    end
end

        
    