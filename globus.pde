int xs=1920;
int ys=1080;
int mx=1000;
int my=1200;
float sf=0.0005;
PImage img;
int counter=0;

void setup() {
fullScreen();
img = loadImage("globus_small.jpg");

image(img, 0, 0);
loadPixels();
img.loadPixels();
}

void draw() {
  int pp=0;
for(int y=0;y<ys;y++) {
  for(int x=0;x<xs;x++) {
    float px=(x-mx)*sf;
    float py=(y-my)*sf;
    float di=px*px+py*py;
    float pz=0;
    if (di<=1.0) {
      pz=sqrt(1-di);
      float wx=(asin(px)/PI*6750+4000+counter*20)/4;
      float wy=(asin(py)/PI*6720+3360)/4;
      pixels[pp++]=img.pixels[int(wx)+int(wy)*13500/4];
    } else {
      pixels[pp++]=color(0,0,0);
    }
  }
}
updatePixels();
counter++;
}
