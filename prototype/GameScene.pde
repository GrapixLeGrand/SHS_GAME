
import java.util.Properties;
import javafx.util.Pair;


//a scene with a dunjeon and a terminal
class GameScene extends Scene {
  
  PGraphics terminal;
  public Room currentRoom;
  private Command currentCommand;
  private StringBuilder commandBuilder;
  private String backGroundMusicName = "data/proto.mpeg";
  public Stack<Room> roomStack;
  
  //font of our game
  private PFont font;
  private final String fontName = "data/pixelFont.vlw";
  //System.getProperty("user.name")
  private String welcomeMsg = "Welcome @" + System.getProperty("user.name") + ", DummyOS (" 
  + System.getProperty("os.arch") + ") \nProvided By Donald Trump";
  private Queue<Pair<String, Boolean>> printList;
  private ArrayList<Integer> lengthList;
  private int textSize = 23;
  
  Queue<String> cmdToAdd;
  
  private final int textOffsetX = 15;
  private final int textOffsetY = 30;
  private final String userName = System.getProperty("user.name");
  private String currentModifiedCmd = "";
  
  private int numDisplay = 0;
  
  private Sound bgMusic;
  
  public GameScene() {
    terminal = createGraphics(width, height/4);
    this.currentCommand = null;
    commandBuilder = new StringBuilder();
    roomStack = new Stack<Room>();
    buildDunjeon();
    printList = new ArrayDeque();
    cmdToAdd = new ArrayDeque();
    addToDisplay(welcomeMsg, true);
    //printList.add(new Pair(welcomeMsg, true));
    lengthList = new ArrayList(5);
    lengthList.add(2);
    //bgMusic = new Sound(backGroundMusicName);
    //bgMusic.Play();
    //make the music comes progressively during 10 secs
    //bgMusic.setAmpWithDuration(0.0, 0.5, 10000);
    
    font = loadFont(fontName);
    
    
  }
  
  public void draw() {
    
    //bgMusic.update();
    
    //println(numDisplay);
    
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
  
  private float computeWidth(String s) {
    float res = 0.0f;
    for (int i = 0; i < s.length(); i ++) {
      res += textWidth(s.charAt(i));
    }
    return res;
  }
  
  private void drawTerminal() {
    terminal.pushStyle();
    terminal.textFont(font);
    terminal.textSize(textSize);
    int i = 0;
    
    float luser = textOffsetX;
    float lat = luser + textSize * "user".length();
    float lname = lat + textSize;
    float lcmd = lname + textSize * (userName.length() + 1);
    
    for (Pair<String, Boolean> s : printList) {
      if (s.getValue()) {
        terminal.pushStyle();
        terminal.fill(0, 255, 0);
        terminal.text(s.getKey(), textOffsetX, textOffsetY * (++i + 1));
        terminal.popStyle();
      } else {
        terminal.pushStyle();
        terminal.fill(255, 0, 0);
        terminal.text("user", luser, textOffsetY * (++i + 1));
        terminal.fill(200, 12, 15);
        terminal.text("@", lat, textOffsetY * (i + 1));
        terminal.fill(10, 12, 255);
        terminal.text(userName + ">", lname, textOffsetY * (i + 1));
        terminal.fill(255, 255, 255);
        terminal.text(s.getKey(), lcmd, textOffsetY * (i + 1));
        terminal.popStyle();
      }
    }
    
    terminal.pushStyle();
    terminal.fill(255, 0, 0);
    terminal.text("user", luser, textOffsetY * (++i + 1));
    terminal.fill(200, 12, 15);
    terminal.text("@", lat, textOffsetY * (i + 1));
    terminal.fill(10, 12, 255);
    terminal.text(userName + ">", lname, textOffsetY * (i + 1));
    terminal.fill(255, 255, 255);
    terminal.text(currentModifiedCmd, lcmd, textOffsetY * (i + 1));
    terminal.popStyle();
    
    terminal.popStyle();
  }
  
  public void addToQueue(String s) {
    cmdToAdd.add(s);
  }
  
  public void addToDisplay(String s, boolean b) {
    
    String[] tmp = s.split("\n");
    
    
    
    for (String i : tmp) {
      printList.add(new Pair(new String(i), b));
      numDisplay ++;
    }
  }
  
  void manageAddedCommands() {
    
    for (String s : cmdToAdd) {
          addToDisplay(s, true);
        }
        
        cmdToAdd.clear();
        
        if (numDisplay > 4) {
          while(numDisplay > 4) {
            numDisplay--;
            printList.poll();
          }
        }
        
  }
  
  public void keyPressed() {
    if (currentCommand == null) {
      if (key == ENTER || key == RETURN) {
        println("b");
        String newCommand = commandBuilder.toString().trim();
        
        addToDisplay(newCommand, false);
        
        manageAddedCommands();
        
        currentModifiedCmd = new String("");
        currentCommand = parse(newCommand);
        commandBuilder = new StringBuilder();
      }
      else if (key == BACKSPACE && commandBuilder.length() > 0) {
        commandBuilder.deleteCharAt(commandBuilder.length() - 1);
        currentModifiedCmd = new String(commandBuilder.toString());
      }
      else if (key!=CODED && key!=BACKSPACE && key!=RETURN && key!=ESC && key!=DELETE) {
        commandBuilder.append(key);
        currentModifiedCmd = new String(commandBuilder.toString());
        lengthList.add(1);
      }
    }
  }

}
