
import java.util.Properties;
import javafx.util.Pair;

//a scene with a dunjeon and a terminal
class GameScene extends Scene {
  
  PGraphics terminal;
  public Room currentRoom;
  private StringBuilder commandBuilder;
  private String backGroundMusicName = "data/sound/proto.mpeg";
  public Stack<Room> roomStack;
  
  //font of our game
  private String welcomeMsg = "Welcome @" + System.getProperty("user.name") + ", DummyOS (" 
  + System.getProperty("os.arch") + ") \nProvided By Donald Trump";
  private Queue<Pair<String, Boolean>> printList;
  private ArrayList<Integer> lengthList;
  private int textSize = 15;
  
  Queue<String> cmdToAdd;
  
  Map<Collectible, Door> doorMap;
  
  private final int textOffsetX = 15;
  private final int textOffsetY = 20;
  private final String userName = System.getProperty("user.name");
  private String currentModifiedCmd = "";
  
  private int numDisplay = 0;
  
  private Sound bgMusic;
  private Malwen malwen;
  
  public GameScene() {
    terminal = createGraphics(width, height/4);
    commandBuilder = new StringBuilder();
    roomStack = new Stack<Room>();
    malwen = new Malwen(new PVector(width / 2, height / 2));
    buildDunjeon();
    printList = new ArrayDeque();
    cmdToAdd = new ArrayDeque();
    addToDisplay(welcomeMsg, true);
    lengthList = new ArrayList(5);
    lengthList.add(2);
    //bgMusic = new Sound(backGroundMusicName);
    //bgMusic.Play();
    //bgMusic.Loop();
    //make the music comes progressively during 10 secs
    //bgMusic.setAmpWithDuration(0.0, 1.0, 2000);
    
    
  }
  
  public void draw() {
    
    //bgMusic.update();
    
    currentRoom.update();
    billy.update();
    malwen.update();
    
    dunjeon.beginDraw();
    dunjeon.background(0);
    currentRoom.render();
    billy.render();
    malwen.render();
    dunjeon.endDraw();
    
    terminal.beginDraw();
    terminal.background(0);
    drawTerminal();
    terminal.endDraw();
    
    image(dunjeon, height/8, 0);
    image(terminal, 0, 3*height/4);
  }
  
  private void buildDunjeon() {
    initDoorSprites();
    
    Room entrance = new Room("entrance", "room.png");
    Room nextRoom = new Room("room a", "room.png");
    Room captchaRoom = new Room("room b", "room.png");
    Room fileRoom = new Room("room c", "room.png");
    
    Door door1 = new Door(Position.NORTH, nextRoom);
    entrance.addItem(door1);
    Door door3 = new Door(Position.EAST, captchaRoom);
    entrance.addItem(door3);
    
    Door door2 = new Door(Position.SOUTH, entrance);
    nextRoom.addItem(door2);
    
    Door door4 = new Door(Position.WEST, entrance);
    captchaRoom.addItem(door4);
    Captcha captcha = new Captcha(new PVector(dunjeon.width/4, dunjeon.height/4));
    Collectible nextKey = new Collectible(new PVector(dunjeon.width/4, dunjeon.height/2), "key", "data/Background/Doors/Wall_door_open.png");
    door1.lockDoor(nextKey);
    captchaRoom.addItem(nextKey);
    captchaRoom.addItem(captcha);
    Door door5 = new Door(Position.SOUTH, fileRoom);
    captchaRoom.addItem(door5);
    
    Door door6 = new Door(Position.NORTH, captchaRoom);
    fileRoom.addItem(door6);
    File test = new File(new PVector(dunjeon.width/4, dunjeon.height/4), "file", "Hello, world!");
    fileRoom.addItem(test);
    
    malwen.addRoomAndText(roomA, "Salut poilu");
    malwen.addRoomAndText(roomB, "Coucou petit !");
    malwen.addRoomAndText(entrance, "Bienvenu chez ta mère");
    
    currentRoom = entrance;
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
        
        if (numDisplay > 6) {
          while(numDisplay > 6) {
            numDisplay--;
            printList.poll();
          }
        }
        
  }
  
  public void keyPressed() {
    if (billy.goal == null) {
      if (key == ENTER || key == RETURN) {
        String newCommand = commandBuilder.toString().trim();
        addToDisplay(newCommand, false);
        manageAddedCommands();
        currentModifiedCmd = new String("");
        parse(newCommand);
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
