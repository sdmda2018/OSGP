function [isUseful,Block,Note]=BlockScreen(I)
[m,n]=size(I);
left=1;

while sum(I(1:m,left))~=m
    left=left+1;
    if left>=n
        left=n-1;
        break;
    end
end
right=left+20;
if right>=n
    right=n;
end
while sum(I(1:m,right))==m
    right=right+1;
    if right>=n
        right=n;
        break;
    end
end

if right>=130&&left<=95
    isUseful=0;
else
    isUseful=1;   
end
if n<90
    isUseful=0;
end
I=~I;
[L,num]=bwlabel(I,8);
stats=regionprops(L,'BoundingBox');
BoxX=cell(1,num);
for i=1:num
    BoxX{i}=stats(i).BoundingBox(1);
    if BoxX{i}<90
        for a=1:m
            for b=1:n
                if L(a,b)==i
                   L(a,b)=1;
                end
            end
        end
    else
        for a=1:m
            for b=1:n
              if L(a,b)==i
                 L(a,b)=2;
              end
            end
        end
    end
end
Note=L;
Block=L;
for a=1:m
        for b=1:n
            if Note(a,b)==1
                Note(a,b)=0;
            end
        end
end
    for a=1:m
        for b=1:n
            if Block(a,b)==2
                Block(a,b)=0;
            end
        end
    end
Note=~Note;
Block=~Block;
end

