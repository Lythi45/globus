PImage earth; 
PImage stars;
PShape globe;
PImage glow;
PShape glowG;
Point[] points;
ArrayList<Line> lines;
int np=8000;
float radL=205;
int nl;
PFont f;
PGraphics c3;

void setup() { 
  fullScreen(P2D,1);
  background(0); 
  stars = loadImage("stars.jpg");
  //stars = loadImage("videoback.png");
  earth = loadImage("globus.jpg");
  c3 = createGraphics(width, height, P3D); 
  c3.sphereDetail(60);
  globe = c3.createShape(SPHERE, 200); 
  globe.setStroke(false);
  globe.setTexture(earth);
  glow = loadImage("glow.png");
  glowG = c3.createShape(SPHERE, 201); 
  glowG.setStroke(false);
  glowG.setTexture(glow);
  c3.noStroke();
  points = new Point[np];
  lines = new ArrayList<Line>();
  f = createFont("Arial",32,true);
  
  for(int i=0;i<np;i++) {
    float radL=random(202,204);
    float rx=random(0,TAU);
    float ry=random(-1,1);
    float rad=sqrt(1.0-ry*ry)*radL;
    points[i]=new Point(sin(rx)*rad,ry*radL,cos(rx)*rad);
 
  }
  for(int i=0;i<np-1;i++) {
    for(int j=i+1;j<np;j++) {
      float dist=points[i].sqDist(points[j]);
      if (random(1)>0.6 && dist<random(100,1000)) {
        lines.add(new Line(points[i],points[j]));
      }
    }
  }
  nl=lines.size();
   
  
}

void draw() {
  //perspective();
  image(stars, 0, 0);
  //c3.directionalLight(1000, 1000, 1000, -1, 0, -1);
  float fov = PI/6.0;
  c3.beginDraw();
  c3.background(0,0,0,0);
  c3.perspective(fov, float(width)/float(height), 
            5, 1000);
 c3.camera(960, 415, 275, 965,380, 0.0,0.0, 1.0, 0.0);
 //c3.camera(960, mouseX, mouseY, 967,380, 0.0, 0.0, 1.0, 0.0);
  c3.translate(width/2, height/2);
  float rot=frameCount/4500.0*PI*2.0/3.0+1.0;
  c3.pushMatrix();
  c3.rotateY(rot);
  c3.shape(globe);
  c3.popMatrix();
  c3.pushMatrix();
  c3.rotateY(PI/180.0*68);
  c3.rotateZ(PI/180.0*74);
  
  c3.shape(glowG);
  c3.popMatrix();
  c3.rotateY(rot);
  c3.stroke(80,80,80,125);
  for(Line line:lines) {
    Point p1=line.from;
    Point p2=line.to;
    c3.line(p1.x,p1.y,p1.z,p2.x,p2.y,p2.z);
  }
  c3.stroke(220,220,220,170);
  c3.strokeWeight(5);
  for(Point p:points) {
    c3.point(p.x*1.0005,p.y*1.0005,p.z*1.0005);
  }
  c3.strokeWeight(1);
  c3.endDraw();
  image(c3, 0, 0);
  textFont(f);
  fill(255);      
  //text(str(mouseX),10,30); 
  //text(str(mouseY),120,30);
  saveFrame("frames/globus-######.png");

}
