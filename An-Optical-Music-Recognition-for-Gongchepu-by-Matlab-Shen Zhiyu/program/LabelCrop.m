function Label=LabelCrop(I)
[m,n]=size(I);
left=1;right=n;top=1;bottom=m;
while sum(I(1:m,left))==0
    left=left+1;
    if left>=n
        left=1;
        break;
    end
end

while sum(I(1:m,right))==0
    right=right-1;
    if right<=1
        right=n;
        break;
    end
end

while sum(I(top,1:n))==0
    top=top+1;
    if top>=m
        top=1;
        break;
    end
end

while sum(I(bottom,1:n))==0
    bottom=bottom-1;
    if bottom<=1
        bottom=m;
        break;
    end
end

Label=imcrop(I,[left,top,right-left,bottom-top]);
end

        
    
