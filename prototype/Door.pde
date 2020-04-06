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
    
    this.position = cardinalToCoordinates(position, room);
  }
  
  public void render(PGraphics surface) {
    surface.textAlign(CENTER, TOP);
    switch (cardinalPosition) {
      case NORTH : 
        surface.image(sprite, surface.width/2-DOOR_WIDTH/2, 0);
        surface.text(label, surface.width/2, 0);
        break;
      case EAST :
        surface.textAlign(RIGHT, TOP);
        surface.image(sprite, surface.width-DOOR_WIDTH, surface.height/2 - DOOR_HEIGHT/2);
        surface.text(label, surface.width, surface.height/2 - DOOR_HEIGHT/2);
        break;
      case WEST :
        surface.textAlign(LEFT, TOP);
        surface.image(sprite, 0, surface.height/2 - DOOR_HEIGHT/2);
        surface.text(label, 0, surface.height/2 - DOOR_HEIGHT/2);
        break;
      case SOUTH :
        surface.textAlign(CENTER, BOTTOM);
        surface.image(sprite, surface.width/2-DOOR_WIDTH/2, surface.height - DOOR_HEIGHT);
        surface.text(label, surface.width/2, surface.height);
        break;
    }
    
  }
  
  public Room nextRoom() {
      return nextRoom;
    }
}

public enum Position {NORTH, EAST, SOUTH, WEST;}

//convert a cardinal value (north, south...) in a position in a room)
public PVector cardinalToCoordinates(Position p, Room room){
  switch(p) {
      case NORTH : return new PVector(room.width/2, DOOR_HEIGHT/2);
      case SOUTH : return new PVector(room.width/2, room.height - DOOR_HEIGHT/2);
      case EAST: return new PVector(room.width - DOOR_WIDTH/2, room.height/2);
      case WEST: return new PVector(DOOR_WIDTH/2, room.height/2);
    }
    return null;
}
