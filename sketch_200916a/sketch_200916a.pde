//library for GUI elements
//https://github.com/sojamo/controlp5
import controlP5.*;

import java.util.Arrays;


int width= 1600; 
int height = 950; 



ControlP5 guiControl; 

//the building object
Building highRise;


//apartment sizes sliders
int maxFloors = 30; 
int minFloors = 2;
int numFloors = 2; 

int minRoomsPerFloor = 1;
int maxRoomsPerFloor = 30; 
int roomsPerFloor = 1; 

int minPopulationPerRoom = 0; 
int maxPopulationPerRoom = 50; 
int roomPopulation = 0; 


//elevator sizes sliders
int maxElevators = 8; 
int minElevators = 1; 
int numElevators = 1; 

int maxElevatorCapacity = 20; 
int minElevatorCapacity = 1; 
int elevatorCapacity = 1; 

//this is calculated in seconds. a value of 1.0 means the door opens in one second, and closes in one second as well. 
//a value of 1.5 means the door opens in 1 second and 50 milliseconds
//a value of 1.9 means the door opens in 1 second and 90 milliseconds
float maxElevatorDoorTime = 20.0; 
float minElevatorDoorTime = 1.0;
float elevatorDoorTime = 1.0;

//if elevator speed is 1.0 this is equivalent to travelling at 1 floor per second
float maxElevatorSpeed = 2.0;  //1 floor/0.5 seconds max speed
float minElevatorSpeed = 0.1; //floors per second  1 floor/10 seconds minimum speed
float elevatorSpeed = 0.1; //floors per second

//simulation run time sliders
int maxMinutes = 1440; 
int minMinutes = 1; 
int simulationRunTime = 1; 

//variables for defining the sliders in the developer GUI section
int sliderSizeHeight = 20; 
int sliderSizeWidth = 200; 

//variables for defining the buttons in the developer GUI section
int buttonSizeHeight = 50;
int buttonSizeWidth = 150;

//local variables for elevator shaft dimensions
int shaftHeight = 0; 
int shaftWidth = 0; 

//list holding the elevators needed
ArrayList<Elevator> elevators = new ArrayList<Elevator>();

//if the building has been specified yet, activates "live" building mode, where you can see real time adjustments of
boolean buildingSpecified = false;


//
boolean buildingObjectsCreated = false; 

//has the simulation started yet?
boolean simulationStarted = false; 

void setup() {
  
  guiControl = new ControlP5(this);
  
  size(1600, 950); 
  smooth();
  noStroke();
  
  frameRate(15); //thirty frames / second
  
  setupGuiElements();
}

void draw() {
  fill(0);
  background(0); //black
  
  drawDeveloperControlsBackground();
  
  drawElevatorInformationPanel();
  
  drawHighRiseInformationPanel();
  
  drawBuilding();
  
  drawElevators();
  
  moveElevators();
  
}

void startSimulation() {
  
  System.out.println("Starting simulation"); 
  
  
}


void moveElevators() {
  
  for(int i = 0; i < elevators.size(); i++) {
    if(!(elevators.get(i).busy)) {
       elevators.get(i).move();
    }
    
  }
  
  
  
}

void drawDeveloperControlsBackground() {
   rectMode(CENTER); 
   fill(#094BEA); 
   //nice blue behind the slider bars
   rect(1350,450,500,1200);
   
   //draw the 'spawn building' button
   fill(#F0112F);
   rect(1300,810,buttonSizeWidth,buttonSizeHeight);
   
   fill(0); 
   textSize(12); 
   text("SPAWN BUILDING", 1245, 815); 
   
   
   //draw the 'spawn elevators' button
   fill(#F0112F);
   rect(1300,875,buttonSizeWidth,buttonSizeHeight);
   
   fill(0);
   textSize(12); 
   text("SPAWN ELEVATORS", 1245, 880);
   
  
   //draw the 'run simulation' button
   fill(#F0112F);
   rect(1500,875,buttonSizeWidth,buttonSizeHeight);
   
   fill(0); 
   textSize(12); 
   text("START SIMULATION", 1445, 880); 
}

void drawElevatorInformationPanel() {
   rectMode(CORNERS); 
   fill(255); 
   
   rect(600,0,1100,320);
   
   drawElevatorTextInfo(); 
   drawElevatorFineTuneControls();
  
}

void drawHighRiseInformationPanel() {
  
  fill(0); 
  textSize(12); 
  strokeWeight(5);
  text("FLOOR",60,60);
  
  rectMode(CORNERS); 
  fill(255); 
  
  rect(0,0,590,420);
  
  drawGrid();
  
}

void drawGrid() {
  
  //System.out.println("drawing grid");
  
  //text 
  fill(#EFF018);
  fill(0); 
  textSize(10);
  text("Room", 0, 10); 
  text("Floor", 0, 20); 
  
  //draw the grid rooms numbers
  for(int i = 0; i < roomsPerFloor; i++) {
    text(i, 33+i*17, 10);
    
  }
  
  //draw the grid floor numbers
  for(int i = 0; i < numFloors; i++) {
    text(i, 10, 32+i*13);
    
  }
  
  
  
  fill(0); 
  stroke(0); 
  strokeWeight(1);
  
  //vertical lines
  line(30,0,30,20+numFloors*13);
  for(int i = 0; i < roomsPerFloor; i++) {
     line(47+i*17,0,47+i*17,20+numFloors*13);
     
    
  }
  

  //horizontal lines
  line(0,22,30+roomsPerFloor*17,22);
  for(int i = 0; i < numFloors; i++) {
     line(0,35+i*13,30+roomsPerFloor*17,35+i*13);
    
  }
  
 
  
  noStroke();
  
}

void drawElevatorFineTuneControls() {
  rectMode(CORNERS); 
  
  for(int i = 0; i < elevators.size(); i++) {
    
    //controls for the max passenger information
    fill(#EFF018); 
    rect(860,17+i*37,890,32+i*37);
    fill(0); 
    textSize(10); 
    text("Up", 862, 27+i*37);
    fill(#FA0505);
    rect(860,33+i*37,890,48+i*37);
    fill(0); 
    text("Down", 862, 43+i*37);
    
    //controls for the cab speed information
    fill(#EFF018); 
    rect(940,17+i*37,970,32+i*37);
    fill(0); 
    textSize(10); 
    text("Up", 942, 27+i*37);
    fill(#FA0505);
    rect(940,33+i*37,970,48+i*37);
    fill(0); 
    text("Down", 942, 43+i*37);
    
    //controls for the door speed information
    fill(#EFF018); 
    rect(1017,17+i*37,1047,32+i*37);
    fill(0); 
    textSize(10); 
    text("Up", 1019, 27+i*37);
    fill(#FA0505);
    rect(1017,33+i*37,1047,48+i*37);
    fill(0); 
    text("Down", 1019, 43+i*37);
    
  }
  
  
  
}

void drawElevatorTextInfo() {
  
  fill(0);
  textSize(12);
  
  text("Elevator #", 605, 15);
  text("Current Floor", 670, 15);
  text("Passengers", 755, 15);
  text("Max Pass.", 830, 15);
  text("Cab Speed", 900, 15);
  text("Door Speed", 970, 15);
  text("Status", 1050, 15);
  
  

  for(int i = 0; i < elevators.size(); i++) {
    text(i, 605, 30+i*37);
    text(elevators.get(i).getFloor(), 670, 30+i*37);
    text(elevators.get(i).getPassengerNum(), 755, 30+i*37);
    text(elevators.get(i).getCapacity(), 830, 30+i*37);
    text(elevators.get(i).getCabSpeed(), 900, 30+i*37); 
    text(elevators.get(i).getDoorSpeed(), 970, 30+i*37); 
    
    if(elevators.get(i).getStatus()) {
      
      text("busy", 1050, 30+i*37);
      
    } else {
      
      text("silent", 1050, 30+i*37);
      
    }
    
  }
  
  
}



void drawBuilding() {
  
  for(int i = 0; i < numFloors; i++) {
    
    //System.out.println("Drawing a floor"); 
    
    rectMode(CORNERS); 
    fill(#96A09E);
    
    if(numFloors <= 12) { 
    
      rect(10,950,10+(roomsPerFloor*21),930-(i*16));
      
    } else {
    
      rect(10,950,10+(roomsPerFloor*21),950-(i*16));
      
    }
    
  }
  
  for(int x = 0; x < roomsPerFloor; x++) {
      
    for(int y = 0; y < numFloors; y++) { 
     
      rectMode(CENTER); 
      fill(#F2F21D);
      
      rect(20+(x*20),945-(y*15), 5, 5);
    }
     
      
    }
    
  
  
  
  
}


void drawElevators() {
  
  
  for(int i = 0; i < elevators.size(); i++) {
    elevators.get(i).drawMe();
    
  }
  
  
  
  
}

//calculates how large the elevator shaft should be drawn based on the size of the building
void calculateShaftDimensions() {
  shaftWidth = 30*numFloors; 
  shaftHeight = 30;
  
}


//this function is responsible for object creation of the elevators given the information on the sliders when the spawn elevators button is hit
void makeElevators() {
  calculateShaftDimensions();
  
  System.out.println("Making elevator objects");
  
  elevators.clear();

  for(int i = 0; i < numElevators; i++) {
    elevators.add(new Elevator(elevatorCapacity, 0, elevatorDoorTime, shaftWidth, shaftHeight, elevatorSpeed, 660+i*60, 930, 660+i*60, 945)); 
    
    
  }
 
}


//this function is responsible for object creation of the building, rooms and tenant lists given the information on the sliders when the build building button is hit
void makeBuildingObjects() {
 
  
  for(int floor = 0; floor < numFloors; floor++) {
    
   
    for(int room = 0; room < roomsPerFloor; room++) {
      
     
      
      for(int tenant = 0; tenant < roomPopulation; tenant++) {
        
        
        
      }
      
    }
    
    
  }
  
}
        
        
       
    
    
  
  
  
  


//initial setup for the developer GUI controls this is only to be run once in setup()
void setupGuiElements() {
  //adding apartment creation sliders to the developer interface
  
  guiControl.addSlider("numFloors")
    .setPosition(1500,50)
    .setSize(sliderSizeHeight,sliderSizeWidth)
    .setRange(minFloors,maxFloors)
    .setValue(numFloors);
    
  guiControl.addSlider("roomsPerFloor")
    .setPosition(1400,50)
    .setSize(sliderSizeHeight,sliderSizeWidth)
    .setRange(minRoomsPerFloor,maxRoomsPerFloor)
    .setValue(roomsPerFloor);
    
  guiControl.addSlider("roomPopulation")
    .setPosition(1300,50)
    .setSize(sliderSizeHeight,sliderSizeWidth)
    .setRange(minPopulationPerRoom,maxPopulationPerRoom)
    .setValue(roomPopulation);
    
  guiControl.addSlider("numElevators")
    .setPosition(1500,300)
    .setSize(sliderSizeHeight,sliderSizeWidth)
    .setRange(minElevators,maxElevators)
    .setValue(numElevators);
    
  guiControl.addSlider("elevatorCapacity")
    .setPosition(1400,300)
    .setSize(sliderSizeHeight,sliderSizeWidth)
    .setRange(minElevatorCapacity,maxElevatorCapacity)
    .setValue(elevatorCapacity);
       
  guiControl.addSlider("elevatorDoorTime")
    .setPosition(1300,300)
    .setSize(sliderSizeHeight,sliderSizeWidth)
    .setRange(minElevatorDoorTime,maxElevatorDoorTime)
    .setValue(elevatorDoorTime);
    
  guiControl.addSlider("elevatorSpeed")
    .setPosition(1200,300)
    .setSize(sliderSizeHeight,sliderSizeWidth)
    .setRange(minElevatorSpeed,maxElevatorSpeed)
    .setValue(elevatorSpeed);
    
  guiControl.addSlider("simulationRunTime")
    .setPosition(1500,550)
    .setSize(sliderSizeHeight,sliderSizeWidth)
    .setRange(minMinutes,maxMinutes)
    .setValue(simulationRunTime);
    
   
   
}


//button listeners
void mousePressed() {
  
  
  System.out.println(mouseX); 
  System.out.println(mouseY); 
  
  
  
  //the user has clicked within the spawn elevators button
  if(mouseX>=1225 & mouseX <=1375) {
    
    if(mouseY>=850 & mouseY <=900) {
      
      buildingSpecified = true;
      makeElevators();
      drawBuilding();
      
    }
      
    }
    
  //the user has clicked within the start simulation button
  if(mouseX>=1425 & mouseX <=1575) {
    
    if(mouseY>=850 & mouseY <=900) {
      
      simulationStarted = true; 
      startSimulation();
      
    }
    
    
  }
  
  //the user has click withing the spawn building button
  if(mouseX>=1225 & mouseX <=1375) {
    
    if(mouseY>=785 & mouseY <=835) {
      
      
    }
      
    }
  
  
  
  
    
  //user has clicked within the fine tuning elevator section
  if(mouseX>800 & mouseX <1100) {
     
    
    //adjusting max passenger size
     if(mouseX>=860 & mouseX<=890) {
       
       //user has clicked elevator 0's up button for max passenger information
       if(mouseY>=17 & mouseY <=32) {
         if(elevators.size() >= 1) { elevators.get(0).tickMaxPass(); }
       }
       
        //user has clicked elevator 0's down button for max passenger information
       if(mouseY>=33 & mouseY <=48) {
         if(elevators.size() >= 1) { elevators.get(0).tickMaxPassDown(); }
       }
       
       
       //user has clicked elevator 1's up button for max passenger information
       if(mouseY>=54 & mouseY <=69) {
         if(elevators.size() >= 2) { elevators.get(1).tickMaxPass(); }
       }
       
        //user has clicked elevator 1's down button for max passenger information
       if(mouseY>=70 & mouseY <=85) {
         if(elevators.size() >= 2) { elevators.get(1).tickMaxPassDown(); }
       }
       
       
       //user has clicked elevator 2's up button for max passenger information
       if(mouseY>=91 & mouseY <=106) {
         if(elevators.size() >= 3) { elevators.get(2).tickMaxPass(); }
       }
       
        //user has clicked elevator 2's down button for max passenger information
       if(mouseY>=107 & mouseY <=122) {
         if(elevators.size() >= 3) { elevators.get(2).tickMaxPassDown(); }
       }
       
       
       //user has clicked elevator 3's up button for max passenger information
       if(mouseY>=128 & mouseY <=143) {
         if(elevators.size() >= 4) { elevators.get(3).tickMaxPass(); }
       }
       
        //user has clicked elevator 3's down button for max passenger information
       if(mouseY>=144 & mouseY <=159) {
         if(elevators.size() >= 4) { elevators.get(3).tickMaxPassDown(); }
       }
       
       
       //user has clicked elevator 4's up button for max passenger information
       if(mouseY>=165 & mouseY <=180) {
         if(elevators.size() >= 5) { elevators.get(4).tickMaxPass(); }
       }
       
        //user has clicked elevator 4's down button for max passenger information
       if(mouseY>=181 & mouseY <=196) {
         if(elevators.size() >= 5) { elevators.get(4).tickMaxPassDown(); }
       }
       
       
       //user has clicked elevator 5's up button for max passenger information
       if(mouseY>=202 & mouseY <=217) {
         if(elevators.size() >= 6) { elevators.get(5).tickMaxPass(); }
       }
       
        //user has clicked elevator 5's down button for max passenger information
       if(mouseY>=218 & mouseY <=233) {
         if(elevators.size() >= 6) { elevators.get(5).tickMaxPassDown(); }
       }
       
       
       //user has clicked elevator 6's up button for max passenger information
       if(mouseY>=239 & mouseY <=254) {
         if(elevators.size() >= 6) { elevators.get(6).tickMaxPass(); }
       }
       
        //user has clicked elevator 6's down button for max passenger information
       if(mouseY>=255 & mouseY <=270) {
         if(elevators.size() >= 6) { elevators.get(6).tickMaxPassDown(); }
       }
       
       
       //user has clicked elevator 7's up button for max passenger information
       if(mouseY>=276 & mouseY <=291) {
         if(elevators.size() >= 7) { elevators.get(7).tickMaxPass(); }
       }
       
        //user has clicked elevator 7's down button for max passenger information
       if(mouseY>=292 & mouseY <=307) {
         if(elevators.size() >= 7) { elevators.get(7).tickMaxPassDown(); }
       }
       
       
     }
     
     
     
     //adjusting cab speed information
     if(mouseX>=940 & mouseX<=970) {
       
       
       //user has clicked elevator 0's up button for cab speed information
       if(mouseY>=17 & mouseY <=32) {
         if(elevators.size() >= 1) { elevators.get(0).tickCabSpeed(); }
       }
       
        //user has clicked elevator 0's down button for cab speed information
       if(mouseY>=33 & mouseY <=48) {
         if(elevators.size() >= 1) { elevators.get(0).tickCabSpeedDown(); }
       }
       
       
       //user has clicked elevator 1's up button for cab speed information
       if(mouseY>=54 & mouseY <=69) {
         if(elevators.size() >= 2) { elevators.get(1).tickCabSpeed(); }
       }
       
        //user has clicked elevator 1's down button for cab speed information
       if(mouseY>=70 & mouseY <=85) {
         if(elevators.size() >= 2) { elevators.get(1).tickCabSpeedDown(); }
       }
       
       
       //user has clicked elevator 2's up button for cab speed information
       if(mouseY>=91 & mouseY <=106) {
         if(elevators.size() >= 3) { elevators.get(2).tickCabSpeed(); }
       }
       
        //user has clicked elevator 2's down button for cab speed information
       if(mouseY>=107 & mouseY <=122) {
         if(elevators.size() >= 3) { elevators.get(2).tickCabSpeedDown(); }
       }
       
       
       //user has clicked elevator 3's up button for cab speed information
       if(mouseY>=128 & mouseY <=143) {
         if(elevators.size() >= 4) { elevators.get(3).tickCabSpeed(); }
       }
       
        //user has clicked elevator 3's down button for cab speed information
       if(mouseY>=144 & mouseY <=159) {
         if(elevators.size() >= 4) { elevators.get(3).tickCabSpeedDown(); }
       }
       
       
       //user has clicked elevator 4's up button for cab speed information
       if(mouseY>=165 & mouseY <=180) {
         if(elevators.size() >= 5) { elevators.get(4).tickCabSpeed(); }
       }
       
        //user has clicked elevator 4's down button for cab speed information
       if(mouseY>=181 & mouseY <=196) {
         if(elevators.size() >= 5) { elevators.get(4).tickCabSpeedDown(); }
       }
       
       
       //user has clicked elevator 5's up button for cab speed information
       if(mouseY>=202 & mouseY <=217) {
         if(elevators.size() >= 6) { elevators.get(5).tickCabSpeed(); }
       }
       
        //user has clicked elevator 5's down button for cab speed information
       if(mouseY>=218 & mouseY <=233) {
         if(elevators.size() >= 6) { elevators.get(5).tickCabSpeedDown(); }
       }
       
       
       //user has clicked elevator 6's up button for cab speed information
       if(mouseY>=239 & mouseY <=254) {
         if(elevators.size() >= 6) { elevators.get(6).tickCabSpeed(); }
       }
       
        //user has clicked elevator 6's down button for cab speed information
       if(mouseY>=255 & mouseY <=270) {
         if(elevators.size() >= 6) { elevators.get(6).tickCabSpeedDown(); }
       }
       
       
       //user has clicked elevator 7's up button for cab speed information
       if(mouseY>=276 & mouseY <=291) {
         if(elevators.size() >= 7) { elevators.get(7).tickCabSpeed(); }
       }
       
        //user has clicked elevator 7's down button for cab speed information
       if(mouseY>=292 & mouseY <=307) {
         if(elevators.size() >= 7) { elevators.get(7).tickCabSpeedDown(); }
       }
       
       
       
     }
     
     
     //adjusting door speed information
     if(mouseX>=1017 & mouseX<=1047) {
       
       //user has clicked elevator 0's up button for cab speed information
       if(mouseY>=17 & mouseY <=32) {
         if(elevators.size() >= 1) { elevators.get(0).tickDoorSpeed(); }
       }
       
        //user has clicked elevator 0's down button for cab speed information
       if(mouseY>=33 & mouseY <=48) {
         if(elevators.size() >= 1) { elevators.get(0).tickDoorSpeedDown(); }
       }
       
       
       //user has clicked elevator 1's up button for cab speed information
       if(mouseY>=54 & mouseY <=69) {
         if(elevators.size() >= 2) { elevators.get(1).tickDoorSpeed(); }
       }
       
        //user has clicked elevator 1's down button for cab speed information
       if(mouseY>=70 & mouseY <=85) {
         if(elevators.size() >= 2) { elevators.get(1).tickDoorSpeedDown(); }
       }
       
       
       //user has clicked elevator 2's up button for cab speed information
       if(mouseY>=91 & mouseY <=106) {
         if(elevators.size() >= 3) { elevators.get(2).tickDoorSpeed(); }
       }
       
        //user has clicked elevator 2's down button for cab speed information
       if(mouseY>=107 & mouseY <=122) {
         if(elevators.size() >= 3) { elevators.get(2).tickDoorSpeedDown(); }
       }
       
       
       //user has clicked elevator 3's up button for cab speed information
       if(mouseY>=128 & mouseY <=143) {
         if(elevators.size() >= 4) { elevators.get(3).tickDoorSpeed(); }
       }
       
        //user has clicked elevator 3's down button for cab speed information
       if(mouseY>=144 & mouseY <=159) {
         if(elevators.size() >= 4) { elevators.get(3).tickDoorSpeedDown(); }
       }
       
       
       //user has clicked elevator 4's up button for cab speed information
       if(mouseY>=165 & mouseY <=180) {
         if(elevators.size() >= 5) { elevators.get(4).tickDoorSpeed(); }
       }
       
        //user has clicked elevator 4's down button for cab speed information
       if(mouseY>=181 & mouseY <=196) {
         if(elevators.size() >= 5) { elevators.get(4).tickDoorSpeedDown(); }
       }
       
       
       //user has clicked elevator 5's up button for cab speed information
       if(mouseY>=202 & mouseY <=217) {
         if(elevators.size() >= 6) { elevators.get(5).tickDoorSpeed(); }
       }
       
        //user has clicked elevator 5's down button for cab speed information
       if(mouseY>=218 & mouseY <=233) {
         if(elevators.size() >= 6) { elevators.get(5).tickDoorSpeedDown(); }
       }
       
       
       //user has clicked elevator 6's up button for cab speed information
       if(mouseY>=239 & mouseY <=254) {
         if(elevators.size() >= 6) { elevators.get(6).tickDoorSpeed(); }
       }
       
        //user has clicked elevator 6's down button for cab speed information
       if(mouseY>=255 & mouseY <=270) {
         if(elevators.size() >= 6) { elevators.get(6).tickDoorSpeedDown(); }
       }
       
       
       //user has clicked elevator 7's up button for cab speed information
       if(mouseY>=276 & mouseY <=291) {
         if(elevators.size() >= 7) { elevators.get(7).tickDoorSpeed(); }
       }
       
        //user has clicked elevator 7's down button for cab speed information
       if(mouseY>=292 & mouseY <=307) {
         if(elevators.size() >= 7) { elevators.get(7).tickDoorSpeedDown(); }
       }
       
       
       
       
       
       
     }
    
    
  }
   
 
}
