tic
[data1, fs1] = wavread('502.wav');   %ikala库原纯人声
[ps1, nf1] = yaapt(data1, fs1, 1, [], 0, 2);  %用 yaapt（）函数计算音高轨迹.计算的音调跟踪被保存在长度为 nf的阵列音高中.
Pitch_fixed1=ptch_fix(ps1);
[data2, fs2] = wavread('501-voice.wav');      %采集音频分离后的人声
[ps2, nf2] = yaapt(data2, fs2, 1, [], 0, 2);  %用 yaapt（）函数计算音高轨迹.计算的音调跟踪被保存在长度为 nf的阵列音高中.
Pitch_fixed2=ptch_fix(ps2);
plot(Pitch_fixed1, '.-');
figure
plot(Pitch_fixed2, '.-');
[data2, fs2] = wavread('503-voice.wav');      %ikala库原音频分离后的人声
[ps2, nf2] = yaapt(data2, fs2, 1, [], 0, 2);  %用 yaapt（）函数计算音高轨迹.计算的音调跟踪被保存在长度为 nf的阵列音高中.
Pitch_fixed2=ptch_fix(ps2);
figure
plot(Pitch_fixed2, '.-');