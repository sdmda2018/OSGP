function I=ImageSlice(Img)
[m,n]=size(Img);
top=1;
left=1;
bottom=m;
right=n;
while sum(Img(top,1:n))==n
    top=top+1;
end
while sum(Img(bottom,1:n))==n
    bottom=bottom-1;
end
while sum(Img(1:m,left))==m
    left=left+1;
end
while sum(Img(1:m,right))==m
    right=right-1;
end

I=imcrop(Img,[left+40,top+40,right-left-80,bottom-top-80]);
end