import java.util.*;

GameScene gameScene;
Scene currentScene;
float dt;
PGraphics dunjeon;

Billy billy;

//global variable for the sound
final PApplet application = this;

final String fontName = "data/pixelFont.vlw";
PFont font;

boolean testFunctionality = false;


void settings() {
  size(1000, 1000, P2D);
}

void setup() {
  font = loadFont("data/pixelFont.vlw");
  dunjeon = createGraphics(height*3/4, height*3/4);
  billy = new Billy(new PVector(dunjeon.width/2, dunjeon.height/2));
  gameScene = new GameScene();
  currentScene = gameScene;
}

void draw() {
  
  if (testFunctionality){
    
    String[] a = "loubliv\ndwando".split("\n");
    for (String i : a) 
      println(i);
    //PFont font;
    //font = loadFont("data/pixelFont.vlw");
    
  } else {
    currentScene.draw();
  }
}

void keyPressed() {
  currentScene.keyPressed();
}
