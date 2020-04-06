//different types of commands
enum Command { 
  CD;
}

Command parse(String input) {
  String commandName = input;
  String arguments = "";
  if (commandName.contains(" ")) {
    int slicePos = input.indexOf(" ");
    commandName = commandName.substring(0, slicePos);
    arguments = input.substring(slicePos, input.length()).trim();
  }

  switch (commandName) {
  case "cd" : 
    return parseCDCommand(arguments);
  }
  return null;
}

Command parseCDCommand(String destination) {
  for (Item i : gameScene.currentRoom.getItems()) {
    if (i.label.equals(destination)) {
      billy.setGoal(i);
      return Command.CD;
    }
  }
  return null;
}
