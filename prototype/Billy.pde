//main character of the game
class Billy extends Actor {
  
  private PVector position;
  private Timer t;
  private PImage frame1;
  private PImage frame2;
  private PImage frameShown;
  private int direction = 1;
  private float velocity = 10f;
  private Item goal;
  private boolean goalReached;
  private Door doorToOpen;
  
  public Billy(PVector origin) {
    this.position = origin;
    this.goal = null;
    this.frame1 = loadImage("frame1.png");
    this.frame2 = loadImage("frame2.png");
    this.t = new Timer();
    t.start();
  }
  
  public void render(PGraphics surface) {
    surface.pushMatrix();
    surface.translate(position.x, position.y);
    surface.scale(direction/2., 0.5);
    surface.image(frameShown, -frameShown.width / 2, -frameShown.height/ 2);
    surface.popMatrix();
  }
  
  public void update() {
    if (goal != null) {
      println(goal.position.x);
      if (position.x != goal.position.x) {
        moveHorizontally();
      } else if (position.y != goal.position.y) {
        moveVertically();
      } else {
        goalReached = true;
        if (goal instanceof Door) {
          doorToOpen = (Door) goal;
        }
        goal = null;
      }
    }
    
    t.update();
    if (t.getValue() > 400) {
      if (frameShown == frame1) 
        frameShown = frame2;
      else 
        frameShown = frame1;
        
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
      direction = 1;
      position.x += velocity;
    } else if (position.x > goal.position.x) {
      direction = -1;
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
    } else if (position.y > goal.position.y) {
      position.y -= velocity;
    }
  }
  
  public void setPosition(PVector position) {
    this.position = position;
  }
  
  public void setGoal(Item goal) {
    this.goal = goal;
    goalReached = false;
  }
  
  public boolean goalReached() {
    return goalReached;
  }
  
  public Door getDoorToOpen() {
    return doorToOpen;
  }
  
}
