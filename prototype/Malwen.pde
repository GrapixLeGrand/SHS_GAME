
final int WITCH_WIDTH = 150;
final int WITCH_HEIGHT = 100;

class Malwen extends Actor {
  
  private Map<Room, String> words;
  private boolean isEnable = true;
  private String malwenImageUrl = "data/witch.jpg";
  private Timer timer;
  private PImage sprite;
  private PVector position;
  private PVector textPosition;
  private String currentText = null;
  
  Malwen(PVector position, PVector textPosition) {
    this.position = position.copy();
    sprite = loadImage(malwenImageUrl);
    sprite.resize(WITCH_WIDTH, WITCH_HEIGHT);
    words = new HashMap();
    timer = new Timer();
    this.textPosition = textPosition.copy();
  }
  
  public void addRoomAndText(Room r, String s) {
    if (r != null && s != null)
      words.put(r, s);
  }
  
  public void setEnableMalwen(boolean enable) {
    this.isEnable = enable;
  }
  
  void update() {
    
     timer.update();
     currentText = words.get(gameScene.currentRoom);
     if (currentText == null) {
       isEnable = false;
     } else {
       isEnable = true;
     }
     
     if (isEnable) {
       
     }
  }
  
  void render() {
    if (isEnable) {
      //dunjeon.image(sprite, this.position.x, this.position.y);
      if (currentText != null)  {
        dunjeon.pushMatrix();
        dunjeon.pushStyle();
        dunjeon.textSize(18);
        dunjeon.fill(200, 0, 0);
        dunjeon.textAlign(CENTER, CENTER);
        dunjeon.translate(width / 2 - 110, height / 2);
        dunjeon.text(currentText, 0, 0);
        dunjeon.popStyle();
        dunjeon.popMatrix();
      }
    }
  }
  
}
