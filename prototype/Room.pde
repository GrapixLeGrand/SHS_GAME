
class Room extends Actor {
  
  private List<Item> items;
  private String name;
  private PImage background;
  public float width;
  public float height;
  
  Room(String name, String backgroundUrl, float width, float height) {
    this.name = name;
    this.background = loadImage(backgroundUrl);
    this.items = new ArrayList<Item>();
    this.width = width;
    this.height = height;
  }
  
  public void addItem(Item item) {
    items.add(item);
  }
  
  public void update(){
    for (Item i : items) {
      i.update();
    }
  }
  
  public void render(PGraphics surface) {
    this.background.resize(surface.width, surface.height);
    surface.image(background, 0, 0);
    for (Item i : items) {
      i.render(surface);
    }
  }
  
  public String getName() {
    return name;
  }
  
  public List<Item> getItems() {
    return new ArrayList(items);
  }
}  
