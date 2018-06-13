%%%%%%%%%%%%%%%%%%%%% Read Image %%%%%%%%%%%%%%%%%%%%%
clear;close all
src = imread('mask5.jpg');  %Read Image
whos,  %display image info

%figure('Name','Image Info')
%subplot(2,3,1),imshow(src),title('origional')

%%%%%%%%%%%%%%%%%%%% OTSU&Reverse %%%%%%%%%%%%%%%%%%%%
level  = graythresh(src);
bw2 = im2bw(src,level);  % OTSU normalization

%subplot(2,3,2),imshow(bw2),title('bw\_white')
%imwrite(bw2,'bwwhite.jpg');

bw = 1 - im2bw(src,level); % Reverse due to the next histogram count

%subplot(2,3,3),imshow(bw),title('bw\_black')
%imwrite(bw,'bwblack.jpg');

%%%%%%%%%%%%%%%%%%%% histogram of horizon %%%%%%%%%%%%%%%%%

h = sum(bw,2);  %Plot the histogram of rows as H

%figure('Name','Histogram of rows')
%plot(sum(bw,2),1:size(bw,1))
%title('Histogram of bw\_black')
%set(gca,'YDir','reverse');

%%%%%%%%%%%%%%%%%%%% Find Ranks %%%%%%%%%%%%%%%%%%%%%%
x = find(h); % delete zeros
m = GetU(x);


%%%%%%%%%%%%%%%%%%%% Effective Ranks %%%%%%%%%%%%%%%%%%%%
global nm_idex ;
nm_index = 1;
for i=1:2:length(m)
    if (m(i+1)-m(i)) >= 60  %get rid of Chinese ranks
         if (m(i+1)-m(i)) <250
          figure;
          slice = bw(m(i):m(i+1),:);
          
          s=sprintf('img(%d).png',nm_index);  
          imwrite(slice,s);  %save as img according to index
           
          nm_index = nm_index +1;
          imshow(slice);
         else
               slice = bw(m(i):m(i+1),:);
               slice2 = bw(m(i):m(i+1),500:2110);  %Quickly find the right parts
               
               h2 = sum(slice2,2); 
               x2 = find(h2); 
               m2 =  GetU(x2); %do it again!
                          
             for i2=1:2:length(m2)
                 if (m2(i2+1)-m2(i2)) >= 49
                      figure;
                      slice3 = slice(m2(i2):m2(i2+1),:);
                      imshow(slice3);
                 end
             end
         end
      end
    end

distFig();   % arrange windows

