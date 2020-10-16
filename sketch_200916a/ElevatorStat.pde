class ElevatorStat {
  
  int timeOpenedDoors = 0; 
  int timeClosedDoors = 0; 
  int passengersPickedUp = 0; 
  int passengersDroppedOff = 0; 
  
  
  ElevatorStat() {
    
    
  }
  
  
  void tickDoorOpen() { 
    timeOpenedDoors++; 
  }
 
  void tickClosedDoor() {
    timeClosedDoors++; 
  }
  
  
}
