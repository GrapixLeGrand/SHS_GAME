class PNJ extends Item {
  int PNG_WIDTH = 70;
  int PNG_HEIGHT = 50;
  
  public PNJ(PVector position) {
    this.position = position;
  }
  
  public void update() {}
  
  public void answer() {
  }
}

class Captcha extends PNJ {
  
  private String captchaPath = "data/old.png";
  
  public Captcha(PVector position) {
    super(position);
    PImage tmp = loadImage(captchaPath);
    tmp.resize(PNG_WIDTH, PNG_HEIGHT);
    this.sprite = tmp;
    this.label = "Captcha";
  }
  
  public void answerPositive() {
    gameScene.addToQueue("Captcha : Oh what a relief! I thought you were a robot!");
    gameScene.addToQueue("If you say you're not then I can safely give you this key");
    gameScene.addToQueue("Don't be shy, come and take it using the cd command");
    gameScene.manageAddedCommands();
    for (Item i : gameScene.currentRoom.getItems()) {
      if (i instanceof Collectible) {
        Collectible c = (Collectible) i;
        c.available = true;
      }
    }
  }
  
  public void answerNegative() {
    gameScene.addToQueue("Captcha : Don't talk to me, you filthy robot!");
    gameScene.manageAddedCommands();
  }
  
}
