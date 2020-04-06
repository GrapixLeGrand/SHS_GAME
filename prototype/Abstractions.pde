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
   * render the actor on the given surface
  **/
  abstract void render(PGraphics surface);

}

//an item in a room
abstract class Item extends Actor {
  protected PVector position;
  protected PImage sprite;
  
  public String label;
  public final int width = 50;
  public final int height = 50;
  
  
  public void update() {}
  
  public void render(PGraphics surface) {
    surface.image(sprite, position.x-width/2, position.y-height/2);
    surface.textAlign(CENTER, BOTTOM);
    surface.text(label, position.x-width/2, position.y-height/2);
  }
}
