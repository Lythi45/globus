PImage earth; 
PImage stars;
PShape globe;
Point[] points;
ArrayList<Line> lines;
int np=8000;
float radL=205;
int nl;

void setup() { 
  fullScreen(P3D,1);
  background(0); 
  stars = loadImage("stars.jpg");
  earth = loadImage("globus.jpg");
  globe = createShape(SPHERE, 200); 
  globe.setStroke(false);
  globe.setTexture(earth);
  noStroke();
  points = new Point[np];
  lines = new ArrayList<Line>();
  
  for(int i=0;i<np;i++) {
    float radL=random(205,210);
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
  image(stars, 0, 0);
  //directionalLight(1000, 1000, 1000, -1, 0, -1);
  camera(960, mouseX, mouseY, 960, 450, 0.0, 
       0.0, 1.0, 0.0);
  translate(width/2, height/2); 
  rotateY(millis()/40000.0);
  shape(globe);
  stroke(80,80,80,125);
  for(Line line:lines) {
    Point p1=line.from;
    Point p2=line.to;
    line(p1.x,p1.y,p1.z,p2.x,p2.y,p2.z);
  }
  stroke(130,130,130,125);
  strokeWeight(6);
  for(Point p:points) {
    point(p.x,p.y,p.z);
  }
  strokeWeight(1);
}
