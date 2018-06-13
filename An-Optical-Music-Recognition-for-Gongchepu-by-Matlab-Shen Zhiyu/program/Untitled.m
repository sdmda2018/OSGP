I=imread('D:\XZTF\FinalProgram\results\CCC\55.png');
I=~I;
disk=[0,1,0;0,1,0];
I=imerode(I,disk);
figure;imshow(I);