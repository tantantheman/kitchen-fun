# Introducing: The Kitchen Takeover

![alt text][intro]

[intro]: https://github.com/tantantheman/tantan-knochbox/blob/master/photos/knochoverview.jpeg "Knochbox Overview"

A visualization and mesh network for class. Module 6, Task 2 (Distributed Networks).  
Programming in Arduino IDE and Processing.  

**Dependencies:**  
painlessMesh.h  

**Introduction:**  

Objective: The goal in the box is to try and guess the correct sequence of knocks in order to "unlock" the puzzle box. If the number of knocks in a set is correct, you advance onto the next section of the 5-set sequence. An incorrect guess will reveal how close you were to guessing that set, allowing you to try again. If you go over the number of knocks in a set, the accuracy displays as 0%. When the box is unlocked, it resets. 

## Mesh Network and Setup 
As a four person team, we used four ESP32 devices to create four distinct sensors. They are placed in four places within the general kitchen space on the second floor of AK Watson Hall, designed for individual visualization/sonification that pertains to the usage of the space. They are: above the door, on the refridgerator, on the microwave, and inside a cabinet. I was responsible for creating the Ultrasonic Door Sensor. 

- Cabinet Sensor  
By using a modified button, we are able to detect when a specific cabinet in the kitchen is open, and when it is closed.  

- Fridge Sensor  
By transforming the handle of the refridgerator into a giant capacitive touch surface by covering it with aluminum foil and wiring it to an ESP32, we can know when the handle is being touched or released.  

- Piezoelectric Sensor
By attaching a piezoelectric sensor to the door release button of the microwave, we are able to know when the microwave is being used. 

- Door Sensor  
By creating an sensor mounted above the door next to the kitchen with two ultrasonic sensors and an ESP32, we are able to tell when someone either enters or exits the room through the stairwell. In the final product, due to technical issues, the door sensor is simplified to one ultrasonic sensor and indicates when there is movement under the door frame.
  
**Implementation:**  
To create the puzzle box that is the KnöchBox, only a few parts were actually needed.

The enclosure was largely inspired by that of the Fart-O-Matic, where utilizing the top panel of the box essentially as a large button allows for the "knocking" effect that the user can use to interact with the box.  
## Visualization  
For my visualization, I wanted to play with the blandness of the AKW Lounge Kitchen. The cabinets are a stark white, as are many of the applicances. The lounge is always a place of academic stress, where many departments hold office hours and people work on PSETs many hours into the night. Why not try to bring splashes of color into the space and make it fun?  

As a result, I decided to use code that I had used to map out the Becton Cafe LED wall in order to accurately map out all the surfaces I wanted to project color on in the kitchen. A projector is placed across the kitchen near the window area, and the kitchen provides as a wonderful canvas for the visualization. 
 

**Technical Difficulties:**  
Battery Shot

PainlessMesh 

Ultrasonic Sensor
**Video**  
A video of the KnöchBox in action can be found here:  
https://youtu.be/6DZXhUA5q48  
