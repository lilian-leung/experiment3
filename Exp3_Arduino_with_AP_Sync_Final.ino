//Exp3 with AP Sync (for Arduino)

#include <AP_Sync.h>
AP_Sync sendSensor (Serial);

int ledPin1 = 12; //warm light - left
int ledPin2 = 11; //neon blue - right

int sensorPin1 = A2; //neon light - potentiometer
int sensorPin2 = A0; //warm light - physical button

int ledVal1 = 0;
int ledVal2 = 0;

//warm light brightness control
int ledBrightness;
int ledMinVal = 0;
int ledMaxVal = 255;

int sensor1val;
int sensor2val;

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  Mouse.begin();

  pinMode (sensorPin1, INPUT); //potentiometer
  pinMode (sensorPin2, INPUT);  //physical button
 
  pinMode(ledPin1, OUTPUT);
  pinMode(ledPin2, OUTPUT);
}


void loop() {
  // put your main code here, to run repeatedly:
sensor1val = analogRead(2);
sensor2val = analogRead(0);

//ledVal1 = map(sensor1val, 0, 1023, 0, 255);  //map the warm light 
ledVal2 = map(sensor2val, 1023, 200, 0, 255);  //map neon light 

analogWrite(ledPin1, ledBrightness);
analogWrite(ledPin2, ledVal2);


//if neon light is on, turn off warm light
if (sensor2val < 600) {
  ledBrightness = ledMinVal; 
  } else {
    ledBrightness = ledMaxVal;
  }



//print sensor value to make sure it works
Serial.print(sensor2val);
//Serial.print(sensor1val);

delay(100);

sendSensor.sync ("sensorLeft", sensor1val);
sendSensor.sync ("sensorRight", sensor2val);

}
