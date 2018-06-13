clear;close all
src = imread('test.jpg');
whos,
% 1. Read Image

figure('Name','Image Info')
subplot(2,3,1),imshow(src),title('origional')


% 2. Ostu normalization, save as "bw_white.jpg" with white background,
% black with black background, use black as default image
level  = graythresh(src);
bw2 = im2bw(src,level);
subplot(2,3,2),imshow(bw2),title('bw\_white')
imwrite(bw2,'bwwhite.jpg');

bw = 1 - im2bw(src,level);
subplot(2,3,3),imshow(bw),title('bw\_black')
imwrite(bw,'bwblack.jpg');

% 3. Plot the histogram of rows as H
h = sum(bw,2);
figure('Name','Histogram of rows')
plot(sum(bw,2),1:size(bw,1))
title('Histogram of bw\_black')
set(gca,'YDir','reverse');

% Clearer bar 
figure;
bar(h)
title('To see H clearly')

% 4. Use H to Find Start and End, save as M matrix
x = find(h); % delete zero
x((length(x)+1)) = 10000; % add x(end+1) as 10000 so that it can be recorded
k=1;
st = x(1);
for i=1:1:(length(x)-1)
    if x(i+1)-x(i)~=1
        ed = x(i);
        m(k) = st;
        m(k+1) = ed;
        st = x(i+1);
        k = k+2;
    end
end   


% 5. After imfill, save as bw3
L = bwlabel(bw,4);
bw3=imfill(bw);
%figure;
%imshow(bw3);
imwrite(bw3,'bw_filled.jpg');

%Use bwlabel to count the blobs after imfill, Chinese characters is less than numbers
%Use bweuler to count the euler stats, Chinese character will be "-" while number is "+" usually.


% 6. Caculate proper slices
for i=1:2:length(m)
    % figure;
    slice_el= bw(m(i):m(i+1),:);%slices to caculate euler
    slice_la=bw3(m(i):m(i+1),:);%slice to caculate lable num
    %feature = sum(slice_test);
    %fat (i) = mode(feature);
    slice(i)= bweuler(slice_el,8);
    [feature,num] = bwlabel(slice_la,8);
    hole(i)=num-slice(i);

%         if slice(i)>15  %START
%             figure;
%             imshow(slice_el)
%             title(['The euler is ',num2str(slice(i)),' '])
%         end
%         
%         if hole(i)<10&hole(i)>0
%             figure;
%             imshow(slice_el)
%             title(['The hole is ',num2str(hole(i)),' '])
%         end    %END


end

% 7. Add offset values to M
for i=1:2:length(m)
    slice_final= bw(m(i):m(i+1),:);
    slice_num= bweuler(slice_final,8);
    
    if slice_num>15          
            slice_final=bw(m(i)-35:m(i+1)-20,:);  %Offset Value:20 on the bottom,35 on the upside
            y=sum(slice_final); %Vertical projection of slice
            n=find(y); %find nonzero linear index (LIKE 1 2 3 7 8 9) 
            
            %Find N with target numbers
            o=find(diff(n)>1); %Get district of nonzero number in n
            o=[0,o,length(n)];%Complete o so that it's easier to do next step
            
            for j=1:1:length(o)-1
                A =n(o(j)+1:o(j+1));%O--N
                B=y(A(1):A(length(A)));%N--Y
                C=max(B);
                if C>10&C<70
                    D=slice_final(:,A(1):A(length(A)));
                    figure;
                    imshow(D);
                end
            end

            
     end
end
%8. 





