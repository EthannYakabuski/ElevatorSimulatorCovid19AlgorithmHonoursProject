class Person {
  
 
  
  int personID;
  String name; 
  
  //if job tripLength is 0 this means that there is no job
  //if the job tripLength is > 0, then this person is queuing for the elevator
  Job currentTask = new Job();
  
  boolean waiting = false;
  
  boolean ridingInElevator = false;
  
  int floor; 
  int room;
  
  int framesWaitedForElevator = 0;
  int framesSpendOnElevator = 0; 
  
  Person() {
    personID = -1; 
  }
  
  Person(int pID, int fl, int ro) {
    personID = pID; 
    floor = fl; 
    room = ro;
    
   
  }
  
  
  //getters and setters
  void resetStatisticFrames() {
    framesWaitedForElevator = 0; 
    framesSpendOnElevator = 0; 
    
  }
  
  int getFramesWaitedForElevator() {
    return framesWaitedForElevator;
  }
  int getFramesSpendOnElevator() {
    return framesSpendOnElevator; 
  }
  
  void tickStatisticsFrames() {
    if(waiting) {
      framesWaitedForElevator++; 
    }
    
    if(ridingInElevator) {
      framesSpendOnElevator++; 
    }
    
  }
  
  
  void setJob(Job j) {
    currentTask = j; 
  }
  
  Job getJob() {
    return currentTask; 
  }
  
  void setWaiting(boolean w) {
    waiting = w; 
  }
  
  int getPID() {
    return personID; 
  }
  
  int getJobLength() {
    
    
    return currentTask.calculateTripLength();
    
  }
  
  int getFloor() {
    return floor; 
    
    
  }
  
  int getRoom() {
    return room;
    
  }
  
  void flipRidingElevator() {
    if(ridingInElevator) {
      ridingInElevator = false; 
    } else {
      ridingInElevator = true; 
    }
  }
  
  String attendanceCall() {
    
    
    return str(personID); 
  }
  
  
  
}
