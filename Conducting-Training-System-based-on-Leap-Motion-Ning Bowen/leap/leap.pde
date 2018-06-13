import de.voidplus.leapmotion.*; 

import oscP5.*; 
import netP5.*; 


int num = 0; //how many
OscP5 oscP5; 
NetAddress myLeapLocation; 
LeapMotion leap; 
int numFound = 0; //1 or 0
NetAddress myMuseLocation; 
NetAddress myResultLocation; 

float[] features = new float[3]; 
float grab;  
String[] messageNames = {"/output_1", "/output_2"}; 
// String[] messageNames = {"/output_1", "/output_2", "/output_3", "/output_4"}; 
int numClasses=messageNames.length;
float thisMoment; 
float lastMoment; 
int tempo;
int originalTempo = 100; 


void setup(){
  size(800, 500, OPENGL); 
  background(255);
  
  thisMoment = millis(); 
  lastMoment = thisMoment; 
  tempo = 0; 
  
  oscP5 = new OscP5(this, 12000);
  myLeapLocation = new NetAddress("127.0.0.1", 6448);
  myMuseLocation = new NetAddress("127.0.0.1", 5282); 
  myResultLocation = new NetAddress("127.0.0.1", 6666); 
  
  leap = new LeapMotion(this); 
  
  OscMessage rewind = new OscMessage("/actions/rewind"); 
  oscP5.send(rewind, myMuseLocation);
  
  OscMessage setTempo = new OscMessage("/tempo"); 
  setTempo.add(originalTempo); 
  oscP5.send(setTempo, myMuseLocation);
  
  OscMessage play = new OscMessage("/actions/play"); 
  oscP5.send(play, myMuseLocation);
  
  // sendInputNames();   
}

void draw() {
  background(255);
  // line(0, 250, 800, 250);  
  
  // ...
  int fps = leap.getFrameRate();


  // ========= HANDS =========
  numFound = 0;
  for (Hand hand : leap.getHands ()) {
      numFound++;

    // ----- BASICS -----

    int     hand_id          = hand.getId();
    PVector hand_position    = hand.getPosition(); //The center position of the palm in millimeters from the Leap Motion Controller origin. 
    PVector hand_stabilized  = hand.getStabilizedPosition();
    PVector hand_direction   = hand.getDirection();
    PVector hand_dynamics    = hand.getDynamics();
    float   hand_roll        = hand.getRoll();
    float   hand_pitch       = hand.getPitch();
    float   hand_yaw         = hand.getYaw();
    boolean hand_is_left     = hand.isLeft();
    boolean hand_is_right    = hand.isRight();
    float   hand_grab        = hand.getGrabStrength();
    float   hand_pinch       = hand.getPinchStrength();
    float   hand_time        = hand.getTimeVisible();
    PVector sphere_position  = hand.getSpherePosition();
    float   sphere_radius    = hand.getSphereRadius();


    // ----- SPECIFIC FINGER -----

    Finger  finger_thumb     = hand.getThumb();
    // or                      hand.getFinger("thumb");
    // or                      hand.getFinger(0);

    Finger  finger_index     = hand.getIndexFinger();
    // or                      hand.getFinger("index");
    // or                      hand.getFinger(1);

    Finger  finger_middle    = hand.getMiddleFinger();
    // or                      hand.getFinger("middle");
    // or                      hand.getFinger(2);

    Finger  finger_ring      = hand.getRingFinger();
    // or                      hand.getFinger("ring");
    // or                      hand.getFinger(3);

    Finger  finger_pink      = hand.getPinkyFinger();
    // or                      hand.getFinger("pinky");
    // or                      hand.getFinger(4);        


    // ----- DRAWING -----
    
     hand.draw();
    // hand.drawSphere();


    // ========= ARM =========

    if (hand.hasArm()) {
      Arm     arm               = hand.getArm();
      float   arm_width         = arm.getWidth();
      PVector arm_wrist_pos     = arm.getWristPosition();
      PVector arm_elbow_pos     = arm.getElbowPosition();
    }


    // ========= FINGERS =========

    for (Finger finger : hand.getFingers()) {
      // Alternatives:
      // hand.getOutstrechtedFingers();
      // hand.getOutstrechtedFingersByAngle();

      // ----- BASICS -----

      int     finger_id         = finger.getId();
      PVector finger_position   = finger.getPosition();
      PVector finger_stabilized = finger.getStabilizedPosition();
      PVector finger_velocity   = finger.getVelocity();
      PVector finger_direction  = finger.getDirection();
      float   finger_time       = finger.getTimeVisible();

      // ----- SPECIFIC BONE -----

      Bone    bone_distal       = finger.getDistalBone();
      // or                       finger.get("distal");
      // or                       finger.getBone(0);

      Bone    bone_intermediate = finger.getIntermediateBone();
      // or                       finger.get("intermediate");
      // or                       finger.getBone(1);

      Bone    bone_proximal     = finger.getProximalBone();
      // or                       finger.get("proximal");
      // or                       finger.getBone(2);

      Bone    bone_metacarpal   = finger.getMetacarpalBone();
      // or                       finger.get("metacarpal");
      // or                       finger.getBone(3);


      // ----- DRAWING -----

      // finger.draw(); // = drawLines()+drawJoints()
      // finger.drawLines();
      // finger.drawJoints();


      // ----- TOUCH EMULATION -----

      int     touch_zone        = finger.getTouchZone();
      float   touch_distance    = finger.getTouchDistance();

      switch(touch_zone) {
      case -1: // None
        break;
      case 0: // Hovering
        // println("Hovering (#"+finger_id+"): "+touch_distance);
        break;
      case 1: // Touching
        // println("Touching (#"+finger_id+")");
        break;
      }
    }
    // ========= TOOLS =========

    for (Tool tool : hand.getTools ()) {


      // ----- BASICS -----

      int     tool_id           = tool.getId();
      PVector tool_position     = tool.getPosition();
      PVector tool_stabilized   = tool.getStabilizedPosition();
      PVector tool_velocity     = tool.getVelocity();
      PVector tool_direction    = tool.getDirection();
      float   tool_time         = tool.getTimeVisible();


      // ----- DRAWING -----

       tool.draw();


      // ----- TOUCH EMULATION -----

      int     touch_zone        = tool.getTouchZone();
      float   touch_distance    = tool.getTouchDistance();

      switch(touch_zone) {
      case -1: // None
        break;
      case 0: // Hovering
        // println("Hovering (#"+tool_id+"): "+touch_distance);
        break;
      case 1: // Touching
        // println("Touching (#"+tool_id+")");
        break;
      }
    }
    features[0] = hand_position.x; 
    features[1] = hand_position.y;
    features[2] = hand_position.z;    
    grab = hand_grab; 
  }


  // ========= DEVICES =========

  for (Device device : leap.getDevices ()) {
    float device_horizontal_view_angle = device.getHorizontalViewAngle();
    float device_verical_view_angle = device.getVerticalViewAngle();
    float device_range = device.getRange();
  }
  
  // =========== OSC ============
 
  if (num % 3 == 0) {
     sendOsc();
  }
  num++;
  // print(features[0], features[1], features[2], "\n");  
  // sendOsc(); 
}


// ========= CALLBACKS =========

void leapOnInit() {
  // println("Leap Motion Init");
}
void leapOnConnect() {
  // println("Leap Motion Connect");
}
void leapOnFrame() {
  // println("Leap Motion Frame");
}
void leapOnDisconnect() {
  // println("Leap Motion Disconnect");
}
void leapOnExit() {
  // println("Leap Motion Exit");
}

void sendOsc(){
  OscMessage msg = new OscMessage("/wek/inputs"); 
  if (numFound > 0){
    for (int i = 0; i < features.length; i++){
      msg.add(features[i]); 
    }
  }
  else{
    for(int i = 0; i < features.length; i++){
      msg.add(0.); 
    }
  }
  oscP5.send(msg,myLeapLocation); 
}

void oscEvent(OscMessage theOscMessage) {
  int tmpTempo; 
  float multiTempo; 
 //println("received message");
 for (int i = 0; i < numClasses; i++) {
    if (theOscMessage.checkAddrPattern(messageNames[i]) == true) {
       //print(messageNames[i]);
       //print(millis(), ""); 
       //print(lastMoment, ""); 
       lastMoment = thisMoment; 
       thisMoment = millis();
       tmpTempo = int(60/((thisMoment - lastMoment)/1000));
       
       if(tmpTempo < originalTempo *0.5 || tmpTempo > originalTempo * 2){
         break; 
       }
       else{
         // multiTempo = tmpTempo; 
         multiTempo = 0.5 * tempo + 0.5 *tmpTempo; 
         tempo = int(multiTempo); 
      }
       print(grab, "\n"); 
       
       // text(tempo, 80, 50); 
       OscMessage newTempo = new OscMessage("/tempo"); 
       newTempo.add(tempo); 
       oscP5.send(newTempo, myMuseLocation); 
       
       newTempo.add(grab); 
       oscP5.send(newTempo, myResultLocation);
    }
 }
}