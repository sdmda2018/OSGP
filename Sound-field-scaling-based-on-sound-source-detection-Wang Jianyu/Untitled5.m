FS=44100;
[s,FS]=audioread('SR001MIX.WAV'); % 将 WAV 文件转换成变量 
n=0;
m=135;
w=s*sqrt(2)/2;
x=s*cos(m)*cos(n);
y=s*sin(m)*cos(n);
z=s*sin(n);
W=rms(w);
X=rms(x);
Y=rms(y);
Z=rms(z);
m=atan(Y/X);
m1=m/pi


