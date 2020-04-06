import java.util.*;

Scene scene;
float dt;

void settings() {
  size(1000, 1000, P2D);
}

void setup() {
  scene = new GameScene();
}

void draw() {
  scene.draw();
}

void keyPressed() {
  scene.keyPressed();
}
