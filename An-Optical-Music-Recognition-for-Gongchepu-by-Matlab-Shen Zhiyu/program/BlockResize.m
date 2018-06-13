function Block=BlockResize(Block)
[m,n]=size(Block);
Tempt=Block;
for i=1:m
    for j=1:n
        Block(i,j)=1;
    end
end
Block=imresize(Block,[300,300]);
for i=1:m
    for j=1:n
        Block(i+114,j+114)=Tempt(i,j);
    end
end
end
        