import ddf.minim.*;
import processing.serial.*;

Serial myPort;  // Create object from Serial class
String val;      // Data received from the serial port

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
  size(512, 500, P3D);
  
  String portName = Serial.list()[0];
  myPort = new Serial(this, portName, 9600); 
  
  // we pass this to Minim so that it can load files from the data directory
  minim = new Minim(this);
  
  // loadFile will look in all the same places as loadImage does.
  // this means you can find files that are in the data folder and the 
  // sketch folder. you can also pass an absolute path, or a URL.
  player1 = minim.loadFile("clip a.mp3");
  player1.play();
  player1.loop();
  //player2 = minim.loadFile("clip b.mp3");
  //player3 = minim.loadFile("piano sample.mp3");
  
  // play the file from start to finish.
  // if you want to play the file again, 
  // you need to call rewind() first.

}

int convertedVal = 0;
int prevcount = 0;

void draw()
{
  background(0);
  stroke(255);
  
  prevVal = convertedVal;
  
  if ( myPort.available() > 0) 
  {  // If data is available,
     val = myPort.readString().substring(0,2);         // read it and store it in val
     /*String recvdVal = myPort.readString();         // read it and store it in val
     int num = 0;
     for(int i=0;i<recvdVal.length();i++)
     {
       if(recvdVal.charAt(i)>=48 && recvdVal.charAt(i)<=57)
       {
          num = num*10 + recvdVal.charAt(i)-48;
          println("Output"+recvdVal);
       }
       else
       {
         break;
       }
     }*/
     //println(num); 
     //println(); 
      //text(list[0],10,100);
  }
  try
  {
    convertedVal = Integer.parseInt(val) - 6;
    println(""+convertedVal);  
  }
  catch(Exception e)
  {
  }
 
  if(player1Active)
  {
    if(convertedVal == prevVal)
    {++prevcount;}
    else{}
    
    
    if(convertedVal!=prevVal && prevcount>5)//if(prevVal!=val)
    {
      //if(convertedVal>3)
       float mappedConvertedVal = map(convertedVal,45,75,0,10000);
       player1.cue((int)mappedConvertedVal);
      //println("convertedVal"+convertedVal);   
      prevcount = 0;
      //player1.play();
    }
    else
    {
      //player1.pause();
    }
    
  }
  if(!player1.isPlaying())
  {
    player1.play();
  } 
  
   /*if(player2Active)
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
     //player1.play(); 
    player1Active = true;
    
  }
  if(key=='2')
  {
     //player2.play(); 
    player1Active = false;
  }
 
}
boolean mouseDrag = false;
void mouseDragged()
{
 // mouseDrag = true;
 if( player1Active)
 {
   player1.play();
 }
 else
 {
   player2.play();
 }
 
}

void mouseReleased()
{
 if( player1Active)
 {
   player1.pause();
 }
 else
 {
    player2.pause();
 }  
}
