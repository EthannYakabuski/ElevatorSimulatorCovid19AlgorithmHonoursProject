class Job {
  int id; 
  int passengerID;
  int pickup; 
  int dest;
  int tripLength; 
  
  
  Job() {
   id = 0; 
   pickup = 0; 
   dest = 0; 
   passengerID = 0;
    
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
  
  
  
}
    
