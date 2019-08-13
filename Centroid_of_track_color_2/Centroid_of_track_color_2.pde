import processing.video.*;

Capture video;
color track_color=color(255,255,255);

void setup() {
  size(640, 480);
  video = new Capture(this, width, height);
  video.start();  
  noStroke();
  smooth();
}

void draw() {
  if (video.available()) {
    video.read();
    image(video, 0, 0, width, height);
    
    video.loadPixels();
    
    int index = 0;
    int Avg_x=0,Avg_y=0,count=1;
    float threshold=10;
        
    for (int y = 0; y < video.height; y++) {
      for (int x = 0; x < video.width; x++) {

        color pixelValue = video.pixels[index];
        float tr = red(track_color);
        float tg = green(track_color);
        float tb = blue(track_color);
        float cr = red(pixelValue);
        float cg = green(pixelValue);
        float cb = blue(pixelValue); 
        
        float dist = dist(tr,tg,tb,cr,cg,cb);
        
        if(dist < threshold) {
            Avg_x+=x;
            Avg_y+=y;
            count++;    
            
            fill(255, 255,255,25);
            ellipse(x,y, 10, 10); 
         }
        index++;
      }
    }
    updatePixels();
    
    
    fill(255, 204, 0, 50);
    ellipse(Avg_x/count,Avg_y/count, 100, 100);   


  }
}

void mousePressed(){
video.loadPixels();
color pixel = video.pixels[width*mouseY+mouseX];
track_color = color(red(pixel),green(pixel),blue(pixel));
}
