clear;close all
src = imread('eltest.png');
whos,

%test of euler and block fill
level  = graythresh(src);
bw  = im2bw(src,level);

eul=bweuler(bw,8); %it means blocks - holes,so Chinese characters are always negative

bw(1:200,1:200) = 1; % DONNOT start from 0
imshow(bw)

