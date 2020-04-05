class Timer {
  
  private long value;
  private long lastTime;
  private boolean run;
  
  Timer() {
  }
  
  void update() {
    if (run) {
      dt = millis() - lastTime;
      value += dt;
      dt = dt / 1000;
      lastTime = millis();
    }
  }
  
  long getValue() {
    return value;
  }
  
  void restart() {
    value = 0;
  }
  
  void stop() {
    run = false;
  }
  
  void start() {
    run = true;
  }
}
