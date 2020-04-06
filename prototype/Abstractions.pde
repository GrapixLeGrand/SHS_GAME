//what is currently happening in the game
abstract class Scene {
  abstract void draw();
  abstract void keyPressed();
}

//an actor in the game
abstract class Actor {
  
  /**
   * update the states of an actor
  **/
  abstract void update();
  
  /**
   * render the actor on the game scene
  **/
  abstract void render();

}

//an item in a room
abstract class Item extends Actor {
  protected PVector position;
  protected PImage sprite;
  
  public String label;
  public final int width = 50;
  public final int height = 50;
  
  
  public void update() {}
  
  public void render() {
    dunjeon.image(sprite, position.x-width/2, position.y-height/2);
    dunjeon.textAlign(CENTER, BOTTOM);
    dunjeon.text(label, position.x-width/2, position.y-height/2);
  }
}
