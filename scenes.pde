class OrbitsScene extends Scene {
	OrbitsScene() {
		super();

		physicsToggles.add(PhysicsToggle.GRAVITY);
		physicsToggles.add(PhysicsToggle.COLLISIONS);

		simulationConstants.put(SimulationConstant.GRAVITATIONAL_CONSTANT, 0.002);
		
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

		physicsToggles.add(PhysicsToggle.DOWNWARD_GRAVITY);
		physicsToggles.add(PhysicsToggle.SPRING);
		// physicsToggles.add(PhysicsToggle.WALL_BOUNCE);
		physicsToggles.add(PhysicsToggle.COLLISIONS);

		simulationConstants.put(SimulationConstant.GRAVITATIONAL_ACCELERATION, 500.0);
		simulationConstants.put(SimulationConstant.SPRING_CONSTANT, 50.0);
		simulationConstants.put(SimulationConstant.SPRING_LENGTH, 100.0);

		LinkedListOrb orbFirst = new LinkedListOrb(new PVector(width / 2 - 500, height / 2 - 400), 1, 50, color(255, 0, 0));
		LinkedListOrb orb2 = new LinkedListOrb(new PVector(width / 2 - 375, height / 2 - 350), 1, 50, color(255, 0, 0));
		LinkedListOrb orb3 = new LinkedListOrb(new PVector(width / 2 - 250, height / 2 - 275), 1, 50, color(255, 0, 0));
		LinkedListOrb orb4 = new LinkedListOrb(new PVector(width / 2 - 125, height / 2 - 225), 1, 50, color(255, 0, 0));
		LinkedListOrb orbCenter = new LinkedListOrb(new PVector(width / 2, height / 2 - 200), 10, 50, color(255, 0, 0));
		LinkedListOrb orb6 = new LinkedListOrb(new PVector(width / 2 + 125, height / 2 - 225), 1, 50, color(255, 0, 0));
		LinkedListOrb orb7 = new LinkedListOrb(new PVector(width / 2 + 250, height / 2 - 275), 1, 50, color(255, 0, 0));
		LinkedListOrb orb8 = new LinkedListOrb(new PVector(width / 2 + 375, height / 2 - 350), 1, 50, color(255, 0, 0));
		LinkedListOrb orbLast = new LinkedListOrb(new PVector(width / 2 + 500, height / 2 - 400), 1, 50, color(255, 0, 0));

		orbFirst.fixed = true;
		orbLast.fixed = true;

		linkOrbs(orbFirst, orb2, orb3, orb4, orbCenter, orb6, orb7, orb8, orbLast);		
		addOrbs(orbs, orbFirst, orb2, orb3, orb4, orbCenter, orb6, orb7, orb8, orbLast);
	}

	void draw() {
		background(255);
		drawSprings();
		drawOrbs();
	}
}
