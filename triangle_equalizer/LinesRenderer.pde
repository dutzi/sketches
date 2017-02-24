class LinesRenderer {
  DLine[] lines = new DLine[c_NUM_LINES];
  SpectrumInputMethod inputMethod;

  LinesRenderer() {
    float left = width / 2 - (DLine_rectWidth + DLine_padding) * c_NUM_LINES / 2;
    for (int i = 0; i < c_NUM_LINES; i++) {

      float x = left + (DLine_rectWidth + DLine_padding) * i;
      lines[i] = createLine(x);
      lines[i].setLineValue(50);
    }
  }

  void setInputMethod(SpectrumInputMethod method) {
    inputMethod = method;
  }

  void updateLines() {
  	float[] spectrum = inputMethod.update(lines);

    for (int i = 0; i < c_NUM_LINES; i++){
      lines[i].setLineValue(spectrum[i]);
    }

    for (int i = 0; i < lines.length; i++) {
      lines[i].update();
    }
  }
}

DLine createLine(float x) {
  return new DLine(x);
}