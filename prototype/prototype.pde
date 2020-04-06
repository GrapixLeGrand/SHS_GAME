import java.util.*;

GameScene gameScene;
Scene currentScene;
float dt;

void settings() {
  size(1000, 1000, P2D);
}

void setup() {
  gameScene = new GameScene();
  currentScene = gameScene;
}

void draw() {
  currentScene.draw();
}

void keyPressed() {
  currentScene.keyPressed();
}
