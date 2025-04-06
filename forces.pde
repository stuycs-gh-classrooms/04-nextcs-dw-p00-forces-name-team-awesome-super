void wallBounceOrb(Orb orb) {
	if (orb.pos.x <= orb.radius && orb.vel.x < 0) {
		orb.vel.x = abs(orb.vel.x);
	} else if (orb.pos.x > width - orb.radius && orb.vel.x > 0) {
		orb.vel.x = -abs(orb.vel.x);
	}
	if (orb.pos.y <= orb.radius && orb.vel.y < 0) {
		orb.vel.y = abs(orb.vel.y);
	} else if (orb.pos.y > height - orb.radius && orb.vel.y > 0) {
		orb.vel.y = -abs(orb.vel.y);
	}
}

// source: https://en.wikipedia.org/wiki/Elastic_collision#Two-dimensional
PVector get2dCollisionVelocity(float m1, float m2, float v1, float v2, float t1, float t2, float p) {
	float vx = (v1*cos(t1-p)*(m1-m2)+2*m2*v2*cos(t2-p))/(m1+m2)*cos(p)+v1*sin(t1-p)*cos(p+HALF_PI);
	float vy = (v1*cos(t1-p)*(m1-m2)+2*m2*v2*cos(t2-p))/(m1+m2)*sin(p)+v1*sin(t1-p)*sin(p+HALF_PI);
	return new PVector(vx, vy);
}

void collideOrbs(List<Orb> orbs) {
	for (int i = 0; i < orbs.size(); i++) {
		for (int j = i + 1; j < orbs.size(); j++) {
			Orb orb1 = orbs.get(i);
			Orb orb2 = orbs.get(j);
			PVector posDifference = orb2.pos.copy().sub(orb1.pos);
			if (posDifference.mag() > orb1.radius + orb2.radius) continue;

			float m1 = orb1.mass;
			float m2 = orb2.mass;
			float v1 = orb1.vel.mag();
			float v2 = orb2.vel.mag();
			float t1 = orb1.vel.heading();
			float t2 = orb2.vel.heading();
			float p = posDifference.heading();

			// if both orbs are travelling away from each other the collision for them must've already been calculated
			if (cos(p - t1) <= 0 && cos(p - t2) >= 0) continue;

			orb1.vel = get2dCollisionVelocity(m1, m2, v1, v2, t1, t2, p);
			orb2.vel = get2dCollisionVelocity(m2, m1, v2, v1, t2, t1, p + PI);
		}
	}
}

PVector getDownwardGravityForce(float acceleration, Orb orb) {
	return new PVector(0, orb.mass * acceleration);
}

PVector getGravityForce(float gravitationalConstant, Orb orb, List<Orb> orbs) {
	PVector sumForce = new PVector();
	for (Orb otherOrb : orbs) {
		float distance = orb.pos.dist(otherOrb.pos);
		if (distance == 0) continue;
		sumForce.add(otherOrb.pos.copy().sub(orb.pos).setMag(gravitationalConstant * orb.mass * otherOrb.mass / sq(distance)));
	}
	return sumForce;
}

PVector getSpringForce(float springConstant, float springLength, LinkedListOrb orb) {
	return (
		(orb.previous != null ? orb.previous.pos.copy().sub(orb.pos).setMag(orb.previous.pos.dist(orb.pos) - springLength).mult(springConstant) : new PVector())
		.add(orb.next != null ? orb.next.pos.copy().sub(orb.pos).setMag(orb.next.pos.dist(orb.pos) - springLength).mult(springConstant) : new PVector())
	);
}

PVector getDragForce(float dragCoefficient, Orb orb) {
	float crossSectionalArea = PI * sq(orb.radius); // a 2d view of a 3d scene feels more interesting
	// we don't seem to be accurately modelling drag anyway (like we seem to be ignoring fluid density?) so dividing by two feels unecessary
	return orb.vel.copy().mult(-orb.vel.mag() * dragCoefficient * crossSectionalArea);
}
