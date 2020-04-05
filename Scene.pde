
/**
 * Class representing the scene
 **/
class Scene {
  
  private ArrayList<Actor> actorList;
  private PGraphics renderingSurface;
  private PImage backGround;
  
  /**
   * Scene constructor 
   **/  
  Scene(PGraphics renderingSurface, String backGroundImgName) {
    actorList = new ArrayList();
    backGround = loadImage(backGroundImgName);
    this.renderingSurface = renderingSurface;
  }
  
  void update() {
    
    for (Actor a : actorList) {
      a.update();
    }  
    
  }
  
  void render() {
    
    //first we render the background
    renderingSurface.beginDraw();
    renderingSurface.background(backGround);
    renderingSurface.endDraw();
    image(renderingSurface, 0, 0);
    
    //second we render all the actor on the screen
    for (Actor a : actorList) {
      a.render();
    }  
    
  }
  
  void addActor(Actor a) {
    actorList.add(a);
  }

}
