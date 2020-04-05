
/**
  * Class that represent the main actor of the game
**/
class Billy extends Actor {
  
  private PVector pos;
  private PImage frame1;
  private PImage frame2;
  private PImage frameShowed;
  private int direction = 1;
  private Timer t;
  private float velocity = 500;
  
  /**
   * Constructor of Billy
   * @param : the original place where Billy will be placed  
  **/
  Billy (PVector origin) {
 
    pos = new PVector(origin.x, origin.y);
    frame1 = loadImage("frame1.png");
    frame2 = loadImage("frame2.png");
    frameShowed = frame1;
    t = new Timer();
    t.start();
    
  }
  
  void render() {
    pushMatrix();
    translate(pos.x, pos.y);
    scale(direction, 1);
    image(frameShowed, -frameShowed.width / 2, -frameShowed.height/ 2);
    popMatrix();
  }
  
  void update() {
  
    if (dKey) {
      direction = 1;
      pos.add(velocity * dt, 0);
    }
    
    if (aKey) {
      direction = -1;
      pos.add(-velocity * dt, 0);
    }
   
     if(wKey) {
      pos.add(0, -velocity * dt);
    }
    
    if(sKey) {
      pos.add(0, velocity * dt);
    }
    
    if (pos.y >= 720) {
      pos.y = 720;
    }
    
    if (pos.x >= 850) {
      pos.x = 850;
    }
    
    if (pos.x <= 0) {
      pos.x = 0;
    }
    
    t.update();
    
    if (t.getValue() > 400) {
      if (frameShowed == frame1) 
        frameShowed = frame2;
      else 
        frameShowed = frame1;
        
      t.restart();
    }
    
  }
 

}
