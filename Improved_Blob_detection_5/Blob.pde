class Blob{
 float minx,miny,maxx,maxy;
 
  ArrayList<PVector> points; 
   
  Blob(float px, float py){
    
  minx=px;
  miny=py;
  maxx=px;
  maxy=py;
  points = new ArrayList<PVector>();
  }
  
  boolean isNear(float x, float y){
    

  float X = max(min(maxx,x),minx);
  float Y = max(min(maxy,y),miny);
  
  if(distSq(X,Y,x,y)<min_blob_dist*min_blob_dist){
    return true;
  }
  else{
    return false;
  }
  }
  
  void add2b(float x, float y){
    points.add(new PVector(x,y));
    minx = min(x,minx);
    miny = min(y,miny);
    maxx = max(x,maxx);
    maxy = max(y,maxy);
  }
  
  void show(){
  noFill();
  stroke(#4DFFEF);
  strokeWeight(1);
  rectMode(CORNERS);
  rect(minx,miny,maxx,maxy);
  //textSize(8);
  //stroke(255);
  //text("CX : "+(minx+maxx)/2,(minx+maxx)/2,(miny+maxy)/2);
  //text("CY: "+(miny+maxy)/2,(minx+maxx)/2,10+(miny+maxy)/2);
  for(PVector p : points){
  stroke(0,0,255);
  point(p.x,p.y);
  }

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
