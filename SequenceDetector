import ddf.minim.*;
import processing.video.*;
   int colorX1 = 0; // X-coordinate of the closest in color video pixel
   int colorY1 = 0; // Y-coordinate of the closest in color video pixel
   int colorX2 = 0; // X-coordinate of the closest in color video pixel
   int colorY2 = 0; // Y-coordinate of the closest in color video pixel
   int colorX3 = 0; // X-coordinate of the closest in color video pixel
   int colorY3 = 0; // Y-coordinate of the closest in color video pixel
Capture video;
//import processing.serial.*;

//Serial myPort;  // Create object from Serial class
int val;      // Data received from the serial port

Minim minim;
AudioPlayer player1;
AudioPlayer player2;
AudioPlayer player3;

boolean player1Active = true;
boolean player2Active = false;

int prevVal = 0;
int mappedVal = 0;
void setup()
{
  //size(512, 500, P3D);
   size(640, 480);
 String[] cameras = Capture.list(); 
 // Change size to 320 x 240 if too slow at 640 x 480
 // Uses the default video input, see the reference if this causes an error
 video = new Capture(this, cameras[100]);
 video.start();
 noStroke();
 smooth();
  /*String portName = Serial.list()[0];
  myPort = new Serial(this, portName, 9600);*/  
  
  // we pass this to Minim so that it can load files from the data directory
  minim = new Minim(this);
  
  // loadFile will look in all the same places as loadImage does.
  // this means you can find files that are in the data folder and the 
  // sketch folder. you can also pass an absolute path, or a URL.
  player1 = minim.loadFile("clip a.mp3");
  player2 = minim.loadFile("clip b.mp3");
  //player3 = minim.loadFile("piano sample.mp3");
  
  // play the file from start to finish.
  // if you want to play the file again, 
  // you need to call rewind() first.

}

void draw()
{
  //background(0);
  //stroke(255);
  
  /*prevVal = val;
  if ( myPort.available() > 0) 
  {  // If data is available,
     val = myPort.read();         // read it and store it in val
  } 
  mappedVal = (int)map(val,0,255,0,7);
  println(val);
  if(player1Active)
  {
    player1.cue(mappedVal);  
    if(prevVal!=val)
    {
      player1.play();
    }
  }
  
   if(player2Active)
  {
    player2.cue(mappedVal);  
    if(prevVal!=val)
    {
      player2.play();
    }
  } */
  // draw the waveforms
  // the values returned by left.get() and right.get() will be between -1 and 1,
  // so we need to scale them up to see the waveform
  // note that if the file is MONO, left.get() and right.get() will return the same value
   if (video.available()) {
   video.read();
   image(video, 0, 0, width, height); // Draw the webcam video onto the screen

   float closestColor = 10000; //we set this to be abritrarily large, once program runs, the first pixel it scans will be set to this value
   // Search for the closest in color pixel: For each row of pixels in the video image and
   // for each pixel in the yth row, compute each pixel's index in the video
   video.loadPixels();
   int index = 0;
   for (int y = 0; y < video.height; y++) {
     for (int x = 0; x < video.width; x++) {
       // Get the color stored in the pixel
       color pixelValue = video.pixels[index];
       // Determine the color of the pixel
       float colorProximity1 = abs(red(pixelValue)-148)+abs(green(pixelValue)-0)+abs(blue(pixelValue)-211);
       float colorProximity2 = abs(red(pixelValue)-0)+abs(green(pixelValue)-255)+abs(blue(pixelValue)-0);
       float colorProximity3 = abs(red(pixelValue)-255)+abs(green(pixelValue)-120)+abs(blue(pixelValue)-0);
       // If that value is closer in color value than any previous, then store the
       // color proximity of that pixel, as well as its (x,y) location
       if (colorProximity1 < closestColor) {
         closestColor = colorProximity1;
         closestColor=closestColor-10; //thoguht behind this is that it once it "locks" on to an object of color, it wont let go unless something a good bit better (closer in color) comes along
         colorY1 = y;
         colorX1 = x;
       }
       if (colorProximity2 < closestColor) {
         closestColor = colorProximity2;
         closestColor=closestColor-10; //thoguht behind this is that it once it "locks" on to an object of color, it wont let go unless something a good bit better (closer in color) comes along
         colorY2 = y;
         colorX2 = x;
       }
       if (colorProximity3 < closestColor) {
         closestColor = colorProximity3;
         closestColor=closestColor-10; //thoguht behind this is that it once it "locks" on to an object of color, it wont let go unless something a good bit better (closer in color) comes along
         colorY3 = y;
         colorX3 = x;
       }
       index++;
     }
   }
   // Draw a large, yellow circle at the brightest pixel
   //fill(255, 204, 0, 128);
   //ellipse(colorX1, colorY1, 100, 100);
   fill(255, 204, 0, 128);
   ellipse(colorX2, colorY2, 150, 150);
   fill(255, 204, 0, 128);
   ellipse(colorX3, colorY3, 150, 150);
 }
  
  /*for(int i = 0; i < player1.bufferSize() - 1; i++)
  {
 
    line( i, 100 + player1.left.get(i)*50, i+1, 100 + player1.left.get(i+1)*50 );
    line( i, 150 + player1.right.get(i)*50, i+1, 150 + player1.right.get(i+1)*50 );
  }
   
  for(int j = 0; j < player1.bufferSize() - 1; j++)
  {
    line( j, 250 + player2.left.get(j)*50, j+1, 250 + player2.left.get(j+1)*50 );
    line( j, 300 + player2.right.get(j)*50, j+1, 300 + player2.right.get(j+1)*50 );
  }*/

}
void keyPressed(){
if(key=='1')
  {
    if(colorX2>colorX3)
    {
   // player1.close();
    player1.play(); 
    player1Active = true;
    }
  }
    if(colorX3>colorX2)
  {
    //player1.close();
    player2.play(); 
    player1Active = false;
  }
