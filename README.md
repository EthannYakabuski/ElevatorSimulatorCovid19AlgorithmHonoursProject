# ElevatorSimulator-Covid19Algorithm-HonoursProject

(In development)

To download processing: https://processing.org/download/


Features: 

Highrise building elevator simulator, simulates custom building dimensions up to 30 rooms x 30 floors. Adjust population of each room individually on the GUI or using customized scripts with a few formatting restrictions, or use quick populate function sliders for an even distribution of tenants. 

Use a simgple GUI to program up to 8 elevators, adjusting various attributes to simulate your specific elevator situation perfectly. Choose from a few common elevator algorithms, or indicate your own with a few formatting restrictions. Real time data screen for elevators and highrise population movement, also included is more documented statistics in exported XML format. 

Pseudo random distributions and provided realistic data sets mimicing real life population movements in high rises. Indicate your own series of elevator queue requests as well with a few formatting restrictions.

Run the simulation for up to 24 simulated hours viewing the action from real time up to 8x. 


HOW TO FORMAT YOUR QUEUE FILES: 

Your input queue file should follow the format put forth in queueFile1.txt. 
0//4:4:1:99:10//2:6:1:99:40//7:2:1:99:10//3:1:1:99:100//6:4:1:99:15//?!

Your first character will be the delay you want before the first job is given from the event scheduler, you should then proceed this by '//'. 
Your subsequent characters should be a 5-Tuple which each element of the tuple separated by ':', and each 5-tuple separated by '//'. Code 99 for persons destination room signifies that they wish to leave the building. follow the format as follows for job creation attributes: 

personsFloorNow:personsRoomNow:personsDestinationFloor:personsDestinationRoom:framesToWaitUntilNextEvent

End the file with a '?!' character to signify that there are no more events to create for your programmed event scheduler


