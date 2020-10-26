class EventScheduler {
  
  
  
  ArrayList<Job> simulationEvents = new ArrayList<Job>();
  boolean waiting = true; 
  
  
  int masterFramesServed = 0; 
  
  //keeps track of how many frames the scheduler should wait until spitting out the next event
  int currentDelayTotalFrames = 0; 
  
  //keeps track of how many frames of the current delay has already been served (running total)
  int currentDelayFramesServed = 0;
  
  EventScheduler() {
    
    
    
  }
  
  EventScheduler(ArrayList<Job> sE) {
    simulationEvents = sE; 
  }
  
  Job getTopTask() {
    Job tempJob = simulationEvents.get(0); 
    simulationEvents.remove(0); 
    
    return tempJob; 
    
  }
    
  void setWaiting(boolean w) {
    waiting = w; 
  }
  
  ArrayList<Job> getSimulationEvents() {
    return simulationEvents; 
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
    
  void tick() {
   masterFramesServed++;  
   
   if(waiting) {
     currentDelayFramesServed++;
     //if the amounts of frames served is bigger or equal to the amount of frames the event was asked to delay for
     if(currentDelayFramesServed >= currentDelayTotalFrames) {
       waiting = false; 
       currentDelayFramesServed = 0;
     }
    }
  }
  
  boolean expelJob() {
   
    //if there are still jobs to process
    if(!waiting) { //and the scheduler is not currently on a delay
      if(simulationEvents.size() >= 1) {
        
        
        return true; 
      
      }
    }
    
   return false; 
    
   
    
  }
  
  
}
