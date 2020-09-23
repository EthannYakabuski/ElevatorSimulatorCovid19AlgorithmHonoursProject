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
  
  Person(int pID, int fl, int ro) {
    personID = pID; 
    floor = fl; 
    room = ro;
    
   
  }
  
  
  //getters and setters
  void setJob(Job j) {
    currentTask = j; 
  }
  
  Job getJob() {
    return currentTask; 
  }
  
  int getPID() {
    return personID; 
  }
  
  int getJobLength() {
    
    
    return currentTask.calculateTripLength();
    
  }
  
  
  String attendanceCall() {
    
    
    return str(personID); 
  }
  
  
  
}
