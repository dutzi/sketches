import processing.sound.*;

class FFTSpectrumInput implements SpectrumInputMethod {
	AudioIn _in;
	FFT _fft;
	float[] spectrum;

	FFTSpectrumInput(FFT fft, AudioIn in) {
		spectrum = new float[c_BANDS];

		// Create an Input stream which is routed into the Amplitude analyzer
		_fft = fft;
		_in = in;

		// start the Audio Input
		_in.start();

		// patch the AudioIn
		fft.input(_in);
	}

	float[] update(Object params) {
		_fft.analyze(spectrum);

		for (int i = 0; i < spectrum.length; i++) {
			spectrum[i] *= 10E2;
		}

		return spectrum;
	}
}