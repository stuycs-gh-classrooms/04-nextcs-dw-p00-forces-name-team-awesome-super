void setupOrbits(List<Orb> orbs, Set<PhysicsToggles> physicsToggles, Map<PhysicsConstants, Float> physicsConstants) {
	orbs.clear();
	physicsToggles.clear();

	physicsToggles.add(PhysicsToggles.MOVEMENT);
	physicsToggles.add(PhysicsToggles.GRAVITY);
	physicsToggles.add(PhysicsToggles.COLLISIONS);

	physicsConstants.put(PhysicsConstants.GRAVITATIONAL_CONSTANT, 0.05);

	Orb centralBody = new Orb(new PVector(width / 2, height / 2), 999999999, 70, color(255, 0, 0));
	Orb planet1 = new Orb(new PVector(width / 2 + 200, height / 2), 10, 30, color(25, 0, 0));
	planet1.vel.set(0, -600);

	orbs.add(centralBody);
	orbs.add(planet1);
}