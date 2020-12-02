class PeopleStat {
  
  int framesWaitedOnElevator; 
  int framesWaitedForElevator; 
  
  PeopleStat() {
    
    
  }
  
  PeopleStat(int fwfe, int fwoe) {
    
    framesWaitedOnElevator = fwoe;
    framesWaitedForElevator = fwfe; 
  }
  
  
  int onElevator() {
    return framesWaitedOnElevator; 
  }
  
  int forElevator() {
    return framesWaitedForElevator; 
  }
  
  
  String makeString() {
    return framesWaitedOnElevator + ":" + framesWaitedForElevator; 
  }
  
  
}
