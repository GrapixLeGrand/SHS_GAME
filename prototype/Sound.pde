

import processing.sound.*;

class Sound extends Entity {
  
  private int id;
  private SoundFile file;
  private float amplitude;
  
  private float fadeDuration;
  private boolean isFading;
  private float a;
  private float b;
  
  //internal timer to sound to make fade effect
  private Timer timer;
  
  Sound(String path) {
    
    this.id = path.hashCode();
    this.amplitude = 1.0f;
    file = new SoundFile(application, path);
    timer = new Timer();
  
  }
  
  void update() {
    
    timer.update();
    
    float currentTime = timer.getValue();
    println(currentTime);
    if (isFading && currentTime <= fadeDuration) {
      
      //computing the next amplitude value
      
      setAmp( a * currentTime + b );
      
    } else if (currentTime > fadeDuration) {
      
      timer.stop();
      timer.restart();
      isFading = false;
    }
    
  }
  
  /**
   * 
  */
  void setAmpWithDuration(float initialAmp, float targetAmp, float duration) {
    this.isFading = true;
    this.fadeDuration = duration;
    a = - 1.0 * (initialAmp - targetAmp) / duration;
    b = initialAmp;
    setAmp(b);
    timer.restart();
    timer.start();
  }
  
  public void setAmp(float amp) {
    if (amp >= 0.0 && amp <= 1.0) { 
      this.amplitude = amp;
      file.amp(this.amplitude);
    }
  }
  
  public float getAmplitude() {
    return this.amplitude;
  }
  
  public void Play() {
    file.play();
  }
  
  public void Pause() {
    file.pause();
  }
  
  public void Loop() {
    file.loop();
  }
  
  public void Stop() {
    file.stop();
  }
  
  public boolean isPlaying() {
    return file.isPlaying();
  }
  
  public int getId() {
    return id;
  }
  
}
