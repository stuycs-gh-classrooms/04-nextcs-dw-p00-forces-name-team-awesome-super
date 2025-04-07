void wallBounceOrb(Orb orb) {
	// orbs aren't teleported back onto screen so that energy gets conserved better
	// to prevent this method from negating velocity every update, it only negates velocity if the orb is exiting the frame
	// if its velocity is pointed back into the frame, that means it was already wall bounced and nothing else should be done
	// note: this still doesn't handle physics perfectly, but at high tick rates it should be reasonable for this project
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
// used for the collideOrbs method right below
// calculates the velocity of an orb after colliding with another orb
// t1 and t2 are the directions of the first and second orb's velocities, p is the angle from the first to second orb
PVector get2dCollisionVelocity(float m1, float m2, float v1, float v2, float t1, float t2, float p) {
	float vx = (v1*cos(t1-p)*(m1-m2)+2*m2*v2*cos(t2-p))/(m1+m2)*cos(p)+v1*sin(t1-p)*cos(p+HALF_PI);
	float vy = (v1*cos(t1-p)*(m1-m2)+2*m2*v2*cos(t2-p))/(m1+m2)*sin(p)+v1*sin(t1-p)*sin(p+HALF_PI);
	return new PVector(vx, vy);
}

void collideOrbs(List<Orb> orbs) {
	// iterate through every pair of orbs
	for (int i = 0; i < orbs.size(); i++) {
		for (int j = i + 1; j < orbs.size(); j++) {
			Orb orb1 = orbs.get(i);
			Orb orb2 = orbs.get(j);
			// calculate the vector from the first orb to the second orb
			PVector posDifference = orb2.pos.copy().sub(orb1.pos);

			// check how close the orbs are; if they aren't colliding, there's nothing to calculate
			if (posDifference.mag() > orb1.radius + orb2.radius) continue;

			// if one of the orb's fixed, a different equation needs to be used to conserve momentum and KE
			if (orb1.fixed || orb2.fixed) {
				// assign the two orbs based on which is fixed
				Orb fixedOrb = orb1.fixed ? orb1 : orb2;
				Orb freeOrb = orb1.fixed ? orb2 : orb1;

				// calculate the vector from the free orb to the fixed orb
				posDifference = fixedOrb.pos.copy().sub(freeOrb.pos);
				// mirror the free orb's velocity around the angle of impact and negate it
				freeOrb.vel.rotate((posDifference.heading() - freeOrb.vel.heading()) * 2 + PI);
				continue; // don't need to run the rest of the code below
			}

			float m1 = orb1.mass;
			float m2 = orb2.mass;
			float v1 = orb1.vel.mag();
			float v2 = orb2.vel.mag();
			float t1 = orb1.vel.heading();
			float t2 = orb2.vel.heading();
			float p = posDifference.heading(); // angle of impact

			// if both orbs are travelling away from each other the collision for them must've already been calculated
			if (cos(p - t1) <= 0 && cos(p - t2) >= 0) continue;

			// assign new velocities for the two orbs
			orb1.vel = get2dCollisionVelocity(m1, m2, v1, v2, t1, t2, p);
			orb2.vel = get2dCollisionVelocity(m2, m1, v2, v1, t2, t1, p + PI);
		}
	}
}

PVector getDownwardGravityForce(float acceleration, Orb orb) {
	// calculate force using f=ma
	return new PVector(0, orb.mass * acceleration);
}

PVector getGravityForce(float gravitationalConstant, Orb orb, List<Orb> orbs) {
	PVector sumForce = new PVector();
	// iterate through all the orbs
	for (Orb otherOrb : orbs) {
		float distance = orb.pos.dist(otherOrb.pos);
		// if the distane is 0 the equation won't work or (more likely) it's the same orb so don't calculate anything
		if (distance == 0) continue;
		// add force using F=GMm/r^2
		sumForce.add(otherOrb.pos.copy().sub(orb.pos).setMag(gravitationalConstant * orb.mass * otherOrb.mass / sq(distance)));
	}
	return sumForce;
}

PVector getSpringForce(float springConstant, float springLength, LinkedListOrb orb) {
	// this calculates the spring forces for the previous and next orbs
	// if the previous/next orbs are null, a spring force of zero is used
	return (
		(orb.previous != null ? orb.previous.pos.copy().sub(orb.pos).setMag(orb.previous.pos.dist(orb.pos) - springLength).mult(springConstant) : new PVector())
		.add(orb.next != null ? orb.next.pos.copy().sub(orb.pos).setMag(orb.next.pos.dist(orb.pos) - springLength).mult(springConstant) : new PVector())
	);
}

// this method links all the orbs given into a linked list
// (based on the order they were given in)
void linkOrbs(LinkedListOrb... orbs) {
	for (int i = 1; i < orbs.length; i++) {
		orbs[i - 1].next = orbs[i];
		orbs[i].previous = orbs[i - 1];
	}
}

PVector getDragForce(float dragCoefficient, Orb orb) {
	float crossSectionalArea = PI * sq(orb.radius); // a 2d view of a 3d scene feels more interesting
	return orb.vel.copy().mult(-0.5 * orb.vel.mag() * dragCoefficient * crossSectionalArea);
}
