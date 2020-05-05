//main character of the game
class Billy extends Actor {
  
  private PVector position;
  private Timer t;
  private PImage[] frames;
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
    frames = new PImage[4];
    frames[0] = loadImage(frontPath+"/Billy_front_walk-1.png");
    frames[1] = loadImage(frontPath+"/Billy_front_walk-2.png");
    frames[2] = loadImage(frontPath+"/Billy_front_walk-3.png");
    frames[3] = loadImage(frontPath+"/Billy_front_walk-4.png");
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
      //direction = 1;
      position.x += velocity;
    } else if (position.x > goal.position.x) {
      //direction = -1;
      position.x -= velocity;
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
      frames[0] = loadImage(frontPath+"/Billy_front_walk-1.png");
      frames[1] = loadImage(frontPath+"/Billy_front_walk-2.png");
      frames[2] = loadImage(frontPath+"/Billy_front_walk-3.png");
      frames[3] = loadImage(frontPath+"/Billy_front_walk-4.png");
      
    } else if (position.y > goal.position.y) {
      position.y -= velocity;
      
      frames[0] = loadImage(backPath+"/Billy_back_walk-1.png");
      frames[1] = loadImage(backPath+"/Billy_back_walk-2.png");
      frames[2] = loadImage(backPath+"/Billy_back_walk-3.png");
      frames[3] = loadImage(backPath+"/Billy_back_walk-4.png");
    }
  }
  
  public void setPosition(PVector position) {
    this.position = position;
  }
  
  public void setGoal(Item goal) {
    this.goal = goal;
  }
  
}
