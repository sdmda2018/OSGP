function block=BlockCrop(I)
[m,n]=size(I);
left=1; right=n;
while sum(I(1:m,left))==m
    left=left+1;
    if left>=n;
        left=1;
        break;
    end
end
while sum(I(1:m,right))==m
    right=right-1;
    if right<=2;
        right=n;
        break;
    end
end
block=imcrop(I,[left,1,right-left,m-1]);
end
