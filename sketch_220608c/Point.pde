class Point {
  
  float x;
  float y;
  float z;
  
  Point(float tempX, float tempY, float tempZ) {
    x = tempX;
    y = tempY;
    z = tempZ;
  }
  float sqDist(Point p) {
    return sq(x-p.x)+sq(y-p.y)+sq(z-p.z);
  }
}
