void wallBounceOrb(Orb orb) {
	if (orb.pos.x <= orb.radius) {
		orb.vel.x = abs(orb.vel.x);
		orb.pos.x = orb.radius;
	} else if (orb.pos.x > width - orb.radius) {
		orb.vel.x = -abs(orb.vel.x);
		orb.pos.x = width - 1 - orb.radius;
	}
	if (orb.pos.y <= orb.radius) {
		orb.vel.y = abs(orb.vel.y);
		orb.pos.y = orb.radius;
	} else if (orb.pos.y > height - orb.radius) {
		orb.vel.y = -abs(orb.vel.y);
		orb.pos.y = height - 1 - orb.radius;
	}
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
	float distanceToPrevious = orb.previous != null ? orb.previous.pos.dist(orb.pos) : null;
	float distanceToNext = orb.next != null ? orb.next.pos.dist(orb.pos) : null;
	return (
		(distanceToPrevious != 0 ? orb.previous.pos.copy().sub(orb.pos).setMag(distanceToPrevious - springLength) : new PVector())
		.add(distanceToNext != 0 ? orb.next.pos.copy().sub(orb.pos).setMag(distanceToNext - springLength) : new PVector())
	);
}