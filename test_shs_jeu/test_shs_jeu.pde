
import java.util.*;

PGraphics gameSurface;
PImage forest;
Billy billy;
Timer gameTimer;
float dt;
Scene mainScene;

/**
 * The settings method is supposed to be where we say to processing 
 * important things about the technical things of our game 
**/
void settings() {
  size(928, 793, P2D);
}

/**
 * The setup method is the place where the game is setup
**/
void setup() {
  
  //set the framerate of the game to 60 fps
  frameRate(60);
  //instantiating the draw board of the game
  gameSurface = createGraphics(928, 793, P2D);
  
  //creating a new Scene
  mainScene = new Scene(gameSurface, "Background.png");
  
  //creating the main actor
  billy = new Billy(new PVector(width / 2, height / 2));
  
  mainScene.addActor(billy);
  
  //setup of the main timer
  gameTimer = new Timer();
  gameTimer.start();
  
}

/**
 * The draw method is executed once at each frame and it is here that game
 * logic will take place 
**/
void draw() {
  
  gameTimer.update();
  
  mainScene.update();
  mainScene.render();
   
  PVector v = mouseXYUpdate();
  println(v.x + " " + v.y);
}
