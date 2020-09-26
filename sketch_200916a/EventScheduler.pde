class EventScheduler {
  
  
  
  ArrayList<Job> simulationEvents = new ArrayList<Job>();
  boolean waiting = true; 
  
  
  //keeps track of how many frames the scheduler should wait until spitting out the next event
  int currentDelayTotalFrames = 0; 
  
  //keeps track of how many frames of the current delay has already been served (running total)
  int currentDelayFramesServed = 0;
  
  EventScheduler() {
    
    
    
  }
  
  EventScheduler(ArrayList<Job> sE) {
    simulationEvents = sE; 
  }
  
  
  void addJob(Job j) {
    simulationEvents.add(j);
  }
  
  void setDelay(int delayFrames) {
    currentDelayTotalFrames = delayFrames; 
  }
  
  void clearEvents() {
    simulationEvents.clear(); 
    waiting = true; 
    currentDelayTotalFrames = 0; 
    currentDelayFramesServed = 0; 
  }
    
  
  
  
}
