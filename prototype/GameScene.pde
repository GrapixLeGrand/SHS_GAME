//a scene with a dunjeon and a terminal
class GameScene extends Scene{
  
  private PGraphics dunjeon;
  private PGraphics terminal;
  private Room currentRoom;
  private Command currentCommand;
  private Billy billy;
  
  private StringBuilder commandBuilder;
  
  public GameScene() {
    this.dunjeon = createGraphics(height*3/4, height*3/4);
    this.terminal = createGraphics(width, height/4);
    this.billy = new Billy(new PVector(dunjeon.width/2, dunjeon.height/2));
    this.currentCommand = null;
    commandBuilder = new StringBuilder();
    buildDunjeon();
  }
  
  public void draw() {
    if (currentCommand == Command.CD && billy.goalReached()) {
      currentCommand = null;
      moveToNextRoom();
    }
    currentRoom.update();
    billy.update();
    
    
    dunjeon.beginDraw();
    dunjeon.background(0);
    currentRoom.render(dunjeon);
    billy.render(dunjeon);
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
      billy.setPosition(cardinalToCoordinates(Position.values()[(d.cardinalPosition.ordinal() + 2)%4], currentRoom));
    }
  }
  
  private void buildDunjeon() {
    Room entrance = new Room("entrance", "room.png", dunjeon.width, dunjeon.height);
    Room roomA = new Room("room a", "room.png", dunjeon.width, dunjeon.height);
    Room roomB = new Room("room b", "room.png", dunjeon.width, dunjeon.height);
    Door door1 = new Door(Position.NORTH, roomB);
    entrance.addItem(door1);
    Door door2 = new Door(Position.SOUTH, entrance);
    roomB.addItem(door2);
    Door door3 = new Door(Position.WEST, roomA);
    entrance.addItem(door3);
    Door door4 = new Door(Position.EAST, entrance);
    roomA.addItem(door4);
    
    currentRoom = entrance;
  }
  
  private void drawTerminal() {
    terminal.text(commandBuilder.toString(), 10, 10);
  }
  
  public void keyPressed() {
    if (currentCommand == null) {
      if (key == ENTER || key == RETURN) {
        String newCommand = commandBuilder.toString().trim();
        currentCommand = CommandParser.parse(newCommand, currentRoom, billy);
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
