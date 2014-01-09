
filelist = dir('*.dat');
len = length(filelist);
for i=1:len
    load(filelist(i).name,'-ascii');
end


filelist = dir('*.txt');
len = length(filelist);
for i=1:len
    load(filelist(i).name,'-ascii');
end