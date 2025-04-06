void linkOrbs(LinkedListOrb... orbs) {
	for (int i = 1; i < orbs.length; i++) {
		orbs[i - 1].next = orbs[i];
		orbs[i].previous = orbs[i - 1];
	}
}

class DragRegion {
	float dragCoefficient;
	color fillColor;
	float x1, y1, x2, y2;

	DragRegion(float dragCoefficient, color fillColor, float x, float y, float width, float height) {
		this.dragCoefficient = dragCoefficient;
		this.fillColor = fillColor;
		x1 = x;
		y1 = y;
		x2 = x + width;
		y2 = y + height;
	}

	boolean contains(PVector point) {
		return x1 <= point.x && point.x < x2 && y1 <= point.y && point.y < y2;
	}

	void draw() {
		fill(fillColor);
		noStroke();
		rectMode(CORNERS);
		rect(x1, y1, x2, y2);
	}
}
