//different types of commands
enum Command { 
  CD, help, git;
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
  case "help":
      gameScene.addToDisplay("Tip 1: fend for yourself \nTip2: refer to 1", true);
      break;
  case "exit":
      gameScene.addToDisplay("The only exit is death", true);
      break;
  }

  return null;
}

Command parseCDCommand(String destination) {
  if (destination.equals("..")){
    if (gameScene.roomStack.empty()){
      return null;
    }
    else {
      Room last = gameScene.roomStack.peek();
      for (Item i : gameScene.currentRoom.getItems()) {
        if (i instanceof Door) {
          Door d = (Door) i;
          if (d.nextRoom() == last) {
            gameScene.roomStack.pop();
            billy.setGoal(d);
            return Command.CD;
          }
        }
      }
    }
  }
  for (Item i : gameScene.currentRoom.getItems()) {
    if (i.label.equals(destination)) {
      gameScene.roomStack.push(gameScene.currentRoom);
      billy.setGoal(i);
      return Command.CD;
    }
  }
  return null;
}
