function loadDatFileInDir(cdir)
% function LOADDATFILEINDIR
% load dat-files in sundir of 'dir'
% usage: loadDatFileInDir(dir)

if ~isdir(cdir) 
    error('input is not dir!');
end

loadAllDatFile(cdir);

subdir = dir(cdir);
len    = length(subdir);
for i=1:len; 
    if isdir(subdir(i).name)&&strcmp(subdir(i).name,'..')==0&&strcmp(subdir(i).name,'.')==0
        loadDatFileInDir(subdir(i).name);
        disp(subdir(i).name);
    end
end

        
    