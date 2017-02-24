import codeanticode.syphon.*;

SinOsc sine;
LinesRenderer linesRenderer;
SyphonServer server;
int width = 640;
int height = 360;

int c_NUM_LINES = 30;
int c_BANDS = 32;

void settings() {
	size(640, 360, P3D);
	pixelDensity(2);
	PJOGL.profile=1;
}

void setup() {
	server = new SyphonServer(this, "Processing Syphon");
	noStroke();

	restartConsts();

	linesRenderer = new LinesRenderer();

	FFT fft = new FFT(this, c_BANDS);
	AudioIn in = new AudioIn(this, 0);

	// SpectrumInputMethod spectrumInput = new FFTSpectrumInput(fft, in);
	SpectrumInputMethod spectrumInput = new ShittySpectrumInput();
	linesRenderer.setInputMethod(spectrumInput);
}

void setupAudioOut() {
	sine = new SinOsc(this);
	sine.play();
}

void draw() {
	if (!RenderController.shouldRender()) {
		return;
	}

	background(#CEE1DF);
	fill(#000000);

	restartConsts();

	linesRenderer.updateLines();

	server.sendScreen();

	RenderController.onEndDraw();
}