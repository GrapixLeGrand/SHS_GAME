

//a scene with a dunjeon and a terminal
class GameScene extends Scene {
  
  public Room currentRoom;
  private Command currentCommand;
  private StringBuilder commandBuilder;
  private String backGroundMusicName = "testMusic2.mp3";
  public Stack<Room> roomStack;
  
  private Sound bgMusic;
  
  public GameScene() {
    this.currentCommand = null;
    commandBuilder = new StringBuilder();
    roomStack = new Stack<Room>();
    buildDunjeon();
    bgMusic = new Sound(backGroundMusicName);
    bgMusic.Play();
    //make the music comes progressively during 10 secs
    bgMusic.setAmpWithDuration(0.0, 1.0, 10000);
  }
  
  public void draw() {
    
    bgMusic.update();
    
    if (currentCommand == Command.CD && billy.goalReached()) {
      currentCommand = null;
      moveToNextRoom();
    }
    currentRoom.update();
    billy.update();
    
    
    dunjeon.beginDraw();
    dunjeon.background(0);
    currentRoom.render();
    billy.render();
    dunjeon.endDraw();
    
    terminal.beginDraw();
    terminal.background(0);
    drawTerminal();
    terminal.endDraw();
    
    image(dunjeon, height/8, 0);
    image(terminal, 0, 3*height/4);
  }
  
  private void moveToNextRoom() {
    Door d = billy.getDoorToOpen();
    if (d != null) {
      currentRoom = d.nextRoom();
      billy.setPosition(cardinalToCoordinates(Position.values()[(d.cardinalPosition.ordinal() + 2)%4]));
    }
  }
  
  private void buildDunjeon() {
    Room entrance = new Room("entrance", "room.png");
    Room roomA = new Room("room a", "room.png");
    Room roomB = new Room("room b", "room.png");
    Room roomC = new Room("room c", "room.png");
    Door door1 = new Door(Position.NORTH, roomB);
    entrance.addItem(door1);
    Door door2 = new Door(Position.SOUTH, entrance);
    roomB.addItem(door2);
    Door door3 = new Door(Position.WEST, roomA);
    entrance.addItem(door3);
    Door door4 = new Door(Position.EAST, entrance);
    roomA.addItem(door4);
    Door door5 = new Door(Position.EAST, roomC);
    roomB.addItem(door5);
    Door door6 = new Door(Position.WEST, roomB);
    roomC.addItem(door6);
    
    currentRoom = entrance;
  }
  
  private void drawTerminal() {
    terminal.text(commandBuilder.toString(), 10, 10);
  }
  
  public void keyPressed() {
    if (currentCommand == null) {
      if (key == ENTER || key == RETURN) {
        String newCommand = commandBuilder.toString().trim();
        currentCommand = parse(newCommand);
        commandBuilder = new StringBuilder();
      }
      else if (key == BACKSPACE && commandBuilder.length() > 0) {
        commandBuilder.deleteCharAt(commandBuilder.length() - 1);
      }
      else if (key!=CODED && key!=BACKSPACE && key!=RETURN && key!=ESC && key!=DELETE) {
        commandBuilder.append(key);
      }
    }
  }

}
