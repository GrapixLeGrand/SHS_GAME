
class Room extends Actor {
  
  private List<Item> items;
  private String name;
  private PImage background;
  
  Room(String name, String backgroundUrl) {
    this.name = name;
    this.background = loadImage(backgroundUrl);
    this.items = new ArrayList<Item>();
  }
  
  public void addItem(Item item) {
    items.add(item);
  }
  
  public void update(){
    for (Item i : items) {
      i.update();
    }
  }
  
  public void render() {
    this.background.resize(dunjeon.width, dunjeon.height);
    dunjeon.image(background, 0, 0);
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
