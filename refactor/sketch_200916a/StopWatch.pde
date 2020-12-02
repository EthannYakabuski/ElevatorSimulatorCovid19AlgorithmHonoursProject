class StopWatch { 
  
  boolean running = false; 
  String name = "default"; 
 
  int startTime = 0;  //will always be zero
  int elapsedTime = 0;  //ticks once per frame
  int totalTime = 0;  //the amount of frames the animation should go on for
  
  StopWatch() {
    
  }
  
  StopWatch(int s, int e, int t) {
    startTime = s; 
    elapsedTime = e; 
    totalTime = t; 
  }
  
 
  StopWatch(int s, int e, int t, String n) {
    startTime = s; 
    elapsedTime = e; 
    totalTime = t; 
    name = n;
    
  }
  
  //returns true if the stopwatch IS DONE
  //returns false if there is more time on the stopwatch
  boolean tickTime() {
    boolean returnValue = false;
    
    elapsedTime++; 
    if(elapsedTime >= totalTime) {
      returnValue = true; 
    }
    
    return returnValue;
    
    
  }
  
}
