import java.util.*;

GameScene gameScene;
Scene currentScene;
float dt;
PGraphics dunjeon;
PGraphics terminal;
Billy billy;

boolean testSound = true;
Sound s;

void settings() {
  size(1000, 1000, P2D);
}

void setup() {
  dunjeon = createGraphics(height*3/4, height*3/4);
  terminal = createGraphics(width, height/4);
  billy = new Billy(new PVector(dunjeon.width/2, dunjeon.height/2));
  gameScene = new GameScene();
  currentScene = gameScene;
  s = new Sound(this, "door.mp3");
}

void draw() {
  if (testSound){
    
  } else {
    currentScene.draw();
  }
}

void keyPressed() {
  currentScene.keyPressed();
}
