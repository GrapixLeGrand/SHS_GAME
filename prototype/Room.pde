
final int ROOM_BACKGROUND_WIDTH = 400;
final int ROOM_BACKGROUND_HEIGHT = 300;

class Room extends Actor {
  
  private List<Item> items;
  private String name;
  private PImage background;
  
  private Walls walls;
  
  Room(String name, String backgroundUrl) {
    this.name = name;
    this.background = loadImage(backgroundUrl);
    this.background.resize(ROOM_BACKGROUND_WIDTH, ROOM_BACKGROUND_HEIGHT);
    this.items = new ArrayList<Item>();
    walls = new Walls();
  }
  
  public void addItem(Item item) {
    items.add(item);
  }
  
  public void update(){
    walls.update();
    for (Item i : items) {
      i.update();
    }
  }
  
  public void render() {
    this.background.resize(dunjeon.width, dunjeon.height);
    dunjeon.image(background, 0, 0);
    
    walls.render();
    
    for (Item i : items) {
      i.render();
    }
    
  }
  
  public String getName() {
    return name;
  }
  
  public List<Item> getItems() {
    return new ArrayList(items);
  }
}  
