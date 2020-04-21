class Timer {
  
  private long value;
  private long lastTime;
  private boolean run;
  
  private boolean firstRun = true;
  
  Timer() {
  }
  
  void update() {
    
    if (run) {
      
      if (firstRun) {
        lastTime = millis();
        firstRun = false;
      }
      
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

import java.util.function.Function;
import java.util.concurrent.Callable;


class TaskTimer extends Timer {
  
  Callable<Void> c;
  
  void update() {
    super.update();
    execute(c);
  }
  
  void execute(Callable<Void> fun) {
    try {
      fun.call();
    } catch(Exception e) {
      print(e);
    }
  }
  
}
