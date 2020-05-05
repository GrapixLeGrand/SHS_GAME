//main character of the game
class Billy extends Actor {
  
  private PVector position;
  private Timer t;
  private PImage[] frames;
  private PImage[] frontFrames;
  private PImage[] backFrames;
  private PImage[] leftFrames;
  private PImage[] rightFrames;
  private int frameShown;
  //private int direction = 1;
  private float velocity = 10f;
  private Item goal;
  private String dataPath = "data/Billy/Walk";
  private String frontPath = dataPath + "/Billy_front_walk";
  private String backPath = dataPath + "/Billy_back_walk";
  private String leftPath = dataPath + "/Billy_side_walk_left";
  private String rightPath = dataPath + "/Billy_side_walk_right";
  
  public Billy(PVector origin) {
    this.position = origin;
    this.goal = null;
    frontFrames = new PImage[4];
    frontFrames[0] = loadImage(frontPath+"/Billy_front_walk-1.png");
    frontFrames[1] = loadImage(frontPath+"/Billy_front_walk-2.png");
    frontFrames[2] = loadImage(frontPath+"/Billy_front_walk-3.png");
    frontFrames[3] = loadImage(frontPath+"/Billy_front_walk-4.png");
    backFrames = new PImage[4];
    backFrames[0] = loadImage(backPath+"/Billy_back_walk-1.png");
    backFrames[1] = loadImage(backPath+"/Billy_back_walk-2.png");
    backFrames[2] = loadImage(backPath+"/Billy_back_walk-3.png");
    backFrames[3] = loadImage(backPath+"/Billy_back_walk-4.png");
    leftFrames = new PImage[4];
    leftFrames[0] = loadImage(leftPath+"/Billy_side_walk_left-1.png.png");
    leftFrames[1] = loadImage(leftPath+"/Billy_side_walk_left-2.png.png");
    leftFrames[2] = loadImage(leftPath+"/Billy_side_walk_left-3.png.png");
    leftFrames[3] = loadImage(leftPath+"/Billy_side_walk_left-4.png.png");
    rightFrames = new PImage[4];
    rightFrames[0] = loadImage(rightPath+"/Billy_side_walk_right-1.png.png");
    rightFrames[1] = loadImage(rightPath+"/Billy_side_walk_right-2.png.png");
    rightFrames[2] = loadImage(rightPath+"/Billy_side_walk_right-3.png.png");
    rightFrames[3] = loadImage(rightPath+"/Billy_side_walk_right-4.png.png");
    this.frames = frontFrames;
    this.frameShown = 0;
    this.t = new Timer();
    t.start();
  }
  
  public void render() {
    dunjeon.pushMatrix();
    dunjeon.translate(position.x, position.y);
    //dunjeon.scale(direction/2., 0.5);
    dunjeon.scale(2);
    dunjeon.image(frames[frameShown], - (frames[frameShown]).width / 2, - (frames[frameShown]).height/ 2);
    dunjeon.popMatrix();
  }
  
  public void update() {
    if (goal != null) {
      if (position.x != goal.position.x) {
        moveHorizontally();
      } else if (position.y != goal.position.y) {
        moveVertically();
      } else {
        if (goal instanceof Door) {
          Door doorToOpen = (Door) goal;
          doorToOpen.makeSound();
          gameScene.currentRoom = doorToOpen.nextRoom();
          setPosition(cardinalToCoordinates(Position.values()[(doorToOpen.cardinalPosition.ordinal() + 2)%4]));
        }
        else if (goal instanceof Collectible) {
          Collectible c = (Collectible) goal;
          c.available = false;
          Door d = doorMap.get(c);
          d.unlockDoor();
        }
        goal = null;
      }
    }
    
    t.update();
    if (t.getValue() > 400) {
      frameShown = (frameShown + 1) % 4;
      t.restart();
    }
  }
  
  private void moveHorizontally() {
    if ((position.x < goal.position.x && position.x + velocity > goal.position.x)
      || (position.x > goal.position.x && position.x - velocity < goal.position.x)) {
        position.x = goal.position.x;
        return;
    }
      
    if (position.x < goal.position.x) {
      position.x += velocity;
      frames = rightFrames;
    } else if (position.x > goal.position.x) {
      position.x -= velocity;
      frames = leftFrames;
    }
  }
  
  private void moveVertically() {
    if ((position.y < goal.position.y && position.y + velocity > goal.position.y)
      || (position.y > goal.position.y && position.y - velocity < goal.position.y)) {
        position.y = goal.position.y;
        return;
    }
      
    if (position.y < goal.position.y) {
      position.y += velocity;
      frames = frontFrames;
      
    } else if (position.y > goal.position.y) {
      position.y -= velocity;
      
      frames = backFrames;
    }
  }
  
  public void setPosition(PVector position) {
    this.position = position;
  }
  
  public void setGoal(Item goal) {
    this.goal = goal;
  }
  
}
