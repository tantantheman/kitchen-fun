import processing.serial.*;
//no 10 11 12 13 rectangles needed
Serial myPort;
String val;

int fridge = 0;
int fridgeToggle = 0;
int microwave = 0;
int microwaveToggle = 0;
int door = 0;
int doorToggle = 1;
int cabinet = 0;
int cabinetToggle = 1;


int globalColorR = int(random(0, 255));
int globalColorG = int(random(0, 255));
int globalColorB = int(random(0, 255));
//let fire = [];

String microwaveOn = "Microwave On" ;
String microwaveOff = "Microwave Off";

String doorPass = "IN";

String fridgeTouch = "Touch";
String fridgeRelease = "Released"; 

String cabinetOpen = "Open";
String cabinetClosed = "Closed";

//for particles!
int count = 0;
int uhOh = 0;
int removeParticles = 0;
ArrayList<ParticleSystem> systems;

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
    // draw the text
  }

  void clear() {
    exists = false;
  }
}

Display[] displayData = new Display[12];

void setup()
{
  //fullScreen();
  size(800, 600);
  background(153);
  systems = new ArrayList<ParticleSystem>();

  //println(Serial.list());
  String portName = Serial.list()[2]; //change the 0 to a 1 or 2 etc. to match your port
  myPort = new Serial(this, portName, 9600);
  myPort.bufferUntil('\n');
  
  
}

// data support from the serial port
void serialEvent(Serial myPort) 
{
  // read the data until the newline n apphears
  val = myPort.readStringUntil('\n');

}


void draw()
{

   for (int i = systems.size()-1; i >= 0; i--) {
    ParticleSystem ps = (ParticleSystem) systems.get(i);
    ps.run();
    ps.addParticle();

    if (uhOh == 1) {
      systems.remove(i);
    }
  }
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
    if (val.compareTo(microwaveOn) == 0 || microwave == 1)
    {
      //systems.add(new ParticleSystem(1, new PVector(mouseX, mouseY)));
    if (val.compareTo(microwaveOff) == 0 || microwave == 0)
    {
      //what to do when microwave is OFF
    }
    if (val.compareTo(doorPass) == 0 || door == 1)
    {
      rect(100, 100, 23, 100);
       //fill(230);
         stroke(152);
        

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
      
      systems.add(new ParticleSystem(1, new PVector(598.75, height-295.0)));
    }
    if (val.compareTo(cabinetClosed) == 0)
    {
      //what to do when cabinet is CLOSED
    }
  }
}
}


class ParticleSystem {

  ArrayList<Particle> particles;    // An arraylist for all the particles
  PVector origin;                   // An origin point for where particles are birthed

  ParticleSystem(int num, PVector v) {
    particles = new ArrayList<Particle>();   // Initialize the arraylist
    origin = v.copy();                        // Store the origin point
    for (int i = 0; i < num; i++) {
      particles.add(new Particle(origin));    // Add "num" amount of particles to the arraylist
    }
  }


  void run() {
    // Cycle through the ArrayList backwards, because we are deleting while iterating
    for (int i = particles.size()-1; i >= 0; i--) {
      Particle p = particles.get(i);
      p.run();
      if (p.isDead()) {
        particles.remove(i);
      }
    }
  }
  
  void killOff() {
    for (int i = particles.size()-1; i >= 0; i--) {
      Particle p = particles.get(i);
      p.lifespan = 0;
    }
  }


  void addParticle() {
    Particle p;
    // Add either a Particle or CrazyParticle to the system
      p = new Particle(origin);

    particles.add(p);
  }

  void addParticle(Particle p) {
    particles.add(p);
  }

  // A method to test if the particle system still has particles
  boolean dead() {
    return particles.isEmpty();
  }
}

// A simple Particle class

class Particle {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float lifespan;

  Particle(PVector l) {
    //acceleration = new PVector(0, 0.05);
    acceleration = new PVector(0, 0.4);
    velocity = new PVector(random(-1, 1), random(-2, 0));
    position = l.copy();
    lifespan = 150.0;
  }

  void run() {
    update();
    display();
  }
  
  // Method to update position
  void update() {
    velocity.add(acceleration);
    position.add(velocity);
    lifespan -= 2.0;
  }

  // Method to display
  void display() {
    //stroke(255, lifespan);
    fill(globalColorR, globalColorG, globalColorB);
    ellipse(position.x, position.y, 8, 8);
  }

  // Is the particle still useful?
  boolean isDead() {
    return (lifespan < 0.0);
  }
}


void keyPressed() {
  // save frame
  if (key == 'f' || key == 'F') {
   if (fridgeToggle == 0)
   {
   fridge = 1;
   }
   if (fridgeToggle == 1)
   {
     fridge = 0;
   }
  }
  
  if (key == 'd' || key == 'D')
  {
    if (doorToggle == 0)
    {
      door = 1;
    }
    if (doorToggle == 1)
    {
      door = 0;
    }
  }
  // clear all displays
  if (key == 'd' || key == 'D') {
    for (int i = 0; i < count; i = i+1) {
      displayData[i].clear();
    }
  }
  // exit
  if (key == 'e' || key == 'E') {
    exit();
  }
}
