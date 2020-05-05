
final int WITCH_WIDTH = 150;
final int WITCH_HEIGHT = 100;

class Malwen extends Actor {
  
  private Map<Room, String> words;
  private boolean isEnable = true;
  private String malwenImageUrl = "data/witch.jpg";
  private Timer timer;
  private PImage sprite;
  private PVector position;
  private String currentText = null;
  
  Malwen(PVector position) {
    this.position = position.copy();
    sprite = loadImage(malwenImageUrl);
    sprite.resize(WITCH_WIDTH, WITCH_HEIGHT);
    words = new HashMap();
    timer = new Timer();
  }
  
  public void addRoomAndText(Room r, String s) {
    if (r != null && s != null)
      words.put(r, s);
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
      dunjeon.image(sprite, this.position.x, this.position.y);
      if (currentText != null)  {
        
        dunjeon.text(currentText, this.position.x, this.position.y);
      }
    }
  }
  
}
