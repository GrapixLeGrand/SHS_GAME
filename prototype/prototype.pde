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

ArrayList<PImage> wallFanSprites;
PImage wallSimpleSprite;
PImage wallCircuitSprite;

PImage wallSide;
PImage wallCornerTopLeft;
PImage wallCornerTopRight;
PImage wallCornerBottomLeft;
PImage wallCornerBottomRight;
PImage groundGrid;

String[] fanSpritesUrl = {
    "data/Background/Wall_2_fan/Wall_2_1_fan.png", 
    "data/Background/Wall_2_fan/Wall_2_2_fan.png", 
    "data/Background/Wall_2_fan/Wall_2_3_fan.png", 
    "data/Background/Wall_2_fan/Wall_2_4_fan.png", 
  };
  
void settings() {
  size(1000, 1000, P2D);
  
}

void setup() {
  frameRate(30);
  initRessources();
  font = loadFont("data/pixelFont.vlw");
  dunjeon = createGraphics(height*3/4, height*3/4);
  billy = new Billy(new PVector(dunjeon.width/2, dunjeon.height/2));
  gameScene = new GameScene();
  currentScene = gameScene;
}

void draw() {
  
  background(0);
  
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

void initRessources() {
  
  //load the different images, only one time
  wallSimpleSprite = loadImage("data/Background/Wall_simple.png");
  wallCircuitSprite = loadImage("data/Background/Wall_circuit.png");
  wallSimpleSprite.resize(DOOR_WIDTH, DOOR_HEIGHT);
  wallCircuitSprite.resize(DOOR_WIDTH, DOOR_HEIGHT);
  
  //loading images for the sides of the walls
  wallSide = loadImage("data/Background/Wall_side_left.png");
  wallCornerTopLeft = loadImage("data/Background/Corners/Wall_corner_up_left.png");
  wallCornerTopRight = loadImage("data/Background/Corners/Wall_corner_up_right.png");
  //wallCornerBottomLeft = loadImage("data/Background/Corners/Wall_Corner_down_left.png");
  //wallCornerBottomRight = loadImage("data/Background/Corners/Wall_corner_down_right.png");
  
  wallSide.resize(WALL_UNIT_WIDTH, WALL_UNIT_HEIGHT);
  wallCornerTopLeft.resize(WALL_UNIT_WIDTH, WALL_UNIT_HEIGHT);
  wallCornerTopRight.resize(WALL_UNIT_WIDTH, WALL_UNIT_HEIGHT);
  //wallCornerBottomLeft.resize(WALL_UNIT_WIDTH, WALL_UNIT_HEIGHT);
  //wallCornerBottomRight.resize(WALL_UNIT_WIDTH, WALL_UNIT_HEIGHT);
   
  //loading sprites for the animated wall sprites
  wallFanSprites = new ArrayList();
  wallFanSprites.add(loadImage("data/Background/Wall_2_fan/Wall_2_1_fan.png"));
  wallFanSprites.add(loadImage("data/Background/Wall_2_fan/Wall_2_2_fan.png"));
  wallFanSprites.add(loadImage("data/Background/Wall_2_fan/Wall_2_3_fan.png"));
  wallFanSprites.add(loadImage("data/Background/Wall_2_fan/Wall_2_4_fan.png"));
  
  for (PImage img : wallFanSprites) {
      img.resize(DOOR_WIDTH, DOOR_HEIGHT);
  }
  
  groundGrid = loadImage("data/Background/Wall_grid.png");
  groundGrid.resize(WALL_UNIT_HEIGHT, WALL_UNIT_HEIGHT);
  
}
