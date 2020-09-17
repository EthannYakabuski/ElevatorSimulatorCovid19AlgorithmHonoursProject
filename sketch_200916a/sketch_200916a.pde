//library for GUI elements
//https://github.com/sojamo/controlp5
import controlP5.*;

import java.util.Arrays;


int width= 1600; 
int height = 950; 



ControlP5 guiControl; 


//apartment sizes sliders
int maxFloors = 40; 
int minFloors = 2;
int numFloors = 2; 

int minRoomsPerFloor = 0;
int maxRoomsPerFloor = 30; 
int roomsPerFloor = 0; 

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
  
  drawBuilding();
  
  drawElevators();
  
  moveElevators();
  
}

void moveElevators() {
  
  for(int i = 0; i < elevators.size(); i++) {
    if(!(elevators.get(i).busy)) {
       elevators.get(i).moveUp();
      
      
    }
    
  }
  
  
  
}

void drawDeveloperControlsBackground() {
   rectMode(CENTER); 
   fill(#094BEA); 
   //nice blue behind the slider bars
   rect(1350,450,500,1200);
   
   
   //draw the building button
   fill(#F0112F);
   rect(1300,875,buttonSizeWidth,buttonSizeHeight);
   
   fill(0);
   textSize(12); 
   text("SPAWN ELEVATORS", 1245, 880);
  
}

void drawElevatorInformationPanel() {
   rectMode(CORNERS); 
   fill(255); 
   
   rect(600,0,1100,320);
   
   drawElevatorTextInfo(); 
   
  
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


//this function is responsible for object creation of the elevators given the information on the sliders when the build building button is hit
void makeElevators() {
  calculateShaftDimensions();
  
  
  elevators.clear();

  for(int i = 0; i < numElevators; i++) {
    elevators.add(new Elevator(elevatorCapacity, 0, elevatorDoorTime, shaftWidth, shaftHeight, elevatorSpeed, 660+i*60, 930, 660+i*60, 945)); 
    
    
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

void mousePressed() {
  
  
  System.out.println(mouseX); 
  System.out.println(mouseY); 
  
  
  
  //the user has clicked within the build building button
  if(mouseX>=1250 & mouseX <=1350) {
    
    if(mouseY>=850 & mouseY <=900) {
      
      buildingSpecified = true;
      makeElevators();
      drawBuilding();
      
    }
      
    }
 
}
