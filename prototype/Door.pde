final int DOOR_WIDTH = 50;
final int DOOR_HEIGHT = 75;

//a door leading to another room
public class Door extends Item {
  private Room nextRoom;
  public Position cardinalPosition;
  
  public Door(Position position, Room room) {
    this.cardinalPosition = position;
    this.nextRoom = room;
    this.sprite = loadImage("door.png");
    this.sprite.resize(DOOR_WIDTH, DOOR_HEIGHT);
    this.label = nextRoom.getName();
    
    this.position = cardinalToCoordinates(position);
  }
  
  public void render() {
    dunjeon.textAlign(CENTER, TOP);
    switch (cardinalPosition) {
      case NORTH : 
        dunjeon.image(sprite, dunjeon.width/2-DOOR_WIDTH/2, 0);
        dunjeon.text(label, dunjeon.width/2, 0);
        break;
      case EAST :
        dunjeon.textAlign(RIGHT, TOP);
        dunjeon.image(sprite, dunjeon.width-DOOR_WIDTH, dunjeon.height/2 - DOOR_HEIGHT/2);
        dunjeon.text(label, dunjeon.width, dunjeon.height/2 - DOOR_HEIGHT/2);
        break;
      case WEST :
        dunjeon.textAlign(LEFT, TOP);
        dunjeon.image(sprite, 0, dunjeon.height/2 - DOOR_HEIGHT/2);
        dunjeon.text(label, 0, dunjeon.height/2 - DOOR_HEIGHT/2);
        break;
      case SOUTH :
        dunjeon.textAlign(CENTER, BOTTOM);
        dunjeon.image(sprite, dunjeon.width/2-DOOR_WIDTH/2, dunjeon.height - DOOR_HEIGHT);
        dunjeon.text(label, dunjeon.width/2, dunjeon.height);
        break;
    }
    
  }
  
  public Room nextRoom() {
      return nextRoom;
    }
}

public enum Position {NORTH, EAST, SOUTH, WEST;}

//convert a cardinal value (north, south...) in a position in a the scene)
public PVector cardinalToCoordinates(Position p){
  switch(p) {
      case NORTH : return new PVector(dunjeon.width/2, DOOR_HEIGHT/2);
      case SOUTH : return new PVector(dunjeon.width/2, dunjeon.height - DOOR_HEIGHT/2);
      case EAST: return new PVector(dunjeon.width - DOOR_WIDTH/2, dunjeon.height/2);
      case WEST: return new PVector(DOOR_WIDTH/2, dunjeon.height/2);
    }
    return null;
}
