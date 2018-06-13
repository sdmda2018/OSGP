function rolls=RollCrop(I)
[m,n]=size(I);
left=1;right=n;
while sum(I(1:m,left))>=m-100
    left=left+1;
    if left>=n;
        left=1;
        break;
    end
end
while sum(I(1:m,right))==m
    right=right-1;
    if right>=n;
        right=n;
        break;
    end
end
rolls=imcrop(I,[left,1,right-left,m-1]);
end