//different types of commands
enum Command { 
  CD, CAT, ECHO, help, git;
}

Command parse(String input) {
  String commandName = input; //<>//
  String arguments = "";
  if (commandName.contains(" ")) {
    int slicePos = input.indexOf(" ");
    commandName = commandName.substring(0, slicePos);
    arguments = input.substring(slicePos, input.length()).trim();
  }

  switch (commandName) {
    case "cd" : 
      return parseCDCommand(arguments);
    case "cat" :
      return parseCATCommand(arguments);
    case "echo" :
      return parseECHOCommand(arguments);
  case "help":
  println("a");
      gameScene.addToQueue("Tip 1: fend for yourself \nTip2: refer to 1");
      //cmdToAdd.add("Tip 1: fend for yourself \nTip2: refer to 1");
      //gameScene.addToDisplay("Tip 1: fend for yourself \nTip2: refer to 1", true);
      gameScene.manageAddedCommands();
      break;
  case "exit":
      gameScene.addToQueue("The only exit is death");
      gameScene.manageAddedCommands();
      //gameScene.addToDisplay("The only exit is death", true);
      break;
     case "pegi --set 18":
      gameScene.addToQueue("Hold on ! You're too young for that !");
      gameScene.manageAddedCommands();
      //gameScene.addToDisplay("The only exit is death", true);
      break;
  case "sudo":
      gameScene.addToQueue("Unknown command ! \n Do you mean \"Sudoku\"?");
      gameScene.manageAddedCommands();
      //gameScene.addToDisplay("The only exit is death", true);
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
      if (i instanceof Collectible && !((Collectible) i).available) {
        break;
      }
      gameScene.roomStack.push(gameScene.currentRoom);
      billy.setGoal(i);
      return Command.CD;
    }
  }
  return null;
}

Command parseCATCommand(String label) {
  for (Item i : gameScene.currentRoom.getItems()) { //<>//
    if (i.label.equals(label) && i instanceof File) {
      File f = (File) i;
      gameScene.addToQueue(f.content);
      gameScene.manageAddedCommands();
      return null;
    }
  }
  
  return null;
  
}

Command parseECHOCommand(String text) {
  for (Item i : gameScene.currentRoom.getItems()) {
    if (i instanceof Captcha) {
      Captcha c = (Captcha) i;
      if (text.startsWith("I am not a robot") || text.startsWith("I'm not a robot")) {
        c.answerPositive();
      }
      else {
        c.answerNegative();
      }
      return null;
    }
  }
  return null;
}
