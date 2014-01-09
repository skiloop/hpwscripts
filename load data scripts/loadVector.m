function loadVector(varhead,outfile)

filelist = dir(strcat(varhead,'*.dat'));
len = length(filelist);
for i=1:len
    varname=filelist(i).name(1:8);
    eval(strcat('tne=load(filelist(i).name,',char(39),'-ascii',char(39),');'));
    l=length(tne)^0.5;
    eval(strcat(varname,'=reshape(tne(:,3),l,l)',char(39),';'));
end
save(outfile);