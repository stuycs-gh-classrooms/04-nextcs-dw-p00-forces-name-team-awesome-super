class OrbitsScene extends Scene {
	OrbitsScene() {
		super();

		physicsToggles.add(PhysicsToggle.GRAVITY);
		physicsToggles.add(PhysicsToggle.COLLISIONS);

		physicsConstants.put(PhysicsConstant.GRAVITATIONAL_CONSTANT, 0.002);
		
		Orb centralBody1 = new Orb(new PVector(width / 2 - 70, height / 2), 1000000000, 50, color(255, 0, 0));
		Orb centralBody2 = new Orb(new PVector(width / 2 + 70, height / 2), 1000000000, 50, color(255, 0, 0));
		centralBody1.vel.set(0, 83);
		centralBody2.vel.set(0, -83);

		Orb planet1 = new Orb(new PVector(width / 2 + 400, height / 2), 0.1, 10, color(255));
		planet1.vel.set(0, -100);

		orbs.add(centralBody1);
		orbs.add(centralBody2);
		orbs.add(planet1);
	}

	void draw() {
		background(0);
		drawOrbs();
	}
}

class SpringsScene extends Scene {
	SpringsScene() {
		super();

		physicsToggles.add(PhysicsToggle.SPRING);
		physicsToggles.add(PhysicsToggle.WALL_BOUNCE);
		physicsToggles.add(PhysicsToggle.COLLISIONS);

		physicsConstants.put(PhysicsConstant.SPRING_CONSTANT, 0.002);
		
		Orb centralBody1 = new Orb(new PVector(width / 2 - 70, height / 2), 1000000000, 50, color(255, 0, 0));
		Orb centralBody2 = new Orb(new PVector(width / 2 + 70, height / 2), 1000000000, 50, color(255, 0, 0));
		centralBody1.vel.set(0, 83);
		centralBody2.vel.set(0, -83);

		Orb planet1 = new Orb(new PVector(width / 2 + 400, height / 2), 0.1, 10, color(255));
		planet1.vel.set(0, -100);

		orbs.add(centralBody1);
		orbs.add(centralBody2);
		orbs.add(planet1);
	}

	void draw() {
		background(0);
		drawOrbs();
	}
}
