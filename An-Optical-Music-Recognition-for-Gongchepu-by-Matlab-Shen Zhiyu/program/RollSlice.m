function  [Rolls,Remain]=RollSlice(I)
[m,n]=size(I);
right=400;
if right>=n
    right=n;
end
while sum(I(1:m,right))<m
    right=right+1;
end
Rolls=imcrop(I,[1,1,right-1,m-1]);
Remain=imcrop(I,[right,1,n-right,m-1]);
end