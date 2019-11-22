//************************************************************
// this is a simple example that uses the painlessMesh library
//
// 1. sends a silly message to every node on the mesh at a random time between 1 and 5 seconds
// 2. prints anything it receives to Serial.print
//
//
//************************************************************
#include "painlessMesh.h"

#define   MESH_PREFIX     "TheBees"
#define   MESH_PASSWORD   "TheHiveLives"
#define   MESH_PORT       5555

int ind_pin = 36;
//float lastFive[5] = {0,0,0,0,0};
//int fiveInd = 0;
//float diff = 200.0;
int wasOn= 0;
int toSend = 0;

Scheduler userScheduler; // to control your personal task
painlessMesh  mesh;

// User stub
void sendMessage() ; // Prototype so PlatformIO doesn't complain

Task taskSendMessage( TASK_SECOND * 1 , TASK_FOREVER, &sendMessage );

void sendMessage() {

  float avg = (lastFive[0] + lastFive[1] + lastFive[2] + lastFive[3] + lastFive[4])/5;

  String msg = "Microwave ";
  float val = analogRead(ind_pin);
  //Serial.print("Message Sent: " + String(val) + "\n");
  //lastFive[fiveInd] = val;
  //fiveInd = (fiveInd + 1) %5;
  
  if(val > 0 && wasOn == 0 ){ //&& abs(lastFive[0] - avg) < diff && abs(lastFive[1] - avg) < diff && abs(lastFive[2] - avg) < diff &&
    //abs(lastFive[3] - avg) < diff && abs(lastFive[4] - avg) < diff){
      wasOn = 1;
      msg += "On";
      toSend = 1;
    }
  else if(val == 0 && wasOn == 1){// && !(abs(lastFive[0] - avg) < diff && abs(lastFive[1] - avg) < diff && abs(lastFive[2] - avg) < diff &&
    //abs(lastFive[3] - avg) < diff && abs(lastFive[4] - avg) < diff)){
      wasOn = 0;
      msg += "Off";
      toSend = 1;
    }
  
  //msg += mesh.getNodeId();
  //float val = analogRead(ind_pin);
  //msg += val;
  if(toSend == 1){
    mesh.sendBroadcast( msg );
    toSend = 0;
  }
  taskSendMessage.setInterval(random( TASK_SECOND * 1, TASK_SECOND * 5 ));
}

// Needed for painless library
void receivedCallback( uint32_t from, String &msg ) {
  Serial.printf("startHere: Received from %u msg=%s\n", from, msg.c_str());
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

//mesh.setDebugMsgTypes( ERROR | MESH_STATUS | CONNECTION | SYNC | COMMUNICATION | GENERAL | MSG_TYPES | REMOTE ); // all types on
  mesh.setDebugMsgTypes( ERROR | STARTUP );  // set before init() so that you can see startup messages

  mesh.init( MESH_PREFIX, MESH_PASSWORD, &userScheduler, MESH_PORT );
  mesh.onReceive(&receivedCallback);
  mesh.onNewConnection(&newConnectionCallback);
  mesh.onChangedConnections(&changedConnectionCallback);
  mesh.onNodeTimeAdjusted(&nodeTimeAdjustedCallback);

  userScheduler.addTask( taskSendMessage );
  taskSendMessage.enable();

  pinMode(ind_pin, INPUT);
}

void loop() {
  // it will run the user scheduler as well
  mesh.update();
  //Serial.print(String(analogRead(ind_pin)) + "\n");
  //Serial.print("still runnin'\n");
  
}
