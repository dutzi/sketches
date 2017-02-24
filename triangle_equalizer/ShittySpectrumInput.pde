import processing.sound.*;

class ShittySpectrumInput implements SpectrumInputMethod {
	ShittySpectrumInput() {
	}

	float[] update(Object params) {
		DLine[] lines = (DLine[])(params);

		float[] spectrum = new float[lines.length];

		if (areAllLinesDead(lines)) {
			for (int i = 0; i < lines.length; i++) {
				spectrum[i] = abs(50 * Utils.lerpSine(i, lines.length, 2));
			}
		}

		return spectrum;
	}
}

boolean areAllLinesDead(DLine [] lines) {
	boolean foundAlive = false;
	for (int i = 0 ; i < lines.length; i++) {
		if (!lines[i].isDead()) {
			foundAlive = true;
			break;
		}
	}
	return !foundAlive;
}

void reviveLinesIfAllLinesDied(DLine [] lines) {
	if (areAllLinesDead(lines)) {
		for (int i = 0; i < lines.length; i++) {
			lines[i].setLineValue(abs(50 * Utils.lerpSine(i, lines.length, 2)));
		}
	}
}
