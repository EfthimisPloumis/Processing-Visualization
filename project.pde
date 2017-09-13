import ddf.minim.*;
import ddf.minim.analysis.*;
Minim minim;
AudioPlayer player;
AudioMetaData meta;
FFT fft;


void setup() {
  size(960, 600);
  minim = new Minim(this); //create minim
  player = minim.loadFile("Elektronomia & JJD.mp3");
  meta = player.getMetaData();
  fft = new FFT(player.bufferSize(), player.sampleRate());
  player.loop(); //when opened play this
}

void draw() {
  
  PImage img;
img = loadImage("n.jpg");
background(img);
  stroke(255);
   if (mousePressed==true){// click to stop music
   if (player.isPlaying()){
      player.pause();
    }
    else{
      player.play();
    }
  }
  
  for(int i = 0; i < player.bufferSize() - 1; i++)
  {
    float left1 = 100 + player.left.get(i) * 100;
    float left2 = 100 + player.left.get(i+1) * 100;
    float right1 = 200 + player.right.get(i) * 200;
    float right2 = 200 + player.right.get(i+1) * 200;
    line(i, left1, i+1, left2);
    line(i, right1, i+1, right2);
  }

  fft.forward(player.mix);
  noStroke();
  fill(random(255), random(255), random(255), random(255));
  for(int i = 0; i < 1000; i++)
  {
    float b = fft.getBand(i);
    float x = random(-b, b) + width/2;
    float y = i*2;
    ellipse(x, y, b, b);
    rect(i*2, height - b, 5, b);
  }

  
  for(int i = 0; i < player.bufferSize() - 1; i++)
  {
    line(i, 50  + player.left.get(i)*50,  i+1, 50  + player.left.get(i+1)*50);
    line(i, 150 + player.right.get(i)*50, i+1, 150 + player.right.get(i+1)*50);
  }
  
  float posx = map(player.position(), 0, player.length(), 0, width);
  stroke(255,0,0);
  line(posx, 0, posx, 10);
  
  stroke(255);
  fill(255, 150, 250, 255);
  textSize(15);
  text(" " + meta.fileName(), 700, 30);
  text(player.position()/1000 + " / " +player.length()/1000,870,550);
  textSize(12);
  text("Press ESC to exit",10,50);
  text("Press r to rewind", 10, 20);
  if (player.isPlaying()){
  textSize(12);
  text("Press p or mouse to stop",10 , 30);
  textSize(20);
  text("Playing",870,570);}
  else{
  textSize(12);
  text("Press p or mouse to play",10 , 30);
  textSize(20);  
  text("Paused",870,570);}
  if (player.isMuted()){
      textSize(12);
      text("Press u to unmute",10,40);
      textSize(20);
      text("Muted",870,590);  }
  else {
      textSize(12);  
      text("Press m to mute",10,40);
      textSize(20);
      text("Unmuted",870,590);
}
}
  
void keyPressed()
{
 if (key == 'r' || key == 'R'){
  player.rewind();
  }
  if (key == 'p' || key == 'P'){
   if (player.isPlaying()){
      player.pause();}
   else{
      player.play();
   }
  }
  if (key=='m' || key=='M'){
    player.mute();
  }
  if (key=='u' || key=='U'){
    if  (player.isMuted()){
      player.unmute();}}
  if (key==ESC){
    player.close();
    minim.stop();
    super.stop();}
}

void stop() {
  player.close();
  minim.stop();
  super.stop();
}