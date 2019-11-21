import processing.serial.*;
Serial myPort;
String val;

int count = 0;
int rectA, rectB, rectC, rectD;
boolean isDrawing = false;
PrintWriter output;

int finishedDrawing;

String microwaveOn = "Microwave On" ;
String microwaveOff = "Microwave Off";

String doorPass = "IN";

String fridgeTouch = "Touch";
String fridgeRelease = "Released"; 

String cabinetOpen = "Open";
String cabinetClosed = "Closed";

int fridge = 0;
int fridgeToggle = 0;
int microwave = 0;
int microwaveToggle = 0;
int door = 0;
int doorToggle = 0;
int cabinet = 0;
int cabinetToggle = 0;


class Display {
  boolean exists = false;
  float r;
  float b;
  float g;
  float x;
  float y;
  float dWidth;
  float dHeight;
  int pos;
  String name;

  void draw() {
    // draw the rectangle with fill
    fill(color(r, b, g));
    rect(x, y, dWidth, dHeight);
  }
  

  void clear() {
    exists = false;
  }
}

Display[] displayData = new Display[100];


void setup() {
  // setup processing interface
  fullScreen();
  output = createWriter("mapping_info.txt"); 

  //println(Serial.list());
  String portName = Serial.list()[2]; //change the 0 to a 1 or 2 etc. to match your port
  myPort = new Serial(this, portName, 9600);
  myPort.bufferUntil('\n');
  
}

void draw() {
  // clear the background
  if (!isDrawing) {
    background(255, 255, 255);
  }
  // draw all rectangles/displays
  
  for (int i = 0; i < count; i = i+1) {
    if (displayData[i].exists) {
      displayData[i].draw();
    }
  }
  
    if (finishedDrawing == 0)
    {
    line(mouseX, 0, mouseX, height);
    line(0, mouseY, width, mouseY);
    
    text( "x: " + mouseX + " y: " + mouseY, mouseX, mouseY );
    fill(0, 0, 0);
    }
    
    if ( myPort.available() > 0) 
  {  // If data is available,
      val = myPort.readStringUntil('\n'); 
  }
  
   if (val != null)
  {
    val = trim(val);
    println(val);
    
    if (val.compareTo("IN") == 0)
    {
      for (int i = 0; i< count; i++)
      {
         displayData[i].r = random(255);
         displayData[i].g = random(255);
         displayData[i].b = random(255);
      }
      delay(500);
      //what to do when activity at the DOOR
    }
    if (val.compareTo(microwaveOn) == 0)
    {
       strokeWeight(0);
      for (int i = 0; i<count; i++)
      {
        displayData[i].r = 255;
        displayData[i].g = random(255);
        displayData[i].b = 0;
      }       
      delay(500);
    
    if (val.compareTo(microwaveOff) == 0)
    {
      strokeWeight(0);
      for (int i = 0; i<count; i++)
      {
        displayData[i].r = random(255);
        displayData[i].g = random(255);
        displayData[i].b = random(255);
      }    
    }
    if (val.compareTo(fridgeTouch) == 0)
    {
      strokeWeight(0);
      for (int i = 0; i<count; i++)
      {
        displayData[i].r = 0;
        displayData[i].g = 102;
        displayData[i].b = random(255);
      }    
      delay(500);
    }
    if (val.compareTo(fridgeRelease) == 0)
    {
      strokeWeight(0);
      for (int i = 0; i<count; i++)
      {
        displayData[i].r = random(255);
        displayData[i].g = random(255);
        displayData[i].b = random(255);
      }        
    }
    if (val.compareTo(cabinetOpen) == 0)
    {
      //what to do when cabinet is OPEN
      strokeWeight(0);
      for (int i = 0; i<count; i++)
      {
        displayData[i].r = 255;
        displayData[i].g = 255;
        displayData[i].b = 255;
      }
      delay(500);
     // systems.add(new ParticleSystem(1, new PVector(598.75, height-295.0)));
    }
    if (val.compareTo(cabinetClosed) == 0)
    {
      //what to do when cabinet is CLOSED
      strokeWeight(0);
      for (int i = 0; i<count; i++)
      {
        displayData[i].r = random(255);
        displayData[i].g = random(255);
        displayData[i].b = random(255);
      }
      delay(500);
    }
  }
}
}

void mousePressed() {
  if (!isDrawing) {
    // start drawing new object
    rectA = mouseX;
    rectB = mouseY;
    isDrawing = true;
  } else {
    
    // finish drawing new object
    isDrawing = false;
    rectC = mouseX - rectA;
    rectD = mouseY - rectB;
    
    // sets x,y coord as the top left hand corner
    if (rectA > mouseX) {
      rectA = mouseX;
      rectC = rectC * -1; 
    }
    if (rectB > mouseY) {
      rectB = mouseY;
      rectD = rectD * -1;
    }
     
    // create display object 
    displayData[count] = new Display();
    displayData[count].x = rectA;
    displayData[count].y = rectB;
    displayData[count].dWidth = rectC;
    displayData[count].dHeight = rectD;
    displayData[count].r = random(255) * 1.3; // made colors lighter 
    displayData[count].b = random(255) * 1.3; // to better see the 
    displayData[count].g = random(255) * 1.3; // black font
    displayData[count].exists = true;
    displayData[count].pos = count;
    output.println("Rectangle " + count);
    output.println("Height: " + displayData[count].dHeight + "px");
    output.println("Width: " + displayData[count].dWidth + "px");
    output.println("x: " + displayData[count].x);
    output.println("y: " + displayData[count].y);
    output.println(""); 

    count += 1;
    
    //need to add displayData[count].dWidth to a new array of just widths with count and height
  }
  
}

void mouseMoved() {
  if (isDrawing) {
    background(255, 255, 255); 
    draw();
    rect(rectA, rectB, mouseX - rectA, mouseY - rectB);
  }
}

void keyPressed() {
  // save frame
  if (key == 's' || key == 'S') {
    saveFrame("mapping-###.png");
    output.flush();
    output.close();
  }
  // clear all displays
  if (key == 'q' || key == 'Q') {
    for (int i = 0; i < count; i = i+1) {
      displayData[i].clear();
    }
  }
  // exit
  if (key == ESC) {
    exit();
  }
  if (key == 'd' || key == 'D')
  {
    strokeWeight(0);
    for (int i = 0; i<count; i++)
    {
      displayData[i].r = random(255);
      displayData[i].g = random(255);
      displayData[i].b = random(255);
    }
  }
  
  if (key == 'm' || key == 'M')
  {
    strokeWeight(0);
    for (int i = 0; i<count; i++)
    {
      displayData[i].r = 255;
      displayData[i].g = random(255);
      displayData[i].b = 0;
    }
  }
  
  if (key == 'f' || key == 'F')
  {
    strokeWeight(0);
    for (int i = 0; i<count; i++)
    {
      displayData[i].r = 0;
      displayData[i].g = 0;
      displayData[i].b = random(255);
    }
  }
  
  if (key == 'c' || key == 'C')
  {
    strokeWeight(0);
    for (int i = 0; i<count; i++)
    {
      displayData[i].r = 255;
      displayData[i].g = 255;
      displayData[i].b = 255;
    }
  }
  
  if (key == 'g' || key == 'G')
  {
    finishedDrawing = 1;
  }
  
  
}
