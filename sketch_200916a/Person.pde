class Person {
  
 
  
  int personID;
  String name; 
  
  Job currentTask = new Job();
  
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
  
  
  String attendanceCall() {
    
    
    return str(personID); 
  }
  
}
