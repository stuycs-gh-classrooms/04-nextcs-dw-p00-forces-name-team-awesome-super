class DragRegion {
	float dragCoefficient;
	color fillColor;
	float x1, y1, x2, y2; // values are stored as corners to make the comparisons cleaner/shorter below

	DragRegion(float dragCoefficient, color fillColor, float x, float y, float width, float height) {
		this.dragCoefficient = dragCoefficient;
		this.fillColor = fillColor;
		x1 = x;
		y1 = y;
		x2 = x + width;
		y2 = y + height;
	}

	// returns whether the point is inside the region
	boolean contains(PVector point) {
		return x1 <= point.x && point.x < x2 && y1 <= point.y && point.y < y2;
	}

	void draw() {
		// draw a rectangle to represent the region
		fill(fillColor);
		noStroke();
		rectMode(CORNERS);
		rect(x1, y1, x2, y2);
	}
}
