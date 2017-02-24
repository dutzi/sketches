static class RenderController {
  static boolean isPlaying = true;
  static boolean isSteppingOneFrame = false;

  static boolean shouldRender() {
    return RenderController.isPlaying ||
           RenderController.isSteppingOneFrame;
  }

  static void onEndDraw() {
    if (RenderController.isSteppingOneFrame) {
      RenderController.isPlaying = false;
      RenderController.isSteppingOneFrame = false;
    }
  }
}

void keyPressed() {
  if (keyCode == 32) { //down
    RenderController.isPlaying = !RenderController.isPlaying;
  } else if (keyCode == 39) { //right
    RenderController.isSteppingOneFrame = true;
  }
}

