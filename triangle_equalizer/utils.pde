static class Utils {
  static float lerpSine(float index, float steps, float reps) {
    return sin(index / steps * PI * reps);
  }
}
