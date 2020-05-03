final int DOOR_WIDTH = 50;
final int DOOR_HEIGHT = 75;

//a door leading to another room
public class Door extends Item {
  
  //added sound to door
  private Sound doorSound;
  private String doorSoundPath = "door.mp3";
  private String openDoorPath = "data/Background/Doors/Wall_door_open.png";
  private Sprite doorSprite;
  private Room nextRoom;
  public Position cardinalPosition;
  
  public Door(Position position, Room room) {
    PImage tmp = loadImage(openDoorPath);
    tmp.resize(DOOR_WIDTH, DOOR_HEIGHT);
    this.doorSprite = new Sprite(tmp);
    this.cardinalPosition = position;
    this.nextRoom = room;
    this.label = nextRoom.getName();
    
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
    dunjeon.textAlign(CENTER, TOP);
    switch (cardinalPosition) {
      case NORTH : 
        drawDoor(new PVector(0, 0), 0);
        //dunjeon.image(sprite, dunjeon.width/2-DOOR_WIDTH/2, 0);
        dunjeon.text(label, dunjeon.width/2 - DOOR_WIDTH/2, 0);
        break;
      case EAST :
        drawDoor(new PVector(dunjeon.width, 0), PI / 2);
        dunjeon.textAlign(RIGHT, TOP);
        //dunjeon.image(sprite, dunjeon.width-DOOR_WIDTH, dunjeon.height/2 - DOOR_HEIGHT/2);
        dunjeon.text(label, dunjeon.width - DOOR_WIDTH/2, dunjeon.height/2 - DOOR_HEIGHT/2);
        break;
      case WEST :
        drawDoor(new PVector(dunjeon.width, dunjeon.height), PI);
        dunjeon.textAlign(LEFT, TOP);
        //dunjeon.image(sprite, 0, dunjeon.height/2 - DOOR_HEIGHT/2);
        dunjeon.text(label, 0, dunjeon.height/2 - DOOR_HEIGHT/2);
        break;
      case SOUTH :
        drawDoor(new PVector(0, dunjeon.height),  3 * PI / 2);
        dunjeon.textAlign(CENTER, BOTTOM);
        //dunjeon.image(sprite, dunjeon.width/2-DOOR_WIDTH/2, dunjeon.height - DOOR_HEIGHT);
        dunjeon.text(label, dunjeon.width/2 - DOOR_WIDTH/2, dunjeon.height);
        break;
    }
    
  }
  
  public Room nextRoom() {
      return nextRoom;
    }
  
  public void makeSound() {
    doorSound.Play();
  }
  
}




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
