function deleteDatFiles(cdir,varhead)
% delete all *.dat files in folder and sub-folder
%
if ~isdir(cdir) 
    error('input is not dir!');
end
olddir = pwd;
cd(cdir);
delete(strcat(varhead,'.dat'));

subdir = dir(cdir);
len    = length(subdir);
for i=1:len; 
    if isdir(subdir(i).name)&&strcmp(subdir(i).name,'..')==0&&isdir(subdir(i).name)&&strcmp(subdir(i).name,'.')==0
        deleteDatFiles(subdir(i).name,varhead);
    end
end
cd(olddir);
