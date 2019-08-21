import processing.video.*;

Capture video;
color track_color=color(200,0,0);

int min_blob_dist = 10; //min dist between blobs
int color_threshold = 20;

ArrayList<Blob> blobs = new ArrayList<Blob>();

void setup() {

  String[] cams = Capture.list();
  for(String s : cams){ println(s); }

  size(640,360);
  video = new Capture(this, 640,360);
  video.start();  
  noStroke();
  smooth();
}


void draw() {

    blobs.clear();
    
    video.loadPixels();
    image(video, 0, 0);
      
    int index=0;
    
    for (int y = 0; y < video.height; y++) {
      for (int x = 0; x < video.width; x++) {

      color currentColor = video.pixels[index];
      float r1 = red(currentColor);
      float g1 = green(currentColor);
      float b1 = blue(currentColor);
      float r2 = red(track_color);
      float g2 = green(track_color);
      float b2 = blue(track_color);
        float dist = distSq(r1,g1,b1,r2,g2,b2);
        
        
        if(dist < color_threshold*color_threshold) {
 
          boolean found = false;
          for (Blob b : blobs){
            if(b.isNear(x,y)){
            b.add2b(x,y);
            found=true;
            break;
            }
          }
          
          if(!found){
            Blob new_blob = new Blob(x,y);
            blobs.add(new_blob);
          }
        }
        index++;
      }
    }
    
    for (Blob b : blobs){
      if(b.area()< 10000){
          b.show();
      }

    }

  
}

void mousePressed(){
    video.loadPixels();
    track_color = video.pixels[mouseX+mouseY*width];
    println(min(640,mouseX)+" "+min(360,mouseY)+track_color);
    
    if(blobs.isEmpty()){
     println("Blob list empty");
    }
    else{
    for(Blob b : blobs){
    b.info();
    }
    }
}


float distSq(float x1, float y1, float x2, float y2) {
  float d = (x2-x1)*(x2-x1) + (y2-y1)*(y2-y1);
  return d;
}


float distSq(float x1, float y1, float z1, float x2, float y2, float z2) {
  float d = (x2-x1)*(x2-x1) + (y2-y1)*(y2-y1) +(z2-z1)*(z2-z1);
  return d;
}


void captureEvent(Capture video) {
  video.read();
}

void keyPressed() {
  if (key == 'a') {
    color_threshold+=5;
      println("color threshold: " +color_threshold);
  } else if (key == 'd') {
    color_threshold-=5;
      println("color threshold: " +color_threshold);

  }
  else if(key =='w'){
    min_blob_dist+=5;
    println("dist threshold: " +min_blob_dist);

  }
  else if(key=='s'){
    min_blob_dist-=5;
    println("dist threshold: " +min_blob_dist);
    
  }
}
