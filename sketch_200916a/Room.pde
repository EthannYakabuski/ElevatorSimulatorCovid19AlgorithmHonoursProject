class Room {
  
  
  int roomID;
  
  ArrayList<Person> tenants = new ArrayList<Person>();
  
  Room() {
    
    
  }
  
  
  Room(ArrayList<Person> tenantsList, int id) {
    
    tenants = tenantsList; 
    roomID = id;
  }
  
  void addTenants(ArrayList<Person> tenantsList) {
   
    tenants = tenantsList;
    
  }
  
  
  void addTenant(Person p) {
    tenants.add(p); 
    
  }
  
}
