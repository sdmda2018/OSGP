function Note=SpecialNote(Note)
[m,n]=size(Note);
for i=1:m
    for j=1:n
        Note(i,j)=1;
    end
end
Note=imresize(Note,[100,100]);
left1=11;right1=89;
top1=11;bottom1=89;
for i=left1:right1
    for j=top1:bottom1
        Note(i,j)=0;
    end
end
left2=22;right2=78;
top2=22;bottom2=78;
for i=left2:right2
    for j=top2:bottom2
        Note(i,j)=1;
    end
end
end

        
