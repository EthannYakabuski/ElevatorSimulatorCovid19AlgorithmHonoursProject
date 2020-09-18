class Room {
  
  
  int roomID;
  
  ArrayList<Person> tenants = new ArrayList<Person>();
  
  Room() {
    
    
  }
  
  Room(int id) {
    
    roomID = id; 
    
  }
  
  
  Room(ArrayList<Person> tenantsList, int id) {
    
    tenants = tenantsList; 
    roomID = id;
  }
  
  int getSize() {
    
      return tenants.size();
  }
  
  void addTenants(ArrayList<Person> tenantsList) {
   
    tenants = tenantsList;
    
  }
  
  ArrayList<Person> getTenantsList() {
    
    
    return tenants;
    
  }
  
  
  void addTenant(Person p, int room) {
    tenants.add(p); 
    
  }
  
  Person getTenant(int i) {
    
    
    return tenants.get(i);
    
  }
  
}
