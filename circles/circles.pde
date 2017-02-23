import codeanticode.syphon.*;

SyphonServer server;
PGraphics pg;
int width = 640;
int height = 360;
PImage img;

float TIME_SHIFT = 0.01;

DCircle[] circles = new DCircle[150];

void settings() {
  size(640, 360, P3D);
  pixelDensity(2);
  PJOGL.profile=1;
}

void setup() {
  //size(640, 360, P3D);
  server = new SyphonServer(this, "Processing Syphon");
  //lights();
  //smooth();
  noStroke();
  img = loadImage("vignette.png");
  for (int i = 0; i < circles.length; i++) {
    circles[i] = spawnCircle();
  }
}


void draw() {
  background(#CEE1DF);
  fill(#000000);
  for (int i = 0; i < circles.length; i++) {
    if (!circles[i].isDead()) {
      circles[i].update();
    } else {
      circles[i] = spawnCircle();
    }
  }
  
  server.sendScreen();
}

void keyPressed() {
  if (keyCode == 40) { //down
    deadBabiesRatio = 0.9;
  } else if (keyCode == 38) { //up
    deadBabiesRatio = 0.99;
  }
}

float deadBabiesRatio = 0.99;
DCircle spawnCircle() {
  return new DCircle(
    width / 2 + random(-40, 40), 
    height / 2 + random(-20, 20), 
    0, 
    (-200 + random(-20, 20)) * TIME_SHIFT, 
    random(1.7, 4),
    random(0, 1) < deadBabiesRatio ? true : false
   );
}

float gravity = 2 * TIME_SHIFT;

class DCircle {
  float _x, _y, _z, _zSpeed, _ySpeed, _size;
  boolean _isDead;

  DCircle (float x, float y, float z, float zSpeed, float size, boolean isDead) {
    _x = x;
    _y = y;
    _z = z;
    _zSpeed = zSpeed;
    _ySpeed = 0;
    _size = size;
    _isDead = isDead;
  }

  void update() {
    _z += _zSpeed;
    _y += _ySpeed;
    _ySpeed += gravity;
    //println(_x, _y, _z);
    translate(_x, _y, _z);
    
    float alpha = (1 - (_z / -430)) * 255;
    fill(0, 0, 0, alpha);
    sphere(_size);

    translate(-_x, -_y, -_z);
  }

  boolean isDead() {
    return _isDead || _y > 600;
  }
}