import processing.video.*;

Capture video;
PImage prev;
color track_color = color(0);

void setup() {
  size(640, 480);
  video = new Capture(this, width, height);
  video.start();  
  noStroke();
  smooth();
  
  prev = createImage(width,height,RGB);
}

void draw() {
  if (video.available()) {
    
    video.read();
    video.loadPixels();
    prev.loadPixels();
    
    int index = 0;
    float threshold=80;
        
    for (int y = 0; y < video.height; y++) {
      for (int x = 0; x < video.width; x++) {

        color pval = video.pixels[index];
        float tr = red(pval);
        float tg = green(pval);
        float tb = blue(pval);
        
        color prev_val = prev.pixels[index];
        float cr = red(prev_val);
        float cg = green(prev_val);
        float cb = blue(prev_val); 
        
        float dist = dist_sq(tr,tg,tb,cr,cg,cb);
        
        if(dist > threshold*threshold) {
            video.pixels[index]=color(255);
         }
         else{
            video.pixels[index]=color(0);
         }
        index++;
      }
    }
    video.updatePixels();
    image(video, 0, 0, width, height);

    //save this frame for next iteration
    prev.copy(video,0,0,video.width,video.height,0,0,prev.width,prev.height);
    prev.updatePixels(); 
  }
}

float dist_sq(float a, float b, float c, float d, float e, float f){
  float dist = (a-d)*(a-d) + (b-e)*(b-e) + (c-f)*(c-f);
  return dist;
}


void mousePressed(){
video.loadPixels();
color pixel = video.pixels[width*mouseY+mouseX];
track_color = color(red(pixel),green(pixel),blue(pixel));
}
