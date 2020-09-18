class Room {
  
  
  int roomID;
  
  Coordinate coorID = new Coordinate();
  
  int buttonPositionX;
  int buttonPositionY; 
  int buttonPositionXMax; 
  int buttonPositionYMax; 
  
  
  ArrayList<Person> tenants = new ArrayList<Person>();
  ArrayList<Person> currentlyHome = new ArrayList<Person>();
  
  Room() {
    roomID = -1; 
    
  }
  
  Room(int id) {
    
    roomID = id; 
    
  }
  
  Room(Coordinate c) {
    coorID = c; 
  }
  
  
  Room(ArrayList<Person> tenantsList, int id) {
    
    tenants = tenantsList; 
    roomID = id;
  }
  
  int getSize() {
    
      return tenants.size();
  }
  
  int getHomeSize() {
      return currentlyHome.size(); 
    
  }
  int getID() {
      return roomID;  
  }
  
  Coordinate getCoorID() {
    return coorID; 
  }
  
  void setCoorID(Coordinate c) {
    coorID = c; 
  }
  
  void addTenants(ArrayList<Person> tenantsList) {
   
    tenants = tenantsList;
    
  }
  
  ArrayList<Person> getTenantsList() {
    
    
    return tenants;
    
  }
  
  void addTenant(Person p) {
   tenants.add(p); 
   currentlyHome.add(p); 
    
  }
  
  void addTenant(Person p, int room) {
    tenants.add(p); 
    currentlyHome.add(p);
    
  }
  
  void removeTenant() {
    int personIDRemoved = 0; 
    
    if(tenants.size()>=1) {
      personIDRemoved = tenants.get(0).getPID();
      tenants.remove(0);
    }
    
    for(int i = 0; i < currentlyHome.size(); i++) {
      if(personIDRemoved == currentlyHome.get(i).getPID()) {
        currentlyHome.remove(i);
      }
    }
    
    
  }
  
  int determineQueueSize() {
    int peopleQueuing = 0; 
    
    for(int i = 0; i < currentlyHome.size(); i++) {
       if(tenants.get(i).getJobLength() > 0) { peopleQueuing++; }
      
    }
    return peopleQueuing;
  }
  
  Person getTenant(int i) {
    
    
    return tenants.get(i);
    
  }
  
  boolean determineStatus() {
    
    int waitLength = 0; 
    
    for(int i = 0; i < currentlyHome.size(); i++) {
      
       waitLength = waitLength + currentlyHome.get(i).getJobLength(); 
      
    }
    
    if(waitLength > 0) {
       return true; 
    } else {
       return false; 
    }
  }
  
}
