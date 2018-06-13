function NoteSlice(t,Note)


%图像取反
disk1=[0,1,0;0,1,0;0,1,0];
Note=~Note;
Note=bwareaopen(Note,50);
Note=imdilate(Note,disk1);


%旋转图像
%src=imrotate(src,-90);
%figure;imshow(src);
%提取连通域
[L,num]=bwlabel(Note,8);

%提取连通域BoundingBox宽度和高度属性用于判断连通域是否完整
stats=regionprops(L,'BoundingBox');
S=regionprops(L,'Area');
BoxX=cell(1,num);
BoxY=cell(1,num);
BoxWidth=cell(1,num);
BoxHeight=cell(1,num);
Space=cell(1,num);

for i=1:num
    Space{i}=S(i).Area;
    BoxX{i}=stats(i).BoundingBox(1);
    BoxY{i}=stats(i).BoundingBox(2);
    BoxWidth{i}=stats(i).BoundingBox(3);
    BoxHeight{i}=stats(i).BoundingBox(4);
    BoxXX{i}=BoxX{i}+BoxWidth{i};
    BoxYY{i}=BoxY{i}+BoxHeight{i};
end


%将节奏符号重新标记
[m,n]=size(L);
line=floor(m*0.6);
NoteNumber=0;
isRythm=cell(1,num);
for k=1:num
    if BoxY{k}+BoxHeight{k}<=line
        isRythm{k}=1;
        for i=1:m
            for j=1:n
                if L(i,j)==k
                    L(i,j)=num+1;
                end
            end
        end
    else
        isRythm{k}=0;
        NoteNumber=NoteNumber+1;
    end
end

   
        

%将音高符号重新标记
counts=1;
for i=1:num
    if isRythm{i}==0
        j=i+1;
        if j>num
            j=num;
        end
        while isRythm{j}==1
            j=j+1;
            if j>num
                j=num;
                break;
            end
        end
        if Space{i}>=600&&BoxX{j}-BoxXX{i}>=0
            for a=1:m
                for b=1:n
                    if L(a,b)==i
                       L(a,b)=counts;
                    end
                end
            end
            if i==j&&j==num
            break;
            else
            counts=counts+1;
            end
            if isRythm{j}==1&&j==num
                counts=counts-1;
            end
        else if (Space{i}<600 && Space{j}>=600)||BoxX{j}-BoxXX{i}>=10
             for a=1:m
                for b=1:n
                    if L(a,b)==i
                       L(a,b)=counts;
                    end
                end
            end
            counts=counts+1;
            if i==j
                counts=counts-1;
            end
        else
            for a=1:m
                for b=1:n
                    if L(a,b)==i
                       L(a,b)=counts;
                    end
                end
            end
            end
        end
    else
        continue;
    end
end

NoteNumber=counts;

%再次标记节奏符号

for i=1:m
    for j=1:n
        if L(i,j)==num+1
            L(i,j)=NoteNumber+10;
        end
    end
end
        
%TEST
%for i=1:m
    %for j=1:n
        %if L(i,j)==NoteNumber+1
           %L(i,j)=0;                
        %end
    %end
%end

%建立并将L拆分为多个标签
[m,n]=size(L);
Label=cell(1,NoteNumber);
Tempt1=cell(1,NoteNumber);
Tempt2=L;


for i=1:NoteNumber
    Tempt1{i}=L;
    for j=1:m
        for k=1:n
            if Tempt1{i}(j,k)~=i
                Tempt1{i}(j,k)=0;
            end
        end
    end
end

for i=1:num-NoteNumber
    Tempt2=L;
     for j=1:m
        for k=1:n
            if Tempt2(j,k)~=NoteNumber+10
                Tempt2(j,k)=0;
            else
                Tempt2(j,k)=1;
            end
        end
    end
end
[RythmL,RythmNumber]=bwlabel(Tempt2,8);
        

%标记音高符号位置
Position=cell(1,NoteNumber);
for i=1:NoteNumber
    Position{i}=MarkPosition(Tempt1{i});
end

if RythmNumber~=0

%标记节奏符号位置
Rstart=cell(1,RythmNumber);
Rend=cell(1,RythmNumber);
for i=1:RythmNumber
    [Rstart{i},Rend{i},REMAIN]=RythmPosition(Tempt2);
    Tempt2=REMAIN;
end


%将节奏符号分配给音高符号
for l=1:RythmNumber
    i=1;
    while Rstart{l}>=Position{i};
        i=i+1;
        if i>NoteNumber
            i=NoteNumber;
            break;
        end
    end
    
    END=Rend{l};        
    for j=1:m
        for k=1:END
            if L(j,k)==NoteNumber+10
                L(j,k)=i;
            end
        end
    end
end

for i=1:m
    for j=1:n
        if L(i,j)==NoteNumber+10
                L(i,j)=NoteNumber;
        end
    end
end

%再次拆分L

for i=1:NoteNumber
    Label{i}=L;
    for j=1:m
        for k=1:n
            if Label{i}(j,k)~=i
                Label{i}(j,k)=0;
            end
        end
    end
    Label{i}=imrotate(Label{i},-90);
end



%剪裁并标记%注：左右分割有问题
Leftparts=cell(1,NoteNumber);
Rightparts=cell(1,NoteNumber);
isSingle=cell(1,NoteNumber);
for i=1:NoteNumber
    Label{i}=LabelCrop(Label{i});
end

for i=1:NoteNumber
    [Leftparts{i},Rightparts{i}]=LabelSplit(Label{i});
end

%输出切割后的
 

for i=1:NoteNumber
    name=num2str(i);
    NAME=num2str(t);
    Leftparts{i}=~Leftparts{i};
    Rightparts{i}=~Rightparts{i};
    [m,n]=size(Leftparts{i});
    if n/m>=6
        Leftparts{i}=SpecialNote(Leftparts{i});
    end
    Leftparts{i}=NoteResize(Leftparts{i});
    imwrite(Leftparts{i},['D:\XZTF\FinalProgram\results\DDD\',NAME,'-',name,'-Left.png']);
    if isempty(Rightparts{i})
        continue;
    else
        Rightparts{i}=NoteResize(Rightparts{i});
        imwrite(Rightparts{i},['D:\XZTF\FinalProgram\results\DDD\',NAME,'-',name,'-Right.png']);
    end
end
    

else 
    for i=1:NoteNumber
        Tempt1{i}=imrotate(Tempt1{i},-90);
        Label{i}=Tempt1{i};
    end
    for i=1:NoteNumber
        Label{i}=LabelCrop(Label{i});
        Label{i}=~Label{i};
    end
    for i=1:NoteNumber
        name=num2str(i);
        NAME=num2str(t);
        Label{i}=NoteResize(Label{i});
        imwrite(Label{i},['D:\XZTF\FinalProgram\results\DDD\',NAME,'_',name,'-Whole.png']);
    end        
end
end





        
    
    

                




