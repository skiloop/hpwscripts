function loadDats(filehead,filename)
display(['load ' filehead ' to ' filename]);
filelist = dir(strcat(filehead,'*.dat'));
len = length(filelist);
for i=1:len
    load(filelist(i).name,'-ascii');
end

save(filename);