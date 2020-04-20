
//This file should contains everything related to inputs

//theses booleans are true if the key is pressed / held down and false otherwise
boolean wKey, aKey, sKey, dKey;

void mouseClicked() {
  println(mouseX + " " + mouseY);
}

PVector mouseXYUpdate() {
  return new PVector(mouseX, mouseY);
}

void keyReleased() {
  
  if (key == 'w') {
    wKey = false;
  } 
  if (key == 'a') {
    aKey = false;
  } 
  if (key == 'd') {
    dKey = false;
  }
  
  if (key == 's') {
    sKey = false;
  }
}

void keyPressed() {
 
  if (key == 'w') {
    wKey = true;
  } 
  if (key == 'a') {
    aKey = true;
  } 
  if (key == 'd') {
    dKey = true;
  }
  if (key == 's') {
    sKey = true;
  }
}
