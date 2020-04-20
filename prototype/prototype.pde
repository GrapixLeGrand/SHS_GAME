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
TaskTimer tt;

void settings() {
  size(1000, 1000, P2D);
}

void print_m() {
  print("fun print");
}

void setup() {
  dunjeon = createGraphics(height*3/4, height*3/4);
  terminal = createGraphics(width, height/4);
  billy = new Billy(new PVector(dunjeon.width/2, dunjeon.height/2));
  gameScene = new GameScene();
  currentScene = gameScene;
  tt = new TaskTimer();
  
}

void draw() {
  if (testFunctionality){
    
  } else {
    currentScene.draw();
  }
}

void keyPressed() {
  currentScene.keyPressed();
}
