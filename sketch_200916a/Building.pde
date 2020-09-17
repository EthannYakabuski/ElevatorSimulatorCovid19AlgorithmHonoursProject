class Building {
 
  int numRooms; 
  int numFloors; 
  
  ArrayList<Floor> floors = new ArrayList<Floor>();
  
  Building(int rooms, int floors) {
    
    numRooms = rooms; 
    numFloors = floors; 
    
  }
  
  
  void addFloor(Floor f) {
    floors.add(f);
    
    
  }
  
}
