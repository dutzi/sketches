float DLine_lineFalloutSpeed;
float DLine_rectFalloutSpeed;
float DLine_lineWidth;
float DLine_rectWidth;
float DLine_padding;

void restartConsts() {
	DLine_lineFalloutSpeed = 5.4;
	DLine_rectFalloutSpeed = 2.0;
	DLine_lineWidth = 2;
	DLine_rectWidth = 5;
	DLine_padding = 5;
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
