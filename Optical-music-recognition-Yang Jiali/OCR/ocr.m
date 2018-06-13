%%%%%%%%%%%%%%%%Read Image and build file%%%%%%%%%%%%%%%%%%      
close all;
clear all;

fidout = fopen('result.txt','a'); % 'a' means 'add mode'
fprintf(fidout,'\r\n '); % write '\n'  in txt file

img =  imread ('img(9).png');
figure;
imshow(img);
[i_h,i_v] = size(img);

% A manual method to get proper rect, abandoned already.
% roi = round(getPosition(imrect));
% result = ocr(i,roi);
% disp(result);      


%%%%%%%%%%%%%%%%%%%% get distict %%%%%%%%%%%%%%%%%%%%%%
imgs = img(i_h-50:i_h-25, :);
figure;
imshow(imgs);   %cut ranks to get pure number without other signals



 %%%%%%%%%%%%%%%%%%%% get number %%%%%%%%%%%%%%%%%%%%%
h = sum(imgs,1); %
figure;
bar(h)

x = find(h); % delete zero
a =x;
m = GetU(a);    


global nm_index ;
nm_index = 1;
for i=1:2:length(m)
    num_get = img(:,m(i):m(i+1));    %  Notice:img is not cutted, get the number 
   % figure;
   % imshow(num_get);
    
  %%%%%%%%%%%%%%% segament of number's top and bottom %%%%%%%%%%%
  [nm_h,nm_v] = size (num_get);
  hh= sum(num_get,2);
%   figure;
%   plot(hh,1:nm_h)
  e = find(hh);
  [hhd,unused] = size(find (hh));
  %disp(hhd);
  
  %%%%%%%%%%%%%%% start judge& recognize %%%%%%%%%%%%%%%%%%%%%%%%%
  if hhd>=59
      disp('|')
      fprintf(fidout,'|');
  elseif hhd>5 & hhd<10
      disp('-')
      fprintf(fidout,'-');
  elseif hhd>10 & hhd<59  % So it's a number
      
    
      horizon = GetU(e);
      j =1;
     horizon 
     while j<length(horizon)
          if horizon(j+1) - horizon(j)>27
             num = num_get(horizon(j):horizon(j+1),:);
             %imshow(num);
             num = imresize(num,[30 20],'bilinear' );  % number rec resize
             figure;
             imshow(num); %show number after resize 
             num_rec = MatchM(num);  %core match method
             disp(num_rec)  % display result
             
             fprintf(fidout,'%d',num_rec); % write result to file
             
             dist = length(horizon) - (j+1);
             dist
             if dist == 2
                  sus = num_get(horizon(j+2):horizon(j+3),:);
                  figure;
                  imshow(sus);
                  sus = sum(sus,1);
                  sus
                  sus = find(sus);
                  sus
                  [unused,sus]= size(sus);
                  sus
                  if sus >15
                      fprintf(fidout,'_');
                  elseif sus<10
                      fprintf(fidout,'.');
                  end
                 
             end   %end of quick simbol judge
             if dist  == 4
                 fprintf(fidout,'_ _');
             end  %end of quick simbol judge
            
          end %end of number count
           j = j+2;
     end %end of number judge
              
  end % end of ALL judge (number and simbol)
  
end %end of rank segement


fclose(fidout); %close file input

distFig(); % arrange windows