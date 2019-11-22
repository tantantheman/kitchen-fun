//************************************************************
// this is a simple example that uses the painlessMesh library
//
// 1. sends a silly message to every node on the mesh at a random time between 1 and 5 seconds
// 2. prints anything it receives to Serial.print
//
//
//************************************************************
#include "painlessMesh.h"
#include <ESP32Servo.h>

#define   MESH_PREFIX     "TheBees"
#define   MESH_PASSWORD   "TheHiveLives"
#define   MESH_PORT       5555
#define   INIT_DELAY      240000

int DELAY = INIT_DELAY;
int counter = 0;

Servo myServo1;
int pos1 = 0;

int servoPin1 = 26;

Servo myServo2;
int pos2 = 0;

int servoPin2 = 27;
int delayTime = 50;

const int CABINET = 34;
bool prevVal = false;
bool opened = false;

Scheduler userScheduler; // to control your personal task
painlessMesh mesh;
String msg = "";

// User stub
void sendMessage() ; // Prototype so PlatformIO doesn't complain

Task taskSendMessage( TASK_SECOND * 1 , TASK_FOREVER, &sendMessage );

void sendMessage() {
  Serial.println(TASK_SECOND);
  if (digitalRead(CABINET) == 1) {    
    prevVal = opened;
    opened = false;
  }
  else {
    prevVal = opened;
    opened = true;
    counter = 0;
  } 

  if (prevVal != opened) {
    if (opened){
      msg = "Open";
      DELAY = INIT_DELAY;
    }
    else
      msg = "Closed";
    
    mesh.sendBroadcast( msg );
  }
  //taskSendMessage.setInterval( random( TASK_SECOND * 1, TASK_SECOND * 5 ));
  
}

// Needed for painless library
void receivedCallback( uint32_t from, String &msg ) {
  Serial.printf("startHere: Received from %u msg=%s\n", from, msg.c_str());
   // checking where the message came from 
    if(msg.equals("Microwave On"))
      DELAY = (int)DELAY * 0.5;

    /*case "Microwave Off": 
      // statements
      break;*/
    if(msg.equals("Fridge Touch"))
      DELAY = (int)DELAY * 1.5;

    /*case "Fridge Released": 
      // statements
    */
    if(msg.equals("IN"))
      knock();

  
}

void knock(){
  int i = 0;

  while (i < 30){
    myServo1.write(180);

    delay(delayTime);

    myServo2.write(180);  

    delay(delayTime);

    myServo1.write(175);

    delay(delayTime);
  
    myServo2.write(162);

    delay(delayTime);
    i++;
  }
}

void newConnectionCallback(uint32_t nodeId) {
    Serial.printf("--> startHere: New Connection, nodeId = %u\n", nodeId);
}

void changedConnectionCallback() {
  Serial.printf("Changed connections\n");
}

void nodeTimeAdjustedCallback(int32_t offset) {
    Serial.printf("Adjusted time %u. Offset = %d\n", mesh.getNodeTime(),offset);
}

void setup() {
  Serial.begin(115200);

  pinMode(CABINET, INPUT);

  pinMode(servoPin1, OUTPUT);
  pinMode(servoPin2, OUTPUT);

  myServo1.setPeriodHertz(50);
  myServo1.attach(servoPin1);

  myServo2.setPeriodHertz(50);
  myServo2.attach(servoPin2);

  myServo1.write(180);
  myServo2.write(180);
  delay(15);
//mesh.setDebugMsgTypes( ERROR | MESH_STATUS | CONNECTION | SYNC | COMMUNICATION | GENERAL | MSG_TYPES | REMOTE ); // all types on
  mesh.setDebugMsgTypes( ERROR | STARTUP );  // set before init() so that you can see startup messages

  mesh.init( MESH_PREFIX, MESH_PASSWORD, &userScheduler, MESH_PORT );
  mesh.onReceive(&receivedCallback);
  mesh.onNewConnection(&newConnectionCallback);
  mesh.onChangedConnections(&changedConnectionCallback);
  mesh.onNodeTimeAdjusted(&nodeTimeAdjustedCallback);

  userScheduler.addTask( taskSendMessage );
  taskSendMessage.enable();
}

void loop() {
  mesh.update();
  delay(1);
  DELAY--;
  if(DELAY == 0){
    knock();
    knock();
    knock();
    //on heaven's dOoOooorr
    DELAY = INIT_DELAY;
  }
}
