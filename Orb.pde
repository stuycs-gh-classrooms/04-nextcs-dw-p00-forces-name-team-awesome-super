class Orb {
	PVector pos, vel, acc;
	float mass, radius;
	boolean fixed;
	color fillColor;

	Orb(PVector pos, float mass, float radius, color fillColor) {
		this.pos = pos;
		this.vel = new PVector();
		this.acc = new PVector();
		this.mass = mass;
		this.radius = radius;
		this.fixed = false;
		this.fillColor = fillColor;
	}

	void applyForce(PVector force) {
		// adds the appropriate amount of acceleration per f=ma
		acc.add(force.copy().div(mass));
	}

	void applyAcceleration(float delta) {
		// add acceleration to velocity and set acceleration to 0
		vel.add(acc.copy().mult(delta));
		acc.setMag(0); // mult?
	}

	void applyVelocity(float delta) {
		// if the orb's fixed its position shouldn't change
		if (fixed) return;
		// change position be velocity
		pos.add(vel.copy().mult(delta));
		// velocity isn't reset because objects in motion stay in motion
	}

	void draw() {
		// draw a circle to represent the orb
		noStroke();
		fill(fillColor);
		ellipseMode(RADIUS);
		circle(pos.x, pos.y, radius);
	}
}
