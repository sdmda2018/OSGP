function [left,right,Remain]=RythmPosition(I)
[m,n]=size(I);
left=1;
while sum(I(1:m,left))==0
    left=left+1;
    if left>=n;
        left=n;
        break;
    end
end
right=left+1;
if right>=n
    right=n;
end
while sum(I(1:m,right))~=0
    right=right+1;
    if right>=n;
        right=n;
        break;
    end
end
for i=1:m
    for j=1:right
        if I(i,j)==1
            I(i,j)=0;
        end
    end
end
Remain=I;
end
