class Floor {
  
  int floorID;
  
  ArrayList<Room> rooms = new ArrayList<Room>();
  
  Floor() {
    
    
  }
  
  Floor(int id) {
   floorID = id; 
    
  }
  
  Floor(ArrayList<Room> roomsList, int id) {
    rooms = roomsList; 
    floorID = id;
    
    
  }
  
  void addRoom(Room r) {
   rooms.add(r); 
    
  }
  
  void addRoomsList(ArrayList<Room> roomsList) {
    rooms = roomsList; 
  }
  
  void addTenant(Person p, int room) {
   
    //if the requested room has not yet been created, create it and add to the backing arraylist
    //note that this if statement will only be run on each new tenant ONCE per room
    if(rooms.size() <= room) {
      rooms.add(new Room(room));
      
    }
    
    rooms.get(room).addTenant(p,room);
    
  }
  
  
  Room getRoom(int r) {
    
    
    if(r<=rooms.size()) {
      return rooms.get(r);
    }
    return new Room();
    
  }
  
  
  
}
