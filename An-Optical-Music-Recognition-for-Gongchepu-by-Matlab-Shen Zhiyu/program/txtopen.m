fid=fopen('D:\XZTF\FinalProgram\results\TEST.txt','r');
count1=1;
str=[];
while ~feof(fid)
    tline=fgetl(fid);
    str{count1}=tline;
    count1=count1+1;
end

fclose(fid);
fid=fopen('D:\XZTF\FinalProgram\results\Result.txt','w');
for i=1:(count1-1)
    str{i}=strrep(str{i},'ÖÐÑÛ','(¡ð)');
    str{i}=strrep(str{i},'Ð¡ÑÛ','(¡¤)');
    str{i}=strrep(str{i},'Í·°å','(¡¢)');
    str{i}=strrep(str{i},'ÑüÑÛ(ÖÐ)','(¡÷)');
    str{i}=strrep(str{i},'ÑüÑÛ£¨Ð¡£©','(<)');
    str{i}=strrep(str{i},'Ñü°å','(L)');
    str{i}=strrep(str{i},'Ôù°å','(X)');
    str{i}=strrep(str{i},'µ×°å','|');
    fprintf(fid,'%s',str{i});
end
fclose(fid);
song=[];
fid=fopen('D:\XZTF\FinalProgram\results\song.txt','r');
count2=1;
while ~feof(fid)
    tline=fgetl(fid);
    song{count2}=tline;
    count2=count2+1;
end
fclose(fid);
fid=fopen('D:\XZTF\FinalProgram\results\Result.txt','w');
j=1;
count1=length(str{1});
for i=1:count1
    if str{1}(i)=='¡õ'
        str{1}(i)=song{j};
        j=j+1;
    end
end
fprintf(fid,'%s',str{1});
fclose(fid); 





