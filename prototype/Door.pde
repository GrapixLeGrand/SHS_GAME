final int DOOR_WIDTH = 50;
final int DOOR_HEIGHT = 75;

Sprite openDoorSprite;
Sprite closedDoorSprite;

Map<Collectible, Door> doorMap = new HashMap();

void initDoorSprites() {
  PImage tmp = loadImage("data/Background/Doors/Wall_door_open.png");
  tmp.resize(DOOR_WIDTH, DOOR_HEIGHT);
  openDoorSprite = new Sprite(tmp);
  PImage tmp2 = loadImage("data/Background/Doors/Wall_door_closed.png");
  tmp2.resize(DOOR_WIDTH, DOOR_HEIGHT);
  closedDoorSprite = new Sprite(tmp2);
}

//a door leading to another room
public class Door extends Item {
  
  //added sound to door
  private Sound doorSound;
  private String doorSoundPath = "data/door.mp3";
  private Sprite doorSprite;
  private Room nextRoom;
  public Position cardinalPosition;
  
  private boolean locked;
  
  public Door(Position position, Room room) {
    this.doorSprite = openDoorSprite;
    this.cardinalPosition = position;
    this.nextRoom = room;
    this.label = nextRoom.getName();
    this.locked = false;
    
    this.position = cardinalToCoordinates(position);
    
    //instanciate the door sound
    doorSound = new Sound(doorSoundPath);
  }
  
  public void update() {}
  
  private void drawDoor(PVector trans, float angle) {
    
     dunjeon.pushMatrix();
     dunjeon.translate(trans.x, trans.y);
     dunjeon.rotate(angle);
     this.doorSprite.drawSprite(dunjeon.width/2 - DOOR_WIDTH);
     dunjeon.popMatrix();
        
  }
  
  public void render() {
    dunjeon.pushStyle();
    dunjeon.textAlign(CENTER, TOP);
    dunjeon.textFont(font);
    dunjeon.textSize(20);
    switch (cardinalPosition) {
      case NORTH : 
        drawDoor(new PVector(DOOR_WIDTH / 2, 0), 0);
        //dunjeon.image(sprite, dunjeon.width/2-DOOR_WIDTH/2, 0);
        dunjeon.text(label, dunjeon.width/2, DOOR_HEIGHT + 10);
        break;
      case EAST :
        drawDoor(new PVector(dunjeon.width, DOOR_WIDTH/2), PI / 2);
        dunjeon.textAlign(RIGHT, TOP);
        dunjeon.text(label, dunjeon.width - (DOOR_HEIGHT - 10), dunjeon.height/2 - DOOR_HEIGHT/2);
        break;
      case WEST :
        drawDoor(new PVector(0, dunjeon.height - DOOR_WIDTH/2), - PI / 2);
        dunjeon.textAlign(LEFT, TOP);
        dunjeon.text(label, DOOR_HEIGHT + 10, dunjeon.height/2 - DOOR_HEIGHT/2);
        break;
      case SOUTH :
        drawDoor(new PVector(dunjeon.width - DOOR_WIDTH/2 , dunjeon.height), PI);
        dunjeon.textAlign(CENTER, BOTTOM);
        dunjeon.text(label, dunjeon.width/2, dunjeon.height - (DOOR_HEIGHT + 10));
        break;
    }
    dunjeon.popStyle();
    
  }
  
  public Room nextRoom() {
      return nextRoom;
    }
  
  public void makeSound() {
    doorSound.Play();
  }
  
  public boolean locked() {
    return locked;
  }
  
  public void lockDoor(Collectible doorKey) {
    doorMap.put(doorKey, this);
    locked = true;
    doorSprite = closedDoorSprite;
  }
  
  public void unlockDoor() {
    locked = false;
    doorSprite = openDoorSprite;
  }
  
}




//convert a cardinal value (north, south...) in a position in a the scene)
public PVector cardinalToCoordinates(Position p){
  switch(p) {
      case NORTH : return new PVector(dunjeon.width/2, DOOR_HEIGHT/2 + 10);
      case SOUTH : return new PVector(dunjeon.width/2, dunjeon.height - (DOOR_HEIGHT/2 + 10));
      case EAST: return new PVector(dunjeon.width - (DOOR_HEIGHT/2 + 10), dunjeon.height/2);
      case WEST: return new PVector(DOOR_HEIGHT/2 + 10, dunjeon.height/2);
    }
    return null;
}
