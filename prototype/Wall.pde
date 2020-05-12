
public enum wall_type {NORM, CIRCUIT, FAN};

class Sprite extends Entity {
  
  private PImage sprite;
  
  Sprite(PImage spriteImg) {
     //this.sprite = spriteImg.copy();
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
      //animationSprites.add(img.copy());
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
  
  ArrayList<Integer> configuration;
  ArrayList<Sprite> wallSprites;
  
  Walls() {
    
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
  
  private void drawWalls(PVector trans, float angle) {
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
  
  public void render() {
    drawWalls(new PVector(0, 0), 0);
    drawWalls(new PVector(dunjeon.width, 0), PI / 2);
    drawWalls(new PVector(dunjeon.width, dunjeon.height), PI);
    drawWalls(new PVector(0, dunjeon.height), 3 * PI / 2);
  }

}
