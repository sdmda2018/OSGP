import oscP5.*; 
import netP5.*; 
int originalTempo = 100; 

OscP5 oscP5;
int tempo; 
float grab; 

float point1; 
float point2; 
float point3; 
float totalPoint; 
float error; 

void setup(){
  size(200, 200, OPENGL); 
  background(255);
  
  oscP5 = new OscP5(this, 6666); 
}

void draw(){
  background(255); 
  textSize(30); 
  fill(0); 
  noStroke(); 
  
  if(originalTempo - tempo > originalTempo * 0.1){
     fill(60, 100, 255); 
     rect(0, 0, 200, 100);
     fill(0); 
     text(tempo, 20, 50);
     text("BPM", 100, 50);
  }
  else if(tempo - originalTempo > originalTempo * 0.1){
     fill(255, 100, 100); 
     rect(0, 0, 200, 100);
     fill(0); 
     text(tempo, 20, 50);
     text("BPM", 100, 50);
  }
  else{
     fill(50, 255, 50); 
     rect(0, 0, 200, 100);
     fill(0); 
     text(tempo, 20, 50);
     text("BPM", 100, 50);
  }
  float tmp = abs(tempo - originalTempo); 
  error = tmp / originalTempo; 
  //print(error); 
  point1 = 100 * (1 - error);
  
  if(grab == 0 || grab == 1)
    point2 = 60; 
    else
    point2 = 100; 
  
  totalPoint = 0.7 * point1 + 0.3 * point2; 
  text(totalPoint, 25, 150); 
}


void oscEvent(OscMessage theOscMessage){
  tempo = theOscMessage.get(0).intValue();
  grab = theOscMessage.get(1).floatValue(); 
  //print(r+" "); 
}