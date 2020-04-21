import java.util.*;

GameScene gameScene;
Scene currentScene;
float dt;
PGraphics dunjeon;
PGraphics terminal;
Billy billy;

//global variable for the sound
final PApplet application = this;

boolean testFunctionality = true;


void settings() {
  size(1000, 1000, P2D);
}

void setup() {
  dunjeon = createGraphics(height*3/4, height*3/4);
  terminal = createGraphics(width, height/4);
  billy = new Billy(new PVector(dunjeon.width/2, dunjeon.height/2));
  gameScene = new GameScene();
  currentScene = gameScene;
}

void draw() {
  
  if (testFunctionality){
    ArrayList<String> salut = new ArrayList();
    String[] fontList = PFont.list();
    for (int i = 0; i < fontList.length; i ++) {
      String s = fontList[i];
      if (s.contains("Computer") || s.contains("computer")) {
        salut.add(s);
      }
    }
    
    for (String k : salut) {
      println(k);
    }
    
  } else {
    currentScene.draw();
  }
}

void keyPressed() {
  currentScene.keyPressed();
}
