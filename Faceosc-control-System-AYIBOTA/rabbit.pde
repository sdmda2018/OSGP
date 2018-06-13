//
import oscP5.*;
OscP5 oscP5;


// num faces found
int found;

// pose
float poseScale;
PVector posePosition = new PVector();
PVector poseOrientation = new PVector();

// gesture
float mouthHeight;
float mouthWidth;
float eyeLeft;
float eyeRight;
float eyebrowLeft;
float eyebrowRight;
float jaw;
float nostrils;
  
  ////////
  int x = 200;
  int y = 430;
  PImage bg;
  PImage ball;
  PImage img;
  int w, h;
  int score = 0;
  ArrayList xs = new ArrayList();
  ArrayList ys = new ArrayList();

  // game setup
  void setup()
  {
    size(800, 600);
    noStroke();
    PFont font = loadFont("BubbleGum-22.vlw");
    textFont(font);
    textSize(32);
    bg = loadImage("bg1.png");
    ball = loadImage("carrot.png");
    img = loadImage("bunny14.png");
    w = img.width / 2;
    h = img.height / 2;

    for (int i = 0; i < 5; i++)
    {
      xs.add(random(width - 50));
      ys.add(-random(height));
    }
    
    oscP5 = new OscP5(this, 8338);
    oscP5.plug(this, "found", "/found");
    oscP5.plug(this, "poseScale", "/pose/scale");
    oscP5.plug(this, "posePosition", "/pose/position");
    oscP5.plug(this, "poseOrientation", "/pose/orientation");
    oscP5.plug(this, "mouthWidthReceived", "/gesture/mouth/width");
    oscP5.plug(this, "mouthHeightReceived", "/gesture/mouth/height");
    oscP5.plug(this, "eyeLeftReceived", "/gesture/eye/left");
    oscP5.plug(this, "eyeRightReceived", "/gesture/eye/right");
    oscP5.plug(this, "eyebrowLeftReceived", "/gesture/eyebrow/left");
    oscP5.plug(this, "eyebrowRightReceived", "/gesture/eyebrow/right");
    oscP5.plug(this, "jawReceived", "/gesture/jaw");
    oscP5.plug(this, "nostrilsReceived", "/gesture/nostrils");
  }

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

    text("Score: " + score, 10, 50);
    if (score >= 80)
    {
      textSize(100);
      fill(0, 0, 255); 
      img = loadImage("bunny14.png");
      image(img, posePosition.x, posePosition.y, w, h);
      
      text("Win!", 260, 300);
      noLoop();
    }
      stroke(0);
  
  if(found > 0) {
    translate(posePosition.x, posePosition.y);
    scale(poseScale);
    noFill();
    ellipse(5, eyeLeft+19 , 5, 5);
    ellipse(20, eyeRight+19 , 5, 5);
    ellipse(13, 30, mouthWidth-5, mouthHeight);
    
    fill(0);
  }
  }

  // handle keyCode pressed event
  void keyPressed()
  {
    if (keyCode == 37)
    {
      x -= 10;
      if (x < 0)
      {
        x = 0;
      }
    } else if (keyCode == 39)
    {
      x += 10;
      if (x >= width - w)
      {
        x = width - w;
      }
    }
  }
  
  
  // OSC CALLBACK FUNCTIONS

public void found(int i) {
  println("found: " + i);
  found = i;
}

public void poseScale(float s) {
  println("scale: " + s);
  poseScale = s;
}

public void posePosition(float x, float y) {
  println("pose position\tX: " + x + " Y: " + y );
  posePosition.set(x, y, 0);
}

public void poseOrientation(float x, float y, float z) {
  println("pose orientation\tX: " + x + " Y: " + y + " Z: " + z);
  poseOrientation.set(x, y, z);
}

public void mouthWidthReceived(float w) {
  println("mouth Width: " + w);
  mouthWidth = w;
}

public void mouthHeightReceived(float h) {
  println("mouth height: " + h);
  mouthHeight = h;
}

public void eyeLeftReceived(float f) {
  println("eye left: " + f);
  eyeLeft = f;
}

public void eyeRightReceived(float f) {
  println("eye right: " + f);
  eyeRight = f;
}

public void eyebrowLeftReceived(float f) {
  println("eyebrow left: " + f);
  eyebrowLeft = f;
}

public void eyebrowRightReceived(float f) {
  println("eyebrow right: " + f);
  eyebrowRight = f;
}

public void jawReceived(float f) {
  println("jaw: " + f);
  jaw = f;
}

public void nostrilsReceived(float f) {
  println("nostrils: " + f);
  nostrils = f;
}

// all other OSC messages end up here
void oscEvent(OscMessage m) {
  if(m.isPlugged() == false) {
    println("UNPLUGGED: " + m);
  }
}
