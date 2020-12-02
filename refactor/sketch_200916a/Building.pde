import java.util.Collection; 

class Building {
 
  int numRooms; 
  int numFloors; 
  
  ArrayList<Floor> floors = new ArrayList<Floor>();
  ArrayList<Elevator> elevators = new ArrayList<Elevator>();
  
  ArrayList<Job> jobsBeingServed = new ArrayList<Job>();
  
  
  ArrayList<Job> masterJobs = new ArrayList<Job>();
  
  //holds the information on how long people waited/spent in elevators
  ArrayList<PeopleStat> peopleStatistics = new ArrayList<PeopleStat>();

  
  
  Building() {
    
    
  }
  
  
  Building(int rooms, int floors) {
    
    numRooms = rooms; 
    numFloors = floors; 
    
  }
  
  ArrayList<PeopleStat> getPeopleStats() {
    return peopleStatistics; 
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
  
  boolean floorBusy(int floorNum) {
    boolean thereIsWork = false; 
    
    for(int i = 0; i < numRooms; i++) {
      
      if(floors.get(floorNum).getRoomsList().get(i).determineStatus()) {
        
        thereIsWork = true; 
        break;
        
      }
      
      
    }
    
    
    return thereIsWork; 
    
  }
  
  void giveElevatorTasks(int elevatorAlgorithm) {
    
    if (elevatorAlgorithm == 0) {
     // System.out.println("Using COVID-19 algorithm");
      
      
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
              elevators.get(i).getElevatorStat().tickPassengerDrop();
              
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
      
    } else if (elevatorAlgorithm == 1) {
      
      
      
       //for each job in the building, add it to the master list
      for(int floor = 0; floor < numFloors; floor++) {
       
        for(int room = 0; room < roomsPerFloor; room++) {
          
          for(int population = 0; population < floors.get(floor).getRoomFromIndex(room).getSize(); population++) {
            
             if( !(floors.get(floor).getRoomFromIndex(room).getTenantsList().get(population).getJob().addedToList)) {
               
               //the job has not been added to the master list yet
               //if the job is now the default job
               if(!(floors.get(floor).getRoomFromIndex(room).getTenantsList().get(population).getJob().getID() == -1)) {
                 System.out.println("Adding a job to the master list"); 
                 floors.get(floor).getRoomFromIndex(room).getTenantsList().get(population).getJob().addedToList = true;
                 masterJobs.add(floors.get(floor).getRoomFromIndex(room).getTenantsList().get(population).getJob());
               }
             }
          } 
        } 
      }
      
      
      
      
      //make it so the job with the highest floor, is the job that is given to the free elevator
      //eg : set the job with the highest floor pickup, to be the first job in the list
      
      
      int largestPickupIndex = 0; 
      int largestPickupSoFar = 0; 
      Job tempJob = new Job(); 
      for(int p = 0; p < masterJobs.size(); p++) {

        
        if(masterJobs.get(p).getPickup() > largestPickupSoFar) {
         
          largestPickupIndex = p; 
          largestPickupSoFar = masterJobs.get(p).getPickup();
          tempJob = masterJobs.get(p); 
          
        }
        
        //remove the largest job where you found it
        masterJobs.remove(largestPickupIndex); 
        //add the largest job to the start of the master list
        masterJobs.add(0,tempJob); 
       
        
        
      }
           
      
      //for each elevator, if it doesn't have a job give it to a free elevator
      for(int i = 0; i < elevators.size(); i++) {
        
        
        //if this elevator already has a job, skip
        if(elevators.get(i).getServiceQueue().size() >= 1) {
          //do nothing
          
        } else {
          
          //give the job to the elevator as long as there is enough jobs to give
          if (masterJobs.size() >= 1) {
            elevators.get(i).acceptRequest(masterJobs.get(0), i);
            masterJobs.remove(0);
            
          
          }
        }
        
        
        
      }
      
      
      
      //these loops will handle expelling the passenger from the cab
      //these loops will handle the elevators that are done a job and now need to expel their passenger
      for(int i = 0; i < elevators.size(); i++) {
        
        //if there is at least one job
        if(elevators.get(i).getServiceQueue().size() >= 1) {
          
          
          //for each person in the cab check if their jobs destination floor is equal to floor of the elevator
          for(int person = 0; person < elevators.get(i).getCabPassengers().size(); person++) {
            
            if(elevators.get(i).getFloor() == elevators.get(i).getCabPassengers().get(person).getJob().getDestination()) {
              
              System.out.println("Expelling passenger -------"); 
              
              
              System.out.println("Person leaving waited: " + elevators.get(i).getCabPassengers().get(person).getFramesWaitedForElevator() + " frames for an elevator to pick them up");
              System.out.println("Person leaving spent: " + elevators.get(i).getCabPassengers().get(person).getFramesSpendOnElevator() + " frames on the elevator ride");
          
              peopleStatistics.add(new PeopleStat(elevators.get(i).getCabPassengers().get(person).getFramesWaitedForElevator(),elevators.get(i).getCabPassengers().get(person).getFramesSpendOnElevator()));
              
              elevators.get(i).getCabPassengers().get(person).flipRidingElevator();
              
              elevators.get(i).getElevatorStat().tickPassengerDrop();
              
              masterJobs.remove(elevators.get(i).getCabPassengers().get(person).getJob()); 
              
              elevators.get(i).getServiceQueue().remove(elevators.get(i).getCabPassengers().get(person).getJob()); 
              elevators.get(i).getCabPassengers().remove(person);
              
              
              
              elevators.get(i).setNeedInstruction(true); 
              elevators.get(i).setJustDropped(true);  
              
              elevators.get(i).direction = Direction.STATIONARY; 
              elevators.get(i).justExpelled = true; 
              //elevators.get(i).openDoor(frameRate); 
            }
            
            
          }
          
        }
        
        
      }
      
      
      /*
     // System.out.println("Using regular elevator algorithm"); 
     for(int b = 0; b < elevators.size(); b++) {
       //System.out.println("service queue size of elevator " + b + " is : " + elevators.get(b).getServiceQueue().size()); 
     }
     
    
      
      //these loops handle getting the jobs of the building and adding them to the master list
      //a master list is more important in the regular elevator algordiithm scenario due to need 
      //of updating elevators that another cab may be "stealing" a passenger from
      
      //for each job in the building, add it to the master list
      for(int floor = 0; floor < numFloors; floor++) {
       
        for(int room = 0; room < roomsPerFloor; room++) {
          
          for(int population = 0; population < floors.get(floor).getRoomFromIndex(room).getSize(); population++) {
            
             if( !(floors.get(floor).getRoomFromIndex(room).getTenantsList().get(population).getJob().addedToList)) {
               
               //the job has not been added to the master list yet
               //if the job is now the default job
               if(!(floors.get(floor).getRoomFromIndex(room).getTenantsList().get(population).getJob().getID() == -1)) {
                 System.out.println("Adding a job to the master list"); 
                 floors.get(floor).getRoomFromIndex(room).getTenantsList().get(population).getJob().addedToList = true;
                 masterJobs.add(floors.get(floor).getRoomFromIndex(room).getTenantsList().get(population).getJob());
               }
             }
          } 
        } 
      }
      
      /*
      
      //these loops will handle giving tasks to elevators that are stationary. 
      //for each job in the master list that doesn't currently have an elevator coming
      for(int job = 0; job < masterJobs.size(); job++) {
        
        if(!(masterJobs.get(job).elevatorComing)) {
          // for each elevator
          for(int elevator = 0; elevator < elevators.size(); elevator++) {
          
          
            if(elevators.get(elevator).getDirection() == Direction.STATIONARY) {
              System.out.println("Giving elevator " + elevator + " a task");
              
              if(masterJobs.get(job).elevatorComing == false) {
              
                masterJobs.get(job).elevatorComing = true; 
                elevators.get(elevator).acceptRequest(masterJobs.get(job),elevator);
                
                
              }
            
            }
          
          }
          
        }
        
        
      }
      
      
      
      //these loops will handle giving tasks to elevators that are stationary
      //for each elevator,
      
      //accept the first unaccepted job 
      
         //then -> accept all jobs on the path of that job
         
         for(int elevator = 0; elevator < elevators.size(); elevator++) {
           
           boolean acceptedOne = false;
           //for each job in the master job
           for(int job = 0; job < masterJobs.size(); job++) {
             
             if(acceptedOne == false) {
             //if this job has not already been accepted
             if(masterJobs.get(job).elevatorComing == false) {
               
               if(alreadyAccepted(elevator, masterJobs.get(job).getID())) {
                 System.out.println("This job has already been accepted"); 
                 
               } else {
                 
                 masterJobs.get(job).elevatorComing = true; 
                 elevators.get(elevator).acceptRequest(masterJobs.get(job),elevator); 
                 
                 acceptedOne = true; 
                 System.out.println("---------------------------------------------------------------- added a job"); 
                 acceptAllOnPath(elevator,masterJobs.get(job)); 
               }
          
             }
       
           }
           }
           
         }
      
      
      
      
      
      
      
      
      
      
      //these loops will handle giving tasks to elevators that are currently moving down
      //for each job in the master list
      for(int job = 0; job < masterJobs.size(); job++) {
        
        //for each elevator
        for(int elevator = 0; elevator < elevators.size(); elevator++) {
          
          //if the elevator is currently moving down
          if(elevators.get(elevator).getDirection() == Direction.DOWN) {
             
            //if the person associated with the job has not been picked up yet
            if(masterJobs.get(job).getPickedUp() == false) {
              
              //if the master jobs pickup location is the same as the elevator
              if(masterJobs.get(job).getPickup() == elevators.get(elevator).getFloor()) {
                
                //if(elevators.get(elevator).extraStop == false) {
                  //System.out.println("Giving elevator " + elevator + " a task - this is an EXTRA task"); 
                  //make sure that this job id does not already exist in the service queue
                  
                  //for each job in the service queue
                  for(int accepted = 0; accepted < elevators.get(elevator).getServiceQueue().size(); accepted++) {
                    
                    System.out.println("Service queue size: " + elevators.get(elevator).getServiceQueue().size()); 
                    
                    //if the elevator already has this job in its service queue, you don't want to create duplicate jobs
                    if(elevators.get(elevator).getServiceQueue().get(accepted).getID() == masterJobs.get(job).getID()) {
                      System.out.println("Matching job not adding"); 
                      
                    } else {
                      System.out.println("EXTRA task added"); 
                      masterJobs.get(job).elevatorComing = true; 
                      //elevators.get(elevator).acceptRequest(masterJobs.get(job),elevator); 
                      //elevators.get(elevator).getServiceQueue().add(masterJobs.get(job));
                      elevators.get(elevator).setDestination(masterJobs.get(job).getPickup()); 
                      elevators.get(elevator).extraStop = true; 
                      
                    }
                    
                    
                  }
                  
                
                //}
                 
              }
              
              
            }
            
            
          }
          
          
          
        }
        
        
      }
      
      
      
      
      //these loops will handle the elevators that are done a job and now need to expel their passenger
      for(int i = 0; i < elevators.size(); i++) {
        
        //if there is at least one job
        if(elevators.get(i).getServiceQueue().size() >= 1) {
          
          
          //for each person in the cab check if their jobs destination floor is equal to floor of the elevator
          for(int person = 0; person < elevators.get(i).getCabPassengers().size(); person++) {
            
            if(elevators.get(i).getFloor() == elevators.get(i).getCabPassengers().get(person).getJob().getDestination()) {
              
              System.out.println("Expelling passenger -------"); 
              
              
              System.out.println("Person leaving waited: " + elevators.get(i).getCabPassengers().get(person).getFramesWaitedForElevator() + " frames for an elevator to pick them up");
              System.out.println("Person leaving spent: " + elevators.get(i).getCabPassengers().get(person).getFramesSpendOnElevator() + " frames on the elevator ride");
          
              peopleStatistics.add(new PeopleStat(elevators.get(i).getCabPassengers().get(person).getFramesWaitedForElevator(),elevators.get(i).getCabPassengers().get(person).getFramesSpendOnElevator()));
              
              elevators.get(i).getCabPassengers().get(person).flipRidingElevator();
              
              elevators.get(i).getElevatorStat().tickPassengerDrop();
              
              masterJobs.remove(elevators.get(i).getCabPassengers().get(person).getJob()); 
              
              elevators.get(i).getServiceQueue().remove(elevators.get(i).getCabPassengers().get(person).getJob()); 
              elevators.get(i).getCabPassengers().remove(person);
              
              
              
              elevators.get(i).setNeedInstruction(true); 
              elevators.get(i).setJustDropped(true);  
            }
            
            
          }
          
        }
        
        
      }
      
      
      //this loop will now check for extra passengers that may be stuck in the elevator
      for(int i = 0; i < elevators.size(); i++) {
        
        for(int c = 0; c < elevators.get(i).getCabPassengers().size(); c++) {
          
          //there is a pesky passenger stuck
          if(elevators.get(i).getCabPassengers().get(c).getJob().getDestination() == elevators.get(i).getFloor()) {
            
            System.out.println("Expelling a PESKY passenger --------"); 
            
            System.out.println("Person leaving waited: " + elevators.get(i).getCabPassengers().get(c).getFramesWaitedForElevator() + " frames for an elevator to pick them up"); 
            System.out.println("Person leaving spent: " + elevators.get(i).getCabPassengers().get(c).getFramesWaitedForElevator() + " frames on the elevator ride"); 
            
            peopleStatistics.add(new PeopleStat(elevators.get(i).getCabPassengers().get(c).getFramesWaitedForElevator(),elevators.get(i).getCabPassengers().get(c).getFramesSpendOnElevator())); 
            
            elevators.get(i).getElevatorStat().tickPassengerDrop();
            
            elevators.get(i).getCabPassengers().get(c).flipRidingElevator();
            
            masterJobs.remove(elevators.get(i).getCabPassengers().get(c).getJob()); 
            
            elevators.get(i).getServiceQueue().remove(elevators.get(i).getCabPassengers().get(c).getJob()); 
            elevators.get(i).getCabPassengers().remove(c); 
            
            elevators.get(i).setNeedInstruction(true); 
            elevators.get(i).setJustDropped(true); 
            
            
            
          }
          
          
        }
        
        
      }
      
      
      
      //---
      */
      
   //elevator algorithm 1 done
    }  else if (elevatorAlgorithm == 2) {
      
      //for each job in the building, add it to the master list
      for(int floor = 0; floor < numFloors; floor++) {
       
        for(int room = 0; room < roomsPerFloor; room++) {
          
          for(int population = 0; population < floors.get(floor).getRoomFromIndex(room).getSize(); population++) {
            
             if( !(floors.get(floor).getRoomFromIndex(room).getTenantsList().get(population).getJob().addedToList)) {
               
               //the job has not been added to the master list yet
               //if the job is now the default job
               if(!(floors.get(floor).getRoomFromIndex(room).getTenantsList().get(population).getJob().getID() == -1)) {
                 System.out.println("Adding a job to the master list"); 
                 floors.get(floor).getRoomFromIndex(room).getTenantsList().get(population).getJob().addedToList = true;
                 masterJobs.add(floors.get(floor).getRoomFromIndex(room).getTenantsList().get(population).getJob());
               }
             }
          } 
        } 
      }
      
      
      
      
      //make it so the job with the highest floor, is the job that is given to the free elevator
      //eg : set the job with the highest floor pickup, to be the first job in the list
      
      
      int largestPickupIndex = 0; 
      int largestPickupSoFar = 0; 
      Job tempJob = new Job(); 
      for(int p = 0; p < masterJobs.size(); p++) {

        
        if(masterJobs.get(p).getPickup() > largestPickupSoFar) {
         
          largestPickupIndex = p; 
          largestPickupSoFar = masterJobs.get(p).getPickup();
          tempJob = masterJobs.get(p); 
          
        }
        
        //remove the largest job where you found it
        masterJobs.remove(largestPickupIndex); 
        //add the largest job to the start of the master list
        masterJobs.add(0,tempJob); 
       
        
        
      }
           
      
      //for each elevator, if it doesn't have a job give it to a free elevator
      for(int i = 0; i < elevators.size(); i++) {
        
        
        //if this elevator already has a job, skip
        if(elevators.get(i).getServiceQueue().size() >= 1) {
          //do nothing
          
        } else {
          
          //give the job to the elevator as long as there is enough jobs to give
          if (masterJobs.size() >= 1) {
            elevators.get(i).acceptRequest(masterJobs.get(0), i);
            masterJobs.remove(0);
            
          
          }
        }
        
        
        
      }
      
      
      
      //these loops will handle expelling the passenger from the cab
      //these loops will handle the elevators that are done a job and now need to expel their passenger
      for(int i = 0; i < elevators.size(); i++) {
        
        //if there is at least one job
        if(elevators.get(i).getServiceQueue().size() >= 1) {
          
          
          //for each person in the cab check if their jobs destination floor is equal to floor of the elevator
          for(int person = 0; person < elevators.get(i).getCabPassengers().size(); person++) {
            
            if(elevators.get(i).getFloor() == elevators.get(i).getCabPassengers().get(person).getJob().getDestination()) {
              
              System.out.println("Expelling passenger -------"); 
              
              
              System.out.println("Person leaving waited: " + elevators.get(i).getCabPassengers().get(person).getFramesWaitedForElevator() + " frames for an elevator to pick them up");
              System.out.println("Person leaving spent: " + elevators.get(i).getCabPassengers().get(person).getFramesSpendOnElevator() + " frames on the elevator ride");
          
              peopleStatistics.add(new PeopleStat(elevators.get(i).getCabPassengers().get(person).getFramesWaitedForElevator(),elevators.get(i).getCabPassengers().get(person).getFramesSpendOnElevator()));
              
              elevators.get(i).getCabPassengers().get(person).flipRidingElevator();
              
              elevators.get(i).getElevatorStat().tickPassengerDrop();
              
              masterJobs.remove(elevators.get(i).getCabPassengers().get(person).getJob()); 
              
              elevators.get(i).getServiceQueue().remove(elevators.get(i).getCabPassengers().get(person).getJob()); 
              elevators.get(i).getCabPassengers().remove(person);
              
              
              
              elevators.get(i).setNeedInstruction(true); 
              elevators.get(i).setJustDropped(true);  
              
              elevators.get(i).direction = Direction.STATIONARY; 
              elevators.get(i).justExpelled = true; 
              //elevators.get(i).openDoor(frameRate); 
            }
            
            
          }
          
        }
        
        
      }
      
      
      
    }
 
   } 
   
    
  boolean alreadyAccepted(int elevatorNum, int jobID) {
    
    for(int i = 0; i < elevators.get(elevatorNum).getServiceQueue().size(); i++) {
      
      if(elevators.get(elevatorNum).getServiceQueue().get(i).getID() == jobID) {
       return true;  
      }
      
    }
    
    
    return false;
    
  }
    
  void acceptAllOnPath(int elevatorNum, Job jobAccepted) {
    int pickup = jobAccepted.getPickup(); 
    int destination = jobAccepted.getDestination(); 
    
    
    //for each job in the master list, give the elevator at elevatorNum all the jobs inbetween its accepted job
    for(int job = 0; job < masterJobs.size(); job++) {
      
      
      int extraPickup = masterJobs.get(job).getPickup(); 
      int extraDestination = masterJobs.get(job).getDestination(); 
      
      
      //accept all jobs that have a pickup location less than or equal to the initial pickup location, but also destination is larger than or equal to the initial destination
      if( (extraPickup <= pickup) & (destination <= extraDestination )) {
        
       
        //masterJobs.get(job).elevatorComing = true; 
        //elevators.get(elevator).acceptRequest(masterJobs.get(job),elevator); 
        
        //first make sure that this is not the same job as the initial job
        if( jobAccepted.getID() != masterJobs.get(job).getID()) {
          
          boolean alreadyHaveJob = false; 
          //then make sure that you are not adding other jobs that you have already added before
          for(int trying = 0; trying < elevators.get(elevatorNum).getServiceQueue().size(); trying++) {
            
            if( alreadyAccepted(elevatorNum, masterJobs.get(job).getID())) {
              System.out.println("Already have this job in the queue"); 
              System.out.println(masterJobs.get(job).getID() + "-> matched");
              alreadyHaveJob = true;
              break;
            } else {
              
              //first have to make sure this job isn't currently owned by any OTHER elevator
              if(masterJobs.get(job).elevatorComing == false) {
                //System.out.println("Accepting a job that was along the path of the initial job that was accepted by elevator : " + elevatorNum);
                System.out.println("------------------------------------------------------------------------------------------------------------------------------------------------- added a job");
                System.out.println(masterJobs.get(job).getID() + "-> jobID"); 
                System.out.println(elevators.get(elevatorNum).getServiceQueue().get(trying).getID() +"-> jobID from the elevators"); 
                masterJobs.get(job).elevatorComing = true; 
                elevators.get(elevatorNum).acceptRequest(masterJobs.get(job),elevatorNum);
              } else {
                System.out.println("Not stealing this task");  
                
              }
              
            }
            
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
