class Blob{
 float minx,miny,maxx,maxy;
 
  Blob(float px, float py){
  minx=px;
  miny=py;
  maxx=px;
  maxy=py;
  }
  
  boolean isNear(float x, float y){
  float cx = (minx+maxx)/2;
  float cy = (miny+maxy)/2;
  if(distSq(cx,cy,x,y)<threshold_dist*threshold_dist){
    return true;
  }
  else{
    return false;
  }
  }
  
  void add2b(float x, float y){
  minx = min(x,minx);
  miny = min(y,miny);
  maxx = max(x,maxx);
  maxy = max(y,maxy);
  }
  
  void show(){
  fill(255);
  stroke(0);
  strokeWeight(2);
  rectMode(CORNERS);
  rect(minx,miny,maxx,maxy);
  }
  
  float area(){
  return (maxx-minx)*(maxy-miny);
  }
  
  void info(){
  print("CX : "+(minx+maxx)/2);
  print("CY : "+(miny+maxy)/2);
  println("Area : "+(maxx-minx)*(maxy-miny));
  }
}
