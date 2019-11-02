//image by Clement M on Unsplash: https://unsplash.com/photos/igX2deuD9lc
//audio, wide open by the chemical brothers, 2016

import apsync.*; 
import processing.serial.*;
import processing.sound.*; 

SoundFile rain;
SoundFile song;
SoundFile desert;

String serialPort = Serial.list()[1];

boolean showIntro,pausing;
boolean showRain;

int alpha = 100;

PImage img1;
PImage img2;
PImage img3;
PImage imgSand;
PImage imgRain;

//liquid distort
PVector[] p, speed;
int nb = 3, imageW, imageH;
float c1 = 4, c2 = 2;

public float sensorLeft;
public float sensorRight;

int time;

//rain var
float x,y;
int w;


AP_Sync readVals;

void setup() {
  fullScreen();
  //size (1280,720);
  background(255,239,212);
  //img assets
  img1 = loadImage("subheadlines-08.png");
  img2 = loadImage("subheadlines-09.png");
  img3 = loadImage("breathe_trade.png");
  imgRain = loadImage("bluemoon.png");
  imgSand = loadImage("sand.png");
    
  //audio assets
  rain = new SoundFile(this, "rain_3mins.mp3");
  desert = new SoundFile(this, "journeydesert.mp3");
  song = new SoundFile(this, "wideopen.mp3");
  
  
  //show intro
  showIntro = true;
  showRain = false;
 
  readVals = new AP_Sync(this, serialPort, 9600);
  
  desert.play();
  desert.amp (0.1);
  
}

void draw () {
     
  // title screen
    if (sensorLeft >= 900) {
    background(255,239,212);
    imageMode(CENTER);  
    image(imgSand, width/2, height/2, width, height);
    image(img2, width/2, height-height+100, 681,30);
    image(img1, width/2, height-100, 519,30 );
    image(img3, width/2, height/2);
      }
    
    
    if (sensorLeft <= 750 & showIntro) {
    background(5,5,30);
    showIntro = false;
    desert.stop ();
    rain.play();
    song.play ();
    showRain = true;
  }
  pausing = true;
  alpha = 100;
   
//sensor triggers - right hand  (clenching) 

float rainVol = map(sensorRight, 1023,0,0.75,.1); // controlled by neon light
  rain.amp (rainVol);
  
float desertVol = map(sensorRight, 1023,0,1,0.1); 
  desert.amp (desertVol);

//sensor triggers - hands together (left over right)

float rainSpeed = map(sensorLeft, 0, 1023,60,5);
frameRate(rainSpeed); 

float songVol = map(sensorLeft, 0,1023,1,0); 
song.amp (songVol);

 //reset rain cycle
    resetRain();  
if (showRain) {
    ripple ();
    }
  
//check sensors are working  
println(sensorLeft);
println(sensorRight);
  
}

//make rain
void ripple () {
    fill (19,110,142);
    noStroke ();
    x = random (width);
    y = random (width);
    w = int (random (100));
    translate (x,y);
    ellipse(0, 0, w, w); 
 }
   
 void resetRain() {
  fill(5,5,30,10);
  rect(0, 0, width, height);
}

 
