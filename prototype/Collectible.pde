final int ITEM_WIDTH = 40;
final int ITEM_HEIGHT = 40;

//a door leading to another room
public class Collectible extends Item {
  
  boolean available;
  
  public Collectible(PVector position, String label, String path) {
    PImage tmp = loadImage(path);
    this.available = false;
    tmp.resize(ITEM_WIDTH, ITEM_HEIGHT);
    this.sprite = tmp;
    this.position = position;
    this.label = label;
  }
  
  public void update() {}
  
  public void render() {
    if (available) {
      super.render();
    }
  }
  
}
