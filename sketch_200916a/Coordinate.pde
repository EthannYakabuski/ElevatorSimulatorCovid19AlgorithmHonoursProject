class Coordinate {
  
  int x; 
  int y; 
  
  Coordinate() {
    
    
  }
  
  
  Coordinate(int locX, int locY) {
   x = locX; 
   y = locY; 
    
  }
  
  String toString() {
    String returnString = ""; 
    
    returnString = returnString+"("+x+","+y+")"; 
    
    return returnString;
  }
  
  int getX() {
    return x; 
  }
  
  int getY() {
    return y; 
  }
  
}
