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
    gameScene.dunjeon.textAlign(CENTER, TOP);
    switch (cardinalPosition) {
      case NORTH : 
        gameScene.dunjeon.image(sprite, gameScene.dunjeon.width/2-DOOR_WIDTH/2, 0);
        gameScene.dunjeon.text(label, gameScene.dunjeon.width/2, 0);
        break;
      case EAST :
        gameScene.dunjeon.textAlign(RIGHT, TOP);
        gameScene.dunjeon.image(sprite, gameScene.dunjeon.width-DOOR_WIDTH, gameScene.dunjeon.height/2 - DOOR_HEIGHT/2);
        gameScene.dunjeon.text(label, gameScene.dunjeon.width, gameScene.dunjeon.height/2 - DOOR_HEIGHT/2);
        break;
      case WEST :
        gameScene.dunjeon.textAlign(LEFT, TOP);
        gameScene.dunjeon.image(sprite, 0, gameScene.dunjeon.height/2 - DOOR_HEIGHT/2);
        gameScene.dunjeon.text(label, 0, gameScene.dunjeon.height/2 - DOOR_HEIGHT/2);
        break;
      case SOUTH :
        gameScene.dunjeon.textAlign(CENTER, BOTTOM);
        gameScene.dunjeon.image(sprite, gameScene.dunjeon.width/2-DOOR_WIDTH/2, gameScene.dunjeon.height - DOOR_HEIGHT);
        gameScene.dunjeon.text(label, gameScene.dunjeon.width/2, gameScene.dunjeon.height);
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
      case NORTH : return new PVector(gameScene.dunjeon.width/2, DOOR_HEIGHT/2);
      case SOUTH : return new PVector(gameScene.dunjeon.width/2, gameScene.dunjeon.height - DOOR_HEIGHT/2);
      case EAST: return new PVector(gameScene.dunjeon.width - DOOR_WIDTH/2, gameScene.dunjeon.height/2);
      case WEST: return new PVector(DOOR_WIDTH/2, gameScene.dunjeon.height/2);
    }
    return null;
}
