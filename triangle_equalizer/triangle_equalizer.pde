float DLine_lineFalloutSpeed;
float DLine_rectFalloutSpeed;
float DLine_lineWidth;
float DLine_rectWidth;
float DLine_padding;

void restartConsts() {
  DLine_lineFalloutSpeed = 3.7;
  DLine_rectFalloutSpeed = 2.0;
  DLine_lineWidth = 3;
  DLine_rectWidth = 5;
  DLine_padding = 5;
}

import codeanticode.syphon.*;
import org.multiply.processing.TimedEventGenerator;
import processing.sound.*;

AudioIn in;
FFT fft;
SinOsc sine;
SyphonServer server;
int width = 640;
int height = 360;

int c_NUM_LINES = 30;
int c_BANDS = 32;
boolean shouldRender = true;
boolean shouldStepOneFrame = false;

float[] spectrum = new float[c_BANDS];
DLine[] lines = new DLine[c_NUM_LINES];

void settings() {
  size(640, 360, P3D);
  pixelDensity(2);
  PJOGL.profile=1;
}

TimedEventGenerator keypressInterval;
void setup() {
  restartConsts();

  server = new SyphonServer(this, "Processing Syphon");
  noStroke();

  setupLines();
  setupAudioIn();
  // setupAudioOut();

  keypressInterval = new TimedEventGenerator(this, "onKeypressInterval");
  keypressInterval.setIntervalMs(200);
}

void setupLines() {
  float left = width / 2 - (DLine_rectWidth + DLine_padding) * c_NUM_LINES / 2;
  for (int i = 0; i < c_NUM_LINES; i++) {

    float x = left + (DLine_rectWidth + DLine_padding) * i;
    lines[i] = createLine(x);
    lines[i].setLineValue(50);
  }
}

void setupAudioIn() {
  // Create an Input stream which is routed into the Amplitude analyzer
  fft = new FFT(this, c_BANDS);
  in = new AudioIn(this, 0);

  // start the Audio Input
  in.start();

  // patch the AudioIn
  fft.input(in);
}

void setupAudioOut() {
  sine = new SinOsc(this);
  sine.play();
}

void draw() {
  if (!shouldRender && !shouldStepOneFrame) {
    return;
  }

  fft.analyze(spectrum);

  background(#CEE1DF);
  fill(#000000);

  restartConsts();

  for (int i = 0; i < c_NUM_LINES; i++){
  // The result of the FFT is normalized
  // draw the line for frequency band i scaling it up by 5 to get more amplitude.
    lines[i].setLineValue(spectrum[i] * 10E2);
  }

  for (int i = 0; i < lines.length; i++) {
    lines[i].update();
  }

  reviveLinesIfAllLinesDied();

  server.sendScreen();

  if (shouldStepOneFrame) {
    shouldRender = false;
    shouldStepOneFrame = false;
  }
}

boolean areAllLinesDead() {
  boolean foundAlive = false;
  for (int i = 0 ; i < lines.length; i++) {
    if (!lines[i].isDead()) {
      foundAlive = true;
      break;
    }
  }
  return !foundAlive;
}

void reviveLinesIfAllLinesDied() {
  if (areAllLinesDead()) {
    for (int i = 0; i < lines.length; i++) {
      lines[i].setLineValue(abs(50 * Utils.lerpSine(i, lines.length, 2)));
    }
  }
}

IntDict keysDown = new IntDict();

void keyPressed() {
  keysDown.set(str(keyCode), 1);

  if (keyCode == 32) { //down
    shouldRender = !shouldRender;
    // keysDown.set("space", true);
    // onKeypressInterval();
  } else if (keyCode == 39) { //right
    // onKeypressInterval();
    shouldStepOneFrame = true;
  }
}

void keyReleased() {
  keysDown.remove(str(keyCode));
}

void onKeypressInterval() {
  if (keysDown.hasKey("39")) {
    shouldStepOneFrame = true;
  }
}

class DLine {
  float _x, _lineValue, _rectValue;

  DLine (float x) {
    _x = x;
  }

  void setLineValue(float value) {
    _lineValue = value * 2;
    _rectValue = value;
  }

  boolean isDead() {
    return _rectValue <= 0 && _lineValue <= 0;
  }

  void update() {
    _lineValue = max(0, _lineValue - DLine_lineFalloutSpeed);
    _rectValue = max(0, _rectValue - DLine_rectFalloutSpeed);

    fill(0, 0, 0);

    translate(0, height / 2);

    // Draw rect
    rect(_x - DLine_rectWidth / 2, -_rectValue / 2, DLine_rectWidth, _rectValue);

    // Draw line
    rect(_x - DLine_lineWidth / 2, -_lineValue / 2, DLine_lineWidth, _lineValue);

    translate(0, -height / 2);
  }
}

DLine createLine(float x) {
  return new DLine(x);
}