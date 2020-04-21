import java.util.*;

GameScene gameScene;
Scene currentScene;
float dt;
PGraphics dunjeon;
PGraphics terminal;
Billy billy;

//global variable for the sound
final PApplet application = this;

boolean testFunctionality = false;
boolean started = false;
Timer testT;

void settings() {
  size(1000, 1000, P2D);
}

void setup() {
  testT = new Timer();
  testT.start();
  println("here at begin 1 : " + testT.getValue());
  dunjeon = createGraphics(height*3/4, height*3/4);
  terminal = createGraphics(width, height/4);
  billy = new Billy(new PVector(dunjeon.width/2, dunjeon.height/2));
  gameScene = new GameScene();
  currentScene = gameScene;
  println("here at begin 2 : " + testT.getValue());
  started = true;
}

void draw() {
  
  testT.update();
  //println("here at begin 3: " + testT.getValue());
  
  if (testFunctionality){
    
  } else {
    currentScene.draw();
  }
}

void keyPressed() {
  currentScene.keyPressed();
}
