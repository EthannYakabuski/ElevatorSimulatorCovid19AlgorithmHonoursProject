class Elevator { 
  
  //arraylist for the 
  ArrayList<Job> serviceQueue = new ArrayList<Job>();
  
  ArrayList<Person> cabPassengers = new ArrayList<Person>();
 
  //elevator cab capacity and how many passengers are currently in the cab
  int capacity; 
  int currentLoad;
  
  Job currentTask = new Job();
  
  
  //which direction is the cab currently headed
  Direction direction = Direction.STATIONARY; 
  
  //how long the elevator door takes to open
  int doorTime; //in seconds
  
  //variables for the elevator shaft housing the cab
  int elevatorShaftHeight = 0; 
  int elevatorShaftWidth = 0; 
  
  //speed of elevator
  float floorsPerSecond = 0.0;
  
  //location of the elevator shaft
  int posX; 
  int posY;
  
  //represents the last floor the elevator has fully passed, or is currently stopped at. 
  //ie. this value would be 4 if it was halfway inbetween floor 4 and 5, and would switch to 5 when it fully reaches floor 5
  int floor = 1; 
  
  //status of the elevator
  boolean busy = false; 
  
  int currentDestination = 0; 
 
 
  float sidewaysDoorSpeed = 0.5;
  
  int doorAnimationTime; 
  
  //variables for the cab dimensions and location
  float cabPosX; 
  float cabPosY;
  
  float cabPos2X; 
  float originalCabPosX; 
  
  int cabWidth = 20; 
  int cabHeight = 10;
  
  boolean doorOpening = false; 
  boolean doorClosing = false; 
  boolean doorClosed  = true;
  
  boolean needInstruction = false; 
  
  //where the elevator is in the animation process of opening the doors
  int animationFrame = 0; 
  //how many frames the entire animation should take
  int maxAnimationFrame = 0; 
  
  
  //door opening stopwatch
  StopWatch doorOpeningTimer = new StopWatch(); 
  
  //door closing stopwatch
  StopWatch doorClosingTimer = new StopWatch();
  
  Elevator(int cap, int load, int door, int sh, int sw, float floorsPerSec, int positionX, int positionY, int cabPositionX, int cabPositionY) { 
    capacity = cap; 
    currentLoad = load;
    doorTime = door; 
    elevatorShaftWidth = sw; 
    elevatorShaftHeight = sh; 
    floorsPerSecond = floorsPerSec; 
    posX = positionX; 
    posY = positionY;
    cabPosX = cabPositionX; 
    cabPosY = cabPositionY;
    cabPos2X = cabPositionX; 
    originalCabPosX = cabPositionX; 
    
  }
  
  //getters and setters start
  void setShaftHeight(int h) {
    elevatorShaftHeight = h; 
  }
  
  void setShaftWidth(int w) {
    elevatorShaftWidth = w; 
  }
  
  void setCabPosX(int cpX) {
    cabPosX = cpX; 
  }
  
  void setCabPosY(int cpY) {
    cabPosY = cpY; 
  }
  
  
  //tickers
  void tickMaxPass() { if(!(capacity>=20)) { capacity++; } }
  void tickMaxPassDown() { if(!(capacity==1)) { capacity--; } }
  
  
  void tickCabSpeed() { if(!(floorsPerSecond == 2.000)) { floorsPerSecond = floorsPerSecond + 0.001; } }
  void tickCabSpeedDown() { if(!(floorsPerSecond == 0.1)) { floorsPerSecond = floorsPerSecond - 0.001; } }
  
  
  void tickDoorSpeed() { if(!(doorTime>=20.000)) { doorTime = doorTime + 1; } }
  void tickDoorSpeedDown() { if(!(doorTime<=1.000)) { doorTime = doorTime - 1; } }
  
  
  int getFloor() { return floor; }
  int getPassengerNum() { return currentLoad; }
  int getCapacity() { return capacity; }
  float getCabSpeed() { return floorsPerSecond; }
  int getDoorSpeed() { return doorTime; }
  boolean getStatus() { return busy; }
  Job getCurrentTask() { return currentTask; }
  
  boolean getNeedInstruction() { return needInstruction; }
  
  //getters and setters end
  
  
  //draws the elevator and the shaft that this elevator exists in 
  void drawMe() {
    
   
    rectMode(CENTER); 
    
    
    //first draw the shaft the the elevator exists in 
    drawShaft(); 
    
    //second draw the cab that represents the elevator
    drawCab();
    
    
    
    
  }
  
  void acceptRequest(Job task) {
    serviceQueue.add(task);
    
  }
  
  //long thin rectangle to house the elevator
  void drawShaft() {
    
    rectMode(CENTER); 
    fill(#B7B7AE); 
    
    rect(posX,posY,elevatorShaftWidth,elevatorShaftHeight); 
    
    
  }
  
  
  //draw the cab representing the elevator
  void drawCab() {
    
    if(doorOpening) { //door is in the process of opening
      
       rectMode(CENTER); 
       fill(#58584B); 
       
       cabPos2X = cabPos2X - sidewaysDoorSpeed;
       cabPosX = cabPosX + sidewaysDoorSpeed;
       
       rect(cabPosX, cabPosY, cabWidth/2, cabHeight);
       rect(cabPos2X, cabPosY, cabWidth/2, cabHeight);
      
    }  else if (doorClosing) {  //door is in the process of closing
       
       rectMode(CENTER); 
       fill(#58584B); 
       
       cabPos2X = cabPos2X + sidewaysDoorSpeed; 
       cabPosX = cabPosX - sidewaysDoorSpeed; 
       
       rect(cabPosX, cabPosY, cabWidth/2, cabHeight);
       rect(cabPos2X, cabPosY, cabWidth/2, cabHeight);
      
      
    }  else { //elevator is in transit, door is closed shut
    
      rectMode(CENTER); 
      fill(#58584B); 
    
      rect(cabPosX, cabPosY, cabWidth, cabHeight);
    
    }
    
  }
  
  
  void animateDoorOpening() {
    
    
  }
  
  
  void checkFloor() {
    
    if ( (cabPosY <= 945) & (cabPosY > 930)) { floor = 1; }
    if ( (cabPosY <= 930) & (cabPosY > 915)) { floor = 2; }
    if ( (cabPosY <= 915) & (cabPosY > 900)) { floor = 3; }
    if ( (cabPosY <= 900) & (cabPosY > 885)) { floor = 4; }
    if ( (cabPosY <= 885) & (cabPosY > 870)) { floor = 5; }
    if ( (cabPosY <= 870) & (cabPosY > 855)) { floor = 6; }
    if ( (cabPosY <= 855) & (cabPosY > 840)) { floor = 7; }
    if ( (cabPosY <= 840) & (cabPosY > 825)) { floor = 8; }
    if ( (cabPosY <= 825) & (cabPosY > 810)) { floor = 9; }
    if ( (cabPosY <= 810) & (cabPosY > 795)) { floor = 10; }
    if ( (cabPosY <= 795) & (cabPosY > 780)) { floor = 11; }
    if ( (cabPosY <= 780) & (cabPosY > 765)) { floor = 12; }
    if ( (cabPosY <= 765) & (cabPosY > 750)) { floor = 13; }
    if ( (cabPosY <= 750) & (cabPosY > 735)) { floor = 14; }
    if ( (cabPosY <= 735) & (cabPosY > 720)) { floor = 15; }
    if ( (cabPosY <= 720) & (cabPosY > 705)) { floor = 16; }
    if ( (cabPosY <= 705) & (cabPosY > 690)) { floor = 17; }
    if ( (cabPosY <= 690) & (cabPosY > 675)) { floor = 18; }
    if ( (cabPosY <= 675) & (cabPosY > 660)) { floor = 19; }
    if ( (cabPosY <= 660) & (cabPosY > 645)) { floor = 20; }
    if ( (cabPosY <= 645) & (cabPosY > 630)) { floor = 21; }
    if ( (cabPosY <= 630) & (cabPosY > 615)) { floor = 22; }
    if ( (cabPosY <= 615) & (cabPosY > 600)) { floor = 23; }
    if ( (cabPosY <= 600) & (cabPosY > 585)) { floor = 24; }
    if ( (cabPosY <= 585) & (cabPosY > 570)) { floor = 25; }
    if ( (cabPosY <= 570) & (cabPosY > 555)) { floor = 26; }
    if ( (cabPosY <= 555) & (cabPosY > 540)) { floor = 27; }
    if ( (cabPosY <= 540) & (cabPosY > 525)) { floor = 28; }
    if ( (cabPosY <= 525) & (cabPosY > 510)) { floor = 29; }
    if ( (cabPosY <= 510) & (cabPosY > 495)) { floor = 30; }
    if ( (cabPosY <= 495) & (cabPosY > 480)) { floor = 31; }
    if ( (cabPosY <= 480) & (cabPosY > 465)) { floor = 32; }
    if ( (cabPosY <= 465) & (cabPosY > 450)) { floor = 33; }
    if ( (cabPosY <= 450) & (cabPosY > 435)) { floor = 34; }
    if ( (cabPosY <= 435) & (cabPosY > 420)) { floor = 35; }
    if ( (cabPosY <= 420) & (cabPosY > 405)) { floor = 36; }
    if ( (cabPosY <= 405) & (cabPosY > 390)) { floor = 37; }
    if ( (cabPosY <= 390) & (cabPosY > 375)) { floor = 38; }
    if ( (cabPosY <= 375) & (cabPosY > 360)) { floor = 39; }
    if ( (cabPosY <= 360) & (cabPosY > 345)) { floor = 40; }
    
    
    
    
  }
  
  //moves the cab based on its speed for one frame
  void moveUp() {
    
   // System.out.println(cabPosY);
    
   // System.out.println("Moving an elevator"); 
    
    if(!(floor == 40)) {
      cabPosY = cabPosY - floorsPerSecond;
    
      checkFloor();
    }
    
    
  }
  
  //moves the cab based on its speed for one frame
  void moveDown() {
    
    if(!(floor == 1)) {
      cabPosY = cabPosY + floorsPerSecond; 
      
      checkFloor();
    }
    
    
    
  }
  
  
  //determines the orientation of the elevator and decides whether to call moveUP() or moveDown()
  void move(int frameRate) { 
    
    
   //System.out.println("Current framerate: " + frameRate); 
   //if this elevator has a Job to do
    if(serviceQueue.size() >= 1) {
      
      currentDestination = serviceQueue.get(0).getPickup();
     // System.out.println(currentDestination);
      
    }
    
    
    //if the current floor is less than the destination floor
    if(floor < currentDestination) {
      moveUp();
      
      //if the current floor is larger then the destination floor
    } else if (floor > currentDestination) {
      moveDown();
    
    //the elevator has reached its destination -> open the door and wait for it to close again before continuing
    } else if ((floor == currentDestination)&(!doorClosing)) {
      
      //if the door isn't already currently opening
      if(!(doorOpening)) {
        
        //if the door is currently closing
        if(doorClosing) {
            
          
          } else { 
        
            System.out.println("Calling openDoor(int frameRate);");
            openDoor(frameRate);
          
          }
        
        
        
      } else if (doorOpening) {
        //then the door is currently opening, need to tick the stopwatch keeping track of this elevators door opening animation
        boolean openAnimationDone;
        openAnimationDone = doorOpeningTimer.tickTime();
        
        //the door has opened all the way
        if(openAnimationDone) {
          System.out.println("Closing door");       
          closeDoor();
          
        } else {
          System.out.println("Animating door opening a bit more");
          
          
        }
        
      } 
      
    } else if ((floor == currentDestination)&(doorClosing)) {
      System.out.println("Passenger should get in the cab, and remove their job, passenger should be added to elevator cab, elevator cab should move onto its next destination");
      doorClosing = false; 
      doorOpening = false; 
      needInstruction = true; 
      
      
    }
    
    
    
    
  }
  
  //this will only be called once per opening of the door
  void openDoor(int frameRate) {
    System.out.println("Inside openDoor(int frameRate)");
    
    //calculate how many frames the timer should go on for 
    int totalDoorTime = doorTime*frameRate; 
    doorAnimationTime = totalDoorTime; 
    
 
    doorOpening = true;
    doorOpeningTimer = new StopWatch(0,0,totalDoorTime,"doorOpening");
    
    
  }
  
  
  //this will only be called once per closing of the door
  void closeDoor() {
    System.out.println("Inside closeDoor()");
    
    doorOpening = false; 
    doorClosing = true; 
    
    doorClosingTimer = new StopWatch(0,0,doorAnimationTime,"doorClosing");
    
    
    
  }
  
  
  
  
  
}
