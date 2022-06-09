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

void setup() { 
  fullScreen(P3D,1);
  background(0); 
  stars = loadImage("stars.jpg");
  earth = loadImage("globus.jpg");
  globe = createShape(SPHERE, 200); 
  globe.setStroke(false);
  globe.setTexture(earth);
  glow = loadImage("glow.png");
  glowG = createShape(SPHERE, 201.5); 
  glowG.setStroke(false);
  glowG.setTexture(glow);
  noStroke();
  points = new Point[np];
  lines = new ArrayList<Line>();
  f = createFont("Arial",32,true);
  
  for(int i=0;i<np;i++) {
    float radL=random(204,207);
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
  //directionalLight(1000, 1000, 1000, -1, 0, -1);
  float fov = PI/6.0;
  perspective(fov, float(width)/float(height), 
            5, 1000);
  camera(960, mouseX, mouseY, 960,400, 0.0, 
       0.0, 1.0, 0.0);
  translate(width/2, height/2);
  float rot=millis()/40000.0;
  pushMatrix();
  rotateY(rot);
  shape(globe);
  popMatrix();
  pushMatrix();
  rotateY(PI/2.0);
  shape(glowG);
  popMatrix();
  rotateY(rot);
  stroke(80,80,80,125);
  for(Line line:lines) {
    Point p1=line.from;
    Point p2=line.to;
    line(p1.x,p1.y,p1.z,p2.x,p2.y,p2.z);
  }
  stroke(170,170,170,200);
  strokeWeight(6);
  for(Point p:points) {
    point(p.x,p.y,p.z);
  }
  strokeWeight(1);
  textFont(f);
  fill(255);      
  
  text("Hello Strings!",10,10); 
}
