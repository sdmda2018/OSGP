import oscP5.*;  
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;
int x=122;

void setup() {
  size(480,120);
  oscP5 = new OscP5(this, 12000);   //listening
  myRemoteLocation = new NetAddress("127.0.0.1", 5282);  //  speak to
}

void mousePressed() {
  OscMessage play = new OscMessage("/actions/play"); 
  oscP5.send(play, myRemoteLocation);
}



void draw() {

if (keyPressed) { 

if (keyCode == LEFT) {

  OscMessage prevMeasure = new OscMessage("/actions/play-prev-measure");  
  oscP5.send(prevMeasure, myRemoteLocation);

} 
if (keyCode == RIGHT) {

  OscMessage nextMeasure = new OscMessage("/actions/play-next-chord");  
  oscP5.send(nextMeasure, myRemoteLocation);
}
if (keyCode == UP) {
  x++;
    OscMessage tempoUp = new OscMessage("/tempo");  
    tempoUp.add(x);
  oscP5.send(tempoUp, myRemoteLocation);

}
if (keyCode == DOWN) {
  x--;
    OscMessage tempoDown = new OscMessage("/tempo");  
    tempoDown.add(x);
  oscP5.send(tempoDown, myRemoteLocation);

}

}



}