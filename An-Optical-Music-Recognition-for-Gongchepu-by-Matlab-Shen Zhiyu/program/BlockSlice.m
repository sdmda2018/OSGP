function [block,remain,isLast]=BlockSlice(I)
[m,n]=size(I);
top=1;
while sum(I(top,1:n))==n
    top=top+1;
    if top>=m;
        top=1;
        break;
    end
end
bottom=top+1;
N=110;
while sum(I(bottom,1:N))<N
    bottom=bottom+1;
    if bottom>m
        bottom=m;
        break;
    end
    if bottom>=219
        bottom=floor(bottom/2)+5;
        break;
    end
end
if bottom-top<=60
    bottom=114;
end
if bottom-top>130
    bottom=114;
end
block=imcrop(I,[1,top,n-1,bottom-top]);
remain=imcrop(I,[1,bottom,n-1,m-bottom]);
[mr,~]=size(remain);
if mr<120
    isLast=1;
else
    isLast=0;
end
end
