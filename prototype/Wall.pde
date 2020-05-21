
public enum wall_type {NORM, CIRCUIT, FAN};
public enum Side {LEFT_SIDE, RIGHT_SIDE};

class Sprite extends Entity {
  
  private PImage sprite;
  
  Sprite(PImage spriteImg) {
     this.sprite = spriteImg;
  }
  
  void update() {
    
  }
  
  void drawSprite(float pos) {
    dunjeon.image(this.sprite, pos, 0);
  }
  
}

class AnimatedSprite extends Sprite {
  
  private Timer  timer;
  private ArrayList<PImage> animationSprites;
  private int index;
  private float speed = 50;
  
  AnimatedSprite(ArrayList<PImage> sprites, float speed) {
    super(sprites.get(0));
    animationSprites = new ArrayList();
    for (PImage img : sprites) {
      animationSprites.add(img);
    }
    this.speed = speed;
    timer = new Timer();
    timer.start();
  }
  void update() {
    timer.update(); 
    if (timer.getValue() > speed) {
      super.sprite = animationSprites.get(index);
      index ++;
      if (index >= animationSprites.size()) {
        index = 0;
      }
      timer.restart();
    }
  }
}

class Walls extends Actor {
  
  //private PImage sprite;
  //private PImage spriteWallSimple;
  private int wall_sprites_n = (dunjeon.width - 2 * WALL_UNIT_HEIGHT) / WALL_UNIT_WIDTH;
  private int wall_sprites_side_n = (dunjeon.width - 2 * WALL_UNIT_HEIGHT) / WALL_UNIT_HEIGHT;
  private int grid_n = 8;
  
  ArrayList<Integer> configuration;
  ArrayList<Sprite> wallSprites;
  ArrayList<Sprite> sideSpritesLeft;
  ArrayList<Sprite> sideSpritesRight;
 
  Sprite cornerRight;
  Sprite cornerLeft;
  
  Sprite ground;
  
  Walls() {
     
    ground = new Sprite(groundGrid);
    //println(wall_sprites_side_n);
    cornerRight = new Sprite(wallCornerTopRight);
    cornerLeft = new Sprite(wallCornerTopLeft);
    
    sideSpritesLeft = new ArrayList();
    sideSpritesRight = new ArrayList();
   
    for (int i = 0; i < wall_sprites_side_n; i++) {
      sideSpritesLeft.add(new Sprite(wallSide));
    }

    for (int i = 0; i < wall_sprites_side_n; i++) {
      sideSpritesRight.add(new Sprite(wallSide));
    }
    
    configuration = new ArrayList();
  
    for (int i = 0; i < wall_sprites_n; i ++) {
      configuration.add((int) random(0, 3));
    }
    
    wallSprites = new ArrayList();
    
    for (int i : configuration) {
      switch(i) {
        case 0:
          wallSprites.add(new Sprite(wallSimpleSprite));
        break;
        case 1:
          wallSprites.add(new Sprite(wallCircuitSprite));
        break;
        case 2:
          wallSprites.add(new AnimatedSprite(wallFanSprites, random(20, 200)));
        break;
      }
    }
  
  }
  
  public void update() {
    for (Sprite s : wallSprites) {
      s.update();
    }
  }
  
  void drawGrid() {
    for (int j = 0; j < grid_n; j ++) {
      for (int i = 0; i < grid_n; i ++) {
        dunjeon.pushMatrix();
        dunjeon.translate(0, WALL_UNIT_HEIGHT * (j + 1));
        ground.drawSprite(WALL_UNIT_HEIGHT * (i + 1));
        dunjeon.popMatrix();
      }
    }
  }
  
  final float WALL_SIDE_OFFSET = 25.0f;
  
  //meant to draw the side sprites wall
  private void drawWallsVertical(ArrayList<Sprite> sprites, PVector trans, float angle, Side side) {
    
    float factor = 1.0f;
    
    if (side == Side.LEFT_SIDE) {
      factor = - 1.0f;
    }
    
    int index = 0;
     for (int i = - wall_sprites_side_n / 2 + 1; i < wall_sprites_side_n / 2 + 1; i ++) {
       
          dunjeon.pushMatrix();
          dunjeon.translate(trans.x - factor * WALL_SIDE_OFFSET, trans.y);
          dunjeon.rotate(angle);
          dunjeon.pushMatrix();
          dunjeon.translate(dunjeon.width/2 - WALL_UNIT_HEIGHT * (i - 1), 0);
          dunjeon.rotate(PI / 2);
          sprites.get(index).drawSprite(0);
          dunjeon.popMatrix();
          index ++;
          dunjeon.popMatrix();
          
        }
  }
  
  //meant to draw the up and down sprites wall (the in front of the camera ones)
  private void drawWallsHorizontal(PVector trans, float angle) {
    int index = 0;
     for (int i = - wall_sprites_n / 2 + 1; i < wall_sprites_n / 2 + 1; i ++) {
          dunjeon.pushMatrix();
          dunjeon.translate(trans.x, trans.y);
          dunjeon.rotate(angle);
          wallSprites.get(index).drawSprite(dunjeon.width/2 - WALL_UNIT_WIDTH * i);
          index ++;
          dunjeon.popMatrix();
        }
  }
  
  void drawCornerWalls() {
    
    //draw right top
    dunjeon.pushMatrix(); 
    dunjeon.translate(dunjeon.width - WALL_UNIT_HEIGHT, 0);
    cornerRight.drawSprite(0);
    dunjeon.popMatrix();
    
    //draw right bottom
    dunjeon.pushMatrix(); 
    dunjeon.translate(dunjeon.width - WALL_SIDE_OFFSET, dunjeon.height);
    dunjeon.rotate(PI);
    cornerLeft.drawSprite(0);
    dunjeon.popMatrix();
    
    //draw left bottom
    dunjeon.pushMatrix(); 
    dunjeon.translate(WALL_SIDE_OFFSET + WALL_UNIT_WIDTH, dunjeon.height);
    dunjeon.rotate(-PI);
    cornerRight.drawSprite(0);
    dunjeon.popMatrix();
    
    //draw left top
    dunjeon.pushMatrix(); 
    dunjeon.translate(WALL_SIDE_OFFSET, 0);
    cornerLeft.drawSprite(0);
    dunjeon.popMatrix();
    
  }
  
  public void render() {
    drawWallsHorizontal(new PVector(0, 0), 0);
    drawWallsVertical(sideSpritesRight, new PVector(dunjeon.width, 0), PI / 2, Side.RIGHT_SIDE);
    drawWallsHorizontal(new PVector(dunjeon.width, dunjeon.height), PI);
    drawWallsVertical(sideSpritesLeft, new PVector(0, dunjeon.height), 3 * PI / 2, Side.LEFT_SIDE);
    drawCornerWalls();
    drawGrid();
  }

}
