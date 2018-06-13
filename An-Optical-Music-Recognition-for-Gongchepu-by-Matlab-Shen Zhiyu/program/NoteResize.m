function Note=NoteResize(Note)
[m,n]=size(Note);
if m==100&&n==100
    Note=imresize(Note,[240,240]);
else
Tempt=Note;
for i=1:m
    for j=1:n
        Note(i,j)=1;
    end
end
Note=imresize(Note,[240,240]);
for i=1:m
    for j=1:n
        Note(i+60,j+60)=Tempt(i,j);
    end
end
end
end
        
    