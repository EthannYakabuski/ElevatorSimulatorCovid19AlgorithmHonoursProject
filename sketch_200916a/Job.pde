class Job {
  int id; 
  int passengerID;
  int pickup; 
  int dest;
  int tripLength; 
  
  boolean elevatorComing = false;
  
  int elevatorAccepted = 0; 
  
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
  
  
  
  int calculateTripLength() {
      return abs(pickup-dest);
    
  }
  
  String toString() {
   String returnString = "id: "+id;
   return returnString;
  }
  
  
  
}
    
