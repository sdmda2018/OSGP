function line=MarkPosition(I)
[m,n]=size(I);
line=n;
while sum(I(1:m,line))==0
    line=line-1;
    if line==1
        line=1;
        break;
    end
end
end