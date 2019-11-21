import processing.serial.*;

Serial myPort;
String val;

String microwaveOn = "Microwave On" ;
String microwaveOff = "Microwave Off";

String doorPass = "IN";

String fridgeTouch = "Touch";
String fridgeRelease = "Released"; 

String cabinetOpen = "Open";
String cabinetClosed = "Closed";

void setup()
{
  size(320, 240);
  background(153);
  //println(Serial.list());
  String portName = Serial.list()[2]; //change the 0 to a 1 or 2 etc. to match your port
  myPort = new Serial(this, portName, 9600);
  myPort.bufferUntil('\n');
  
}

// data support from the serial port
void serialEvent(Serial myPort) 
{
  // read the data until the newline n appears
  val = myPort.readStringUntil('\n');

}

void draw()
{
   if ( myPort.available() > 0) 
  {  // If data is available,
      val = myPort.readStringUntil('\n'); 
  }
  
   if (val != null)
  {
    val = trim(val);
    println(val);
        
    // break up the decimal and new line reading
    //int[] vals = int(splitTokens(val, ","));
    if (val.compareTo(microwaveOn) == 0)
    {
      //what to do when microwave is ON
    }
    if (val.compareTo(microwaveOff) == 0)
    {
      //what to do when microwave is OFF
    }
    if (val.compareTo(doorPass) == 0)
    {
      rect(100, 100, 23, 100);
       //fill(230);
         //stroke(152);
        

      //what to do when activity at the DOOR
    }
    if (val.compareTo(fridgeTouch) == 0)
    {
      //what to do when fridge is TOUCHED
    }
    if (val.compareTo(fridgeRelease) == 0)
    {
      //what to do when fridge is RELEASED
    }
    if (val.compareTo(cabinetOpen) == 0)
    {
      //what to do when cabinet is OPEN
    }
    if (val.compareTo(cabinetClosed) == 0)
    {
      //what to do when cabinet is CLOSED
    }
  }
}
