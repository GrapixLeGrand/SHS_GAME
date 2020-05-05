final int FILE_WIDTH = 40;
final int FILE_HEIGHT = 40;

//a door leading to another room
public class File extends Item {
  
  String content;
  private String filePath = "data/Background/Doors/Wall_door_open.png";
  
  public File(PVector position, String label, String content) {
    PImage tmp = loadImage(filePath);
    tmp.resize(FILE_WIDTH, FILE_HEIGHT);
    this.sprite = tmp;
    this.position = position;
    this.label = label;
    this.content = content;
  }
  
  public void update() {}
  
}
