class Building {
 
  int numRooms; 
  int numFloors; 
  
  ArrayList<Floor> floors = new ArrayList<Floor>();
  ArrayList<Elevator> elevators = new ArrayList<Elevator>();
  
  ArrayList<Job> jobsBeingServed = new ArrayList<Job>();
  
  //holds the information on how long people waited/spent in elevators
  ArrayList<PeopleStat> peopleStatistics = new ArrayList<PeopleStat>();

  
  
  Building() {
    
    
  }
  
  
  Building(int rooms, int floors) {
    
    numRooms = rooms; 
    numFloors = floors; 
    
  }
  
  ArrayList<Floor> getFloors() {
    return floors; 
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
  
  void giveElevatorTasks(int elevatorAlgorithm) {
    int foundFloor = -1; 
    int foundRoom = -1;
    int foundPopulation = -1;
    //System.out.println("Giving elevators tasks");
    
    if(elevatorAlgorithm == 0) {
      //System.out.println("Using covid-19 algorithm"); 
      
    } else if (elevatorAlgorithm == 1) {
      //System.out.println("Using regular elevator algorithm");
      
    }
    
    
    
   
    
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
        
             elevators.get(elevatorIndex).acceptRequest(floors.get(foundFloor).getRoomFromIndex(foundRoom).getTenantsList().get(foundPopulation).getJob(), elevatorIndex); 
     
      
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
            System.out.println("Person leaving waited: " + elevators.get(i).getCabPassengers().get(0).getFramesWaitedForElevator() + " frames for an elevator to pick them up");
            System.out.println("Person leaving spent: " + elevators.get(i).getCabPassengers().get(0).getFramesSpendOnElevator() + " frames on the elevator ride");
          
            //add this PeopleStat to the arraylist storing the PeopleStat's
            peopleStatistics.add(new PeopleStat(elevators.get(i).getCabPassengers().get(0).getFramesWaitedForElevator(),elevators.get(i).getCabPassengers().get(0).getFramesSpendOnElevator()));
          
          
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
      
       int adding = 0;
       adding = floors.get(floor).getRoomFromIndex(room).getWhoIsHome().get(i).getJobLength();
       
       //there is someone that is waiting in that room
       if(adding > 0) {
         floors.get(floor).getRoomFromIndex(room).getWhoIsHome().get(i).tickStatisticsFrames();
         
       }
       
       returnValue = returnValue+adding; 
       returnValue+=floors.get(floor).getRoomFromIndex(room).getWhoIsHome().get(i).getJobLength();
      
      
    }
    
    return returnValue;
  }
  
void clear() {
  
  floors.clear();
  
}


//this function is used in conjunction with the regular elevator algorithm
//this function returns a list of all people waiting on the given floor ->
//the elevator will then take this list, add them to its cab and update their job pointers, incase a different elevator already accepted them
ArrayList<Person> checkFloorAndAccept(int floorToCheck, int elevatorDestination) {
  
  ArrayList<Person> returnList = new ArrayList<Person>(); 
  
  
  //check every person on the given floor and add them to the list if they are "waiting"
  
  for(int i = 0; i < numRooms; i++) {
    
    for(int person = 0; person < floors.get(floorToCheck).getRoomFromIndex(i).getTenantsList().size(); person++) {
      
      boolean addPerson = false; 
      int personDestination = floors.get(floorToCheck).getRoomFromIndex(i).getTenantsList().get(person).getJob().getDestination(); 
      
      //if the the persons destination is bigger than the elevator destination, AND
      //the persons destination is less than than the current floor of the elevator
      if( (personDestination >= elevatorDestination) & (personDestination < floorToCheck) ) {
        
        //add the person to the return list
        returnList.add(floors.get(floorToCheck).getRoomFromIndex(i).getTenantsList().get(person)); 
        
        
      }
      
      
      
    }
    
    
  }
  
  
  return returnList;  
}

Person getPersonFromID(int PID) {
  
  for(int floor = 0; floor < numFloors; floor++) {
      
     for(int room = 0; room < numRooms; room++) {
      
       
       for(int population = 0; population < floors.get(floor).getRoomFromIndex(room).getSize(); population++) {
         
        
           if(floors.get(floor).getRoomFromIndex(room).getTenantsList().get(population).getPID() == PID) {
             
             System.out.println("Match found");
             return floors.get(floor).getRoomFromIndex(room).getTenantsList().get(population);
           }
         
         
         
       }
       
     }
      
      
    }
  
  
  return new Person();
  
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


//returns the first person waiting for an elevator
Person popPerson(int fl) {
  
  Person returnPerson = new Person(); 
  
  //for each room there is on the floor
  for(int room = 0; room < roomsPerFloor; room++) {
    
   //for each tenant that is in the room 
   for(int tenant = 0; tenant < floors.get(fl).getRoomFromIndex(room).getHomeSize(); tenant++) {
     
     //if there is a tenant waiting then return them and break
     if(floors.get(fl).getRoomFromIndex(room).getWhoIsHome().get(tenant).waiting) {
       
       returnPerson = floors.get(fl).getRoomFromIndex(room).getWhoIsHome().get(tenant); 
       break;
     } 
   }
  }
  return returnPerson;
}
    
    
    
    
    
    
    
    
}
