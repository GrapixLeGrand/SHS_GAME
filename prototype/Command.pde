//different types of commands
public enum Command { CD; }

public static class CommandParser {
  
  public static Command parse(String input, Room room, Billy billy) {
    String commandName = input;
    String arguments = "";
    if (commandName.contains(" ")){
      int slicePos = input.indexOf(" ");
      commandName = commandName.substring(0, slicePos);
      arguments = input.substring(slicePos,  input.length()).trim();
      println(arguments);
    }
    
    switch (commandName) {
      case "cd" : return parseCDCommand(arguments, room, billy);
    }
    return null;
  }
  
  private static Command parseCDCommand(String destination, Room room, Billy billy){
    for (Item i : room.getItems()) {
      if (i.label.equals(destination)) {
        billy.setGoal(i);
        return Command.CD;
      }
    }
    return null;
  }
}
