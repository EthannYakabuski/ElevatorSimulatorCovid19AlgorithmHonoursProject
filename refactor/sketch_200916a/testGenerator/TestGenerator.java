import java.io.File;
import java.io.FileNotFoundException; 
import java.util.Scanner; 
import java.util.Collection;
import java.util.HashMap;
import java.util.ArrayList; 
import java.util.Comparator; 
import java.util.Collections; 
import java.io.FileWriter; 
import java.io.IOException; 
import java.util.Random;


class TestGenerator {


//command line argument is: 
//all command options are necessary
//java TestGenerator [numFloors] [numRooms] [populationPerRoom] [totalRequests] [minimumPauseTime] [maximumPauseTime]

public static void main(String[] args) {
	  System.out.println("here"); 
	  
	  
	  Random rand = new Random();
	  
	  int numFloors = Integer.parseInt(args[0]); 
	  
	  int numRooms = Integer.parseInt(args[1]); 
	  
	  int popPerRoom = Integer.parseInt(args[2]); 
	  
	  int totalRequests = Integer.parseInt(args[3]); 
	  
	  int minimumPauseTime = Integer.parseInt(args[4]); 
	  
	  int maximumPauseTime = Integer.parseInt(args[5]); 
	  
	  System.out.println(maximumPauseTime);
	  
	  if(numFloors > 30) { 
		  System.out.println("Floors too high"); 
	  }
	  if(numRooms > 30) {
		  System.out.println("Rooms too high"); 
	  }
	  
	  //the reason for /2 here is because if the user gives totalRequests = popPerRoom*numRooms*numFloors then
	  //this probabilistic algorithm will not finish in a reasonable amount of time
	  if(totalRequests/2 > popPerRoom*numRooms*numFloors) {
		  System.out.println("Total Requests too large for the given population"); 
	  }
	  
	  //three dimensional array to represent the building
	  int[][][] building = new int[numFloors][numRooms][popPerRoom];
	  
	  //initialize this array with 0'so
	  for(int nf = 0; nf < numFloors; nf++) {
		  for(int nr = 0; nr < numRooms; nr++) {
			  for(int pr = 0; pr < popPerRoom; pr++) {
				  
				  //this person has not been picked up yet 
				  building[nf][nr][pr] = 0; 
				  
			  }
			  
		  }
		  
	  }
	  
	  try {
	    FileWriter fw = new FileWriter("outputTest.txt",true);
		//write the opening characters to the test file
		fw.write("0//"); 
		fw.close(); 
	  } catch (IOException error) {
		  System.out.println("error"); 
		  error.printStackTrace(); 
		  
	  }
	  
	  
	  for(int i = 0; i < totalRequests; i++) {
		  boolean stop = true; 
		  
		  while(stop) {
		  
			//determine a random number between 2 and numFloors-1 inclusive
			int ranFloor = rand.nextInt(numFloors-2) + 2;
			//System.out.println("ranFloor: " + ranFloor); 
		  
			//determine a random number between 0 and numRooms-1 inclusive
			int ranRoom = rand.nextInt(numRooms);
			//System.out.println("ranRoom: " + ranRoom);
		  
			//determine a random number between 0 and popPerRoom-1 inclusive
			int ranPop = rand.nextInt(popPerRoom);
			//System.out.println("ranPop: " + ranPop);
		  
			//check if this person has already been given a job, if so try new random numbers
			
			if (building[ranFloor][ranRoom][ranPop] == 1) {
				//this person has already been given a job
				continue;
				
			} else {
				//this person has not been given a job yet
				
				//change their value
				building[ranFloor][ranRoom][ranPop] = 1; 
				stop = false; 
				
				
				//determine the wait time
				int waitTime = rand.nextInt(maximumPauseTime-minimumPauseTime) + minimumPauseTime;
				waitTime = waitTime*15; 
				
				//write to the file
				try {
					FileWriter fw = new FileWriter("outputTest.txt",true);
					String requestString = ""; 
					
					//start building the request string based on the random numbers generated
					
					//persons floor now
					requestString = requestString + ranFloor; 
					requestString = requestString + ":"; 
					
					//persons room now
					requestString = requestString + ranRoom; 
					requestString = requestString + ":"; 
					
					//persons destination floor
					requestString = requestString + "1";
					requestString = requestString + ":";
				
				    //persons destination room eg: 99 -> leaving the building
					requestString = requestString + "99"; 
					requestString = requestString + ":"; 
					
					//frames to wait until next event
					requestString = requestString + waitTime; 
					requestString = requestString + "//";
					
					
					
					fw.write(requestString); 
					fw.close(); 
				} catch (IOException error) {
					System.out.println("error"); 
						error.printStackTrace(); 
		  
				}
				
				
				
			}
			
			
		  }
		  
		  
		  
	  }
	  
	  
	  try {
	    FileWriter fw = new FileWriter("outputTest.txt",true);
		//write the ending characters to the test file
		fw.write("?!"); 
		fw.close(); 
	  } catch (IOException error) {
		  System.out.println("error"); 
		  error.printStackTrace(); 
		  
	  }
		
	}



}