function [note,rythm]=LabelSplit(I)
[m,n]=size(I);
cutline=1;
while sum(I(1:m,cutline))~=0||cutline<=30
    cutline=cutline+1;
    if cutline>=n;
        cutline=n; 
        break;
    end   
end
if cutline~=n
note=imcrop(I,[1,1,cutline-1,m-1]);
rythm=imcrop(I,[cutline,1,n-cutline,m-1]);
else            
    note=I;
    rythm=[];
end
end
