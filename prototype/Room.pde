
class Room extends Actor {
  
  private List<Item> items;
  private String name;
  private PImage background;
  
  private Wall w;
  
  Room(String name, String backgroundUrl) {
    this.name = name;
    this.background = loadImage(backgroundUrl);
    this.items = new ArrayList<Item>();
    w = new Wall("data/Background/Wall_circuit.png", Position.NORTH, new PVector(0,0));
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
    
    /*
     * here we draw the walls
    */
   
    
    for (Item i : items) {
      i.render();
    }
    
     w.render();
  }
  
  public String getName() {
    return name;
  }
  
  public List<Item> getItems() {
    return new ArrayList(items);
  }
}  
