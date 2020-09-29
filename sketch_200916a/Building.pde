class Building {
 
  int numRooms; 
  int numFloors; 
  
  ArrayList<Floor> floors = new ArrayList<Floor>();
  ArrayList<Elevator> elevators = new ArrayList<Elevator>();
  
  ArrayList<Job> jobsBeingServed = new ArrayList<Job>();
  
  
  
  
  Building() {
    
    
  }
  
  
  Building(int rooms, int floors) {
    
    numRooms = rooms; 
    numFloors = floors; 
    
  }
  
  void setNumRooms(int r) {
    numRooms = r; 
  }
  
  void setNumFloors(int f) {
    numFloors = f; 
  }
  
  void addFloor(Floor f) {
    floors.add(f);
    
    
  }
  
  void setElevators(ArrayList<Elevator> elevs) {
    elevators = elevs; 
  }
  
  void addTenant(Person p, int floor, int room) {
    
    //if the system is requesting to add a tenant to a floor that does not yet exist, first add the floor to the backing arraylist
    //note that this if statement will only be run for ONLY the first tenant on each floor
    if(floors.size() <= floor) {
      floors.add(new Floor(floor));
      
    }
    
    floors.get(floor).addTenant(p,room);
   
  }
  
  void giveElevatorTasks() {
    int foundFloor = -1; 
    int foundRoom = -1;
    int foundPopulation = -1;
    //System.out.println("Giving elevators tasks");
    
    //these nested loops handle giving Jobs to elevators from people that are currently at home in their room
    for(int floor = 0; floor < numFloors; floor++) {
     
      for(int room = 0; room < numRooms; room++) {
        
        
        for(int population = 0; population < floors.get(floor).getRoomFromIndex(room).getSize(); population++) {
          
          
          
          //if there is a person waiting
          if(floors.get(floor).getRoomFromIndex(room).getTenantsList().get(population).waiting) {
            
            //System.out.println("There is a person waiting"); 
            
            //if that persons job has not been accepted yet
            if(floors.get(floor).getRoomFromIndex(room).getTenantsList().get(population).getJob().elevatorAccepted == 0) {
            
              
              foundFloor = floor; 
              foundRoom = room;
              foundPopulation = population;
              if (floors.get(floor).getRoomFromIndex(room).getTenantsList().get(population).getJob().getID() >= 0) { floors.get(floor).getRoomFromIndex(room).getTenantsList().get(population).getJob().setElevatorComing(true); }
            
              break;
            }
          }
          
          
          
        }
        
        
        
      }
      
    }
    
    
    //this if statement handles when the building doesn't have any jobs for the elevators
    //the presence of this ID is the empty placeholder job request, no job actually exists
    //the presenece of foundFloor being -1 is that there was no job found in the building that has not already been accepted by an elevator
    if(!(foundFloor == -1)) {
    if(floors.get(foundFloor).getRoomFromIndex(foundRoom).getTenantsList().get(foundPopulation).getJob().getID() == -1) {
      System.out.println("No job to give");
      
    } else { //a job exists
      System.out.println("A Job exists -----------------------------------------------------------------");
      
     
      
        if(floors.get(foundFloor).getRoomFromIndex(foundRoom).getTenantsList().get(foundPopulation).getJob().getElevatorAccepted() == 0) {
           //System.out.println(ourTask.toString());
           System.out.println("This task has not already been accepted");
           int elevatorIndex = getFreeElevator(); 
      
           floors.get(foundFloor).getRoomFromIndex(foundRoom).getTenantsList().get(foundPopulation).getJob().tickAccepted(); 
        
           elevators.get(elevatorIndex).acceptRequest(floors.get(foundFloor).getRoomFromIndex(foundRoom).getTenantsList().get(foundPopulation).getJob()); 
     
      
         }
        
      
       
      
    }
    
    
  }
  
  
  
  
  //this handles the elevators that are finished a task and need to now expel their passenger
  
  
  for(int i = 0; i < elevators.size(); i++) { //for each elevator
    
    if(elevators.get(i).serviceQueue.size() >= 1) {  //if the elevator has at least one task
      Job elevatorsJob = elevators.get(i).getServiceQueue().get(0);
    
      if(elevatorsJob.getDestination() == elevators.get(i).getFloor()) {  //if the elevator is currently on the floor of the task destination
      
      
        //if there is actually a person in the cab
        if(elevators.get(i).getCabPassengers().size() >= 1) {
        System.out.println("expelling passenger -------------------------");
          
          //expel the person who is associated with the current task
          
          //covid-19 algorithm only has one cab passenger at a time ---- update later when other algorithms are added
          elevators.get(i).getCabPassengers().get(0).flipRidingElevator();
          elevators.get(i).getCabPassengers().remove(0);
          elevators.get(i).getServiceQueue().remove(0);
          elevators.get(i).setAtBottom();
          //elevators.get(i).doorOpening = true;
          
        }
      
     }
     
    }
    
    
    
  }
  
  
  
  
  }
  
  int getFreeElevator() {
    int indexOfLeastBusyElevator = -1; 
    int leastBusiestQueueSize = 100;
    
    for(int i = 0; i < elevators.size(); i++) {
    
      if(elevators.get(i).serviceQueue.size() < leastBusiestQueueSize) {
         indexOfLeastBusyElevator = i;
         leastBusiestQueueSize = elevators.get(i).serviceQueue.size();
        
      }
      
    }
    
    return indexOfLeastBusyElevator; 
    
    
  }
  
  
  void leaveRoom(Person p) {
    
    floors.get(p.getFloor()).getRoomFromIndex(p.getRoom()).getWhoIsHome().remove(p);
    
    
    
  }
  
  
  
  
  String getTenantString() {
    
    String tenantString = ""; 
    for(int floor = 0; floor < numFloors; floor++) {
      
     for(int room = 0; room < numRooms; room++) {
      
       
       for(int population = 0; population < floors.get(floor).getRoomFromIndex(room).getSize(); population++) {
         
         tenantString += floors.get(floor).getRoomFromIndex(room).getTenant(population).attendanceCall();
         
         
         
       }
       
     }
      
      
    }
    
    return tenantString; 
  }
  
  
  int getRoomStatus(int floor, int room) {
    
    int returnValue = 0; 
    
    
    for(int i = 0; i < floors.get(floor).getRoomFromIndex(room).getWhoIsHome().size(); i++) {
      
       returnValue+=floors.get(floor).getRoomFromIndex(room).getWhoIsHome().get(i).getJobLength();
      
      
    }
    
    return returnValue;
  }
  
void clear() {
  
  floors.clear();
  
}

Person getPersonFromID(int PID) {
  
  Person returnPerson = new Person(); 
  
  for(int floor = 0; floor < numFloors; floor++) {
      
     for(int room = 0; room < numRooms; room++) {
      
       
       for(int population = 0; population < floors.get(floor).getRoomFromIndex(room).getSize(); population++) {
         
        
           if(floors.get(floor).getRoomFromIndex(room).getTenantsList().get(population).getPID() == PID) {
             
             System.out.println("Match found");
             returnPerson = floors.get(floor).getRoomFromIndex(room).getTenantsList().get(population);
           }
         
         
         
       }
       
     }
      
      
    }
  
  
  return returnPerson;
  
  
  
}

Person getPersonFromFloorAndRoom(int fl, int ro) {
  
  if(floors.get(fl).getRoomFromIndex(ro).getHomeSize() >= 1) {
    return floors.get(fl).getRoomFromIndex(ro).getWhoIsHome().get(0);
  }
  
  System.out.println("there was no person in that room"); 
  return new Person();
}


void addJobFromFloorAndRoom(Job jobToAdd, int roomToAdd, int floorToAdd) {
  System.out.println("Adding the requested job to: (" + roomToAdd + "," + floorToAdd + ")");
  
}

void addJobFromPID(Job jobToAdd, int pID) {
  
  
  for(int f = 0; f < numFloors; f++) {
    
    for(int r = 0; r < roomsPerFloor; r++) {
      
      
      for(int p = 0; p < floors.get(f).getRoomFromIndex(r).getTenantsList().size(); p++) {
        
        
        if(floors.get(f).getRoomFromIndex(r).getTenantsList().get(p).getPID() == pID) {
          
           floors.get(f).getRoomFromIndex(r).getTenantsList().get(p).setJob(jobToAdd);
           floors.get(f).getRoomFromIndex(r).getTenantsList().get(p).setWaiting(true); 
          
        }
        
        
      }
      
      
    }
    
  }
  
  
}
    
    
    
    
    
    
    
    
}
