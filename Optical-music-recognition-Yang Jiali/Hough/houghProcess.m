clear all;

A=imread('mask3.jpg');
level  = graythresh(A);
BW = 1- im2bw(A,level);
L = bwlabel(BW,4);
BW2=imfill(BW);% Read image and fill it

[H,T,R] = hough(BW2);%Hough transform
figure;
imshow(BW2);

P   = houghpeaks(H,5); %Peaks after Hough transform 
lines = houghlines(BW2,T,R,P);%Get the line

for k = 1:length(lines)
    xy = [lines(k).point1; lines(k).point2]; %point of the line 
end
m=(xy(2,2)- xy(1,2))/(xy(2,1)-xy(1,1));%  caculate gradient
M=atan(m);
M=M*180/3.14;%caculate angle


C=imrotate(A,-M); % Final adjust
imwrite(C,'img.png');
figure;
subplot(1,2,1);imshow(A);title('original');
subplot(1,2,2);imshow(C);title('After');