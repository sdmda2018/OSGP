# Singing-Evaluation-System
Singing Evaluation System based on Singing Voice Separation

基于歌唱声分离的歌唱评价系统

This project can perform vocal separation, pitch tracking, and scoring operations on the input vocals collected with the ikala library

本项目可以对输入的以ikala库为标本采集的歌声实行歌唱声分离、音高跟踪和打分操作

#Features
* Singing Voice Separation based on DeepConvSep
* Pitch tracking based on YAAPT
* Singing Evaluation

# Requirements
aoftware:python 2.7(climate, numpy, scipy, cPickle, theano, lasagne),Matlab R2014b

OS:windows 8.1 Professinal 2013

No other software or library requirements.

没有其他的软件或库要求

#Install
Install python 2.7,Matlab R2014b directly

climate, numpy, scipy, cPickle, theano, lasagne

The dependencies can be installed with pip:

依赖关系可以使用pip进行安装：

> pip install numpy scipy pickle cPickle climate theano
 pip install https://github.com/Lasagne/Lasagne/archive/master.zip

#Usage
Download the code and sample music and run the following example

下载代码和示例音频如下示例所示运行即可

Singing voice source separation in DeepConvSep/separate_ikala.py :

在DeepConvSep/separate_ikala.py中唱歌语音源分离：

    python separate_ikala.py -i <inputfile> -o <outputdir> -m fft_1024.pkl

where :

- \<inputfile\> is the wav file to separate
- <inputfile>是要分离的wav文件
- \<outputdir\> is the output directory where to write the separation
- <outputdir>是写入分隔的输出目录

Pitch tracking use yaapt/test.m directly

直接运行yaapt/test.m便可得到音高跟踪

Singing Evaluation use yaapt/SingingEvaluation.m directly

直接运行yaapt/SingingEvaluation.m便可得到评价分数
#TO-do list
 完善其余的符号识别

# License

CC0 1.0 Universal
