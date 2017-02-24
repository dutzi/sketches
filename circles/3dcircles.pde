PGraphics pg;
int width = 640;
int height = 360;
PImage img;

float TIME_SHIFT = 0.1;

DCircle[] circles = new DCircle[100];

void setup() {
	size(640, 360, P3D);
	pixelDensity(2);
	// smooth();
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
		}
	}
}
s
DCircle spawnCircle() {
	return new DCircle(width / 2 + random(-200, 200), height / 2 * random(-20, 20), 0, (-100 + random(-20, 20)) * TIME_SHIFT);
	//return new DCircle(width / 2, height / 2, 0, -100 * TIME_SHIFT);
}

float gravity = 1 * TIME_SHIFT;

class DCircle {
	float _x, _y, _z, _zSpeed, _ySpeed;

	DCircle (float x, float y, float z, float zSpeed) {
		_x = x;
		_y = y;
		_z = z;
		_zSpeed = zSpeed;
		_ySpeed = 0;
	}

	void update() {
		_z += _zSpeed;
		_y += _ySpeed;
		_ySpeed += gravity;
		println(_x, _y, _z);
		translate(_x, _y, _z);

		sphere(20);

		translate(-_x, -_y, -_z);
	}

	boolean isDead() {
		return _y > 2300;
	}
}