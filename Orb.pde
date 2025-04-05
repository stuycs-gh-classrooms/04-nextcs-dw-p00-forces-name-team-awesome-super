class Orb {
	PVector pos, vel, acc;
	float mass, radius;
	color fillColor;

	Orb(PVector pos, float mass, float radius, color fillColor) {
		this.pos = pos;
		this.vel = new PVector();
		this.acc = new PVector();
		this.mass = mass;
		this.radius = radius;
		this.fillColor = fillColor;
	}

	void applyForce(PVector force) {
		acc.add(force.copy().div(mass));
	}

	void applyAcceleration(float delta) {
		vel.add(acc.copy().mult(delta));
		acc.setMag(0); // mult?
	}

	void applyVelocity(float delta) {
		pos.add(vel.copy().mult(delta));
	}

	void draw() {
		noStroke();
		fill(fillColor);
		ellipseMode(RADIUS);
		circle(pos.x, pos.y, radius);
	}
}
