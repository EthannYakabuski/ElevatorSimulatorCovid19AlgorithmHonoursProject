class Job {
  int id; 
  int passengerID;
  int pickup; 
  int dest;
  int tripLength; 
  int roomDest; 
  
  boolean elevatorComing = false;
  
  boolean pickedUp = false;
  boolean droppedOff = false; 
  
  int elevatorAccepted = 0; 
  
  int delayFrames = 0; 
  
  Job() {
   id = -1; 
   pickup = 0; 
   dest = 0; 
   passengerID = 0;
    
  }
  
  int getPickup() {
    return pickup;  
  }
  
  int getDestination() {
    return dest;
  }
  
  int getID() {
    return id; 
  }
  
  int getPassengerID() {
    return passengerID; 
    
  }
  
  int getDelay() {
    return delayFrames; 
  }
  
  void setDelay(int d) {
    delayFrames = d; 
  }
  
  boolean getPickedUp() {
    return pickedUp; 
  }
  
  void setPickedUp(boolean p) {
    pickedUp = p; 
  }
  
  void setElevatorComing(boolean eC) {
    elevatorComing = eC; 
    
  }
  
  void tickAccepted() {
    
    elevatorAccepted++;
  }
  
  int getElevatorAccepted() {
    return elevatorAccepted; 
  }
  
  
  
  
  Job(int i, int p, int d, int pID) {
   id = i; 
   pickup = p; 
   dest = d; 
   passengerID = pID; 
  }
  
  Job(int i, int p, int d, int r, int pID, int delay) {
   id = i; 
   pickup = p; 
   dest = d; 
   roomDest = r;
   passengerID = pID; 
   delayFrames = delay;
  }
  
  
  
  
  int calculateTripLength() {
      return abs(pickup-dest);
    
  }
  
  String toString() {
   String returnString = "id: "+id;
   return returnString;
  }
  
  
  
}
    
