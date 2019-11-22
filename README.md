# Introducing: The Kitchen Takeover

![alt text][intro]

[intro]: https://github.com/tantantheman/tantan-knochbox/blob/master/photos/knochoverview.jpeg "Knochbox Overview"

A visualization and mesh network for class. Module 6, Task 2 (Distributed Networks).  
Programming in Arduino IDE and Processing.  

**Dependencies:**  
painlessMesh.h  


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
An ESP32 is connected to the laptop containing the visualization. This ESP uses the same PainlessMesh system for communication, but instead of sending messages it simply listens for all incoming data. The data is read over serial in a Processing visualization.  

The Processing visualization first allows for the mapping of the space, as a user draws rectangles with the mouse. When the user is finished, the keypress of 'g' will remove the crosshairs and allow the rectangles to be the main event. Users can also manually change the colors as if sensors were being activated, with keys of 'f', 'm', 'c', and 'd' for the fridge, microwave, cabinet, and door respectively.  

## Visualization  
For my visualization, I wanted to play with the blandness of the AKW Lounge Kitchen. The cabinets are a stark white, as are many of the applicances. The lounge is always a place of academic stress, where many departments hold office hours and people work on PSETs many hours into the night. Why not try to bring splashes of color into the space and make it fun?  

As a result, I decided to use code that I had used to map out the Becton Cafe LED wall in order to accurately map out all the surfaces I wanted to project color on in the kitchen. A projector is placed across the kitchen near the window area, and the kitchen provides as a wonderful canvas for the visualization. I used the mesh network setup in order to change the color palette of the space based on which sensors were activated.  

When the microwave sensor is activated, the color palette of the space transforms into warm hues of red and pink. The reds and pinks change as the microwave continues to be used.  

When the fridge sensor is activated, the color palette of the space changes into cool shades of green.  

When the cabinet is opened, any changes in color immediately freeze and you can see the last iteration of the randomly generated color scheme.  

When someone passes through the door next to the lounge, the rectangles erupt into all different colors, creating a vibrant palette reminiscent of a stereotypically painted house in the 1960's, or the set of Pee Wee Herman's Playhouse. 
 
## Technical Difficulties: 
This was perhaps the most complex module in terms of execution. As a result, there were a few technical difficulties during the creation of the mesh network sensor and the visualization.  

While the design of the ultrasonic sensor involved a small LiPo battery, the LiPo battery stopped taking a charge and thus a portable battery pack had to be swapped in during the actual deployment. In addition, the sensor initially had two ultrasonic sensors next to each other, and was able to detect entrance or exit from the doorway. However, there was an unknown issue with the wiring that prevented the second sensor from working properly. 

PainlessMesh, despite the name, is not painless at all. There were latency issues we discovered during the A.K. Watson takeover, as the visualization did not always correspond to the sensor data in realtime due to unknown reasons. In addition, when all the members of our group deployed some sort of visualization or sonification, we noticed that our various creations would respond differently to different ESP nodes. This made our different creations respond slightly differently.

**Video**  
A video of the KnöchBox in action can be found here:  
https://youtu.be/6DZXhUA5q48  
