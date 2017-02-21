//
// # Usage example:
//
// pg = createGraphics(width, height);
// gradient(pg, 0, 0, width, height / 4, 0x55000000, 0x00000000, TOP_TO_BOTTOM);
//

int TOP_TO_BOTTOM = 1;
int LEFT_TO_RIGHT = 2;

void gradient(PGraphics pg, int x, int y, float w, float h, color c1, color c2, int axis) {
  pg.beginDraw();
  pg.noStroke();
  pg.noFill();

  if (axis == TOP_TO_BOTTOM) {  // Top to bottom gradient
    for (int i = y; i <= y + h - 1; i++) {
      float inter = map(i, y, y+h, 0, 1);
      color c = lerpColor(c1, c2, inter);
      pg.stroke(c);
      pg.line(x, i, x+w, i);
    }
  } else if (axis == LEFT_TO_RIGHT) {  // Left to right gradient
    for (int i = x; i <= x + w - 1; i++) {
      float inter = map(i, x, x+w, 0, 1);
      color c = lerpColor(c1, c2, inter);
      pg.stroke(c);
      pg.line(i, y, i, y+h);
    }
  }
  pg.endDraw();
}