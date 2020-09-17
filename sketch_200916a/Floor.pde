class Floor {
  
  int floorID;
  
  ArrayList<Room> rooms = new ArrayList<Room>();
  
  Floor(ArrayList<Room> roomsList, int id) {
    rooms = roomsList; 
    floorID = id;
    
    
  }
  
  void addRoom(Room r) {
   rooms.add(r); 
    
  }
  
  
  
}
