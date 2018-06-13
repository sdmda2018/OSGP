# Faceosc-control-System
Game Conttrol Design based on FaseOsc 

基于Faceosc的游戏控制设计

This project is through Faceosc to processing game to achieve action instructions, to achieve the use of Faceosc to achieve the face of the game contro

本项目是通过Faceosc对processing游戏实现动作指令，实现用Faceosc获取的人脸实现对游戏的控制 

#Features
* Facial expression tracking based on Faceosc
* Conversion of face data to OSC data stream based on Faceosc
* Data flow based on OSC can connect Faceosc to processing

# Requirements
aoftware:processing(3.3.7 the use of this subject),Faceosc

OS:windows oscP5（默认值为8338）

You need to download the OSC database in processing


没有其他的软件或库要求

#Install
Install prcossing 3.3.7;faceosc

The dependencies can be installed with pip:

Faceosc安装地址：

> https://github.com/kylemcdonald/ofxFaceTracker/releases

#Usage
Simple design of games with processing，Control games with Faceosc

Faceosc跟processing的连接如下示例所示的代码：
 import oscP5.*;
 OscP5 oscP5;

faceosc在跟踪人脸的特征部位：
// gesture
float mouthHeight;
float mouthWidth;
float eyeLeft;
float eyeRight;
把人脸特征（人脸位置，眼睛，嘴巴）转化为osc数据流：
   oscP5 = new OscP5(this, 8338);

    oscP5.plug(this, "found", "/found");
    
    oscP5.plug(this, "poseScale", "/pose/scale");
    
    oscP5.plug(this, "posePosition", "/pose/position");
    
    oscP5.plug(this, "poseOrientation", "/pose/orientation");
    
    oscP5.plug(this, "mouthWidthReceived", "/gesture/mouth/width");
    
    oscP5.plug(this, "mouthHeightReceived", "/gesture/mouth/height");
    
    oscP5.plug(this, "eyeLeftReceived", "/gesture/eye/left");
    
    oscP5.plug(this, "eyeRightReceived", "/gesture/eye/right");

  简单设计的游戏：
 // draw the game
  void draw()

  {

    image(bg, 0, 0, 800, 600);
    image(img,posePosition.x , posePosition.y, w,h);
    for (int i = 0; i < xs.size(); i++)
    {
      float x = (float) xs.get(i);
      float y = (float) ys.get(i);
      y += 5;
      if (y >= height)
      {
        y = -random(height);
      }
      image(ball, x, y, 30, 40);
      if (x > posePosition.x && x < posePosition.x + img.width && y > posePosition.y && y < posePosition.y + img.height)
      {
        score += 5;
        y = -random(height);
      }
      ys.set(i, y);
    }


#TO-do list

 完善其余的人脸特征的跟踪与动作指令的实现。
# License

CC0 1.0 Universal
