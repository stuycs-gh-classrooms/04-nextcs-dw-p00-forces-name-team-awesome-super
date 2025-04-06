float getOrbitVelocity(float gravitationalConstant, float centralMass, float radius) {
	return sqrt(gravitationalConstant * centralMass / radius);
}

class OrbitsScene extends Scene {
	float[] orbitRadii = {200, 250, 300, 350, 400, 450, 500, 550, 600};

	OrbitsScene() {
		super();

		physicsToggles.add(PhysicsToggle.GRAVITY);
		physicsToggles.add(PhysicsToggle.COLLISIONS);

		float gConst = 0.002;
		simulationConstants.put(SimulationConstant.GRAVITATIONAL_CONSTANT, gConst);

		float centralBodyMass = 1000000000;
		
		Orb centralBody1 = new Orb(new PVector(width / 2 - 40, height / 2), centralBodyMass, 30, color(255, 0, 0));
		Orb centralBody2 = new Orb(new PVector(width / 2 + 40, height / 2), centralBodyMass, 30, color(255, 0, 0));
		centralBody1.vel.set(0, sqrt(gConst * centralBodyMass / sq(80) * 40));
		centralBody2.vel.set(0, -sqrt(gConst * centralBodyMass / sq(80) * 40));

		for (float radius : orbitRadii) {
			Orb planet = new Orb(new PVector(width / 2 + radius, height / 2), 0.1, 10, color(255));
			planet.vel.set(0, -getOrbitVelocity(gConst, centralBodyMass * 2, radius));
			addOrbs(planet);
		}

		addOrbs(centralBody1, centralBody2);
	}

	void draw() {
		background(0);

		for (float radius : orbitRadii) {
			noFill();
			stroke(255, 40);
			strokeWeight(2);
			ellipseMode(RADIUS);
			circle(width / 2, height / 2, radius);
		}

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
		physicsToggles.add(PhysicsToggle.DRAG);

		simulationConstants.put(SimulationConstant.GRAVITATIONAL_ACCELERATION, 500.0);
		simulationConstants.put(SimulationConstant.SPRING_CONSTANT, 50.0);
		simulationConstants.put(SimulationConstant.SPRING_LENGTH, 180.0);
		simulationConstants.put(SimulationConstant.DRAG_COEFFICIENT, 0.0000008);

		// LinkedListOrb orbFirst = new LinkedListOrb(new PVector(width / 2 - 500, height / 2 - 400), 1, 50, color(255, 0, 0));
		// LinkedListOrb orb2 = new LinkedListOrb(new PVector(width / 2 - 375, height / 2 - 350), 1, 50, color(255, 0, 0));
		// LinkedListOrb orb3 = new LinkedListOrb(new PVector(width / 2 - 250, height / 2 - 275), 1, 50, color(255, 0, 0));
		// LinkedListOrb orb4 = new LinkedListOrb(new PVector(width / 2 - 125, height / 2 - 225), 1, 50, color(255, 0, 0));
		// LinkedListOrb orbCenter = new LinkedListOrb(new PVector(width / 2, height / 2 - 200), 10, 50, color(255, 0, 0));
		// LinkedListOrb orb6 = new LinkedListOrb(new PVector(width / 2 + 125, height / 2 - 225), 1, 50, color(255, 0, 0));
		// LinkedListOrb orb7 = new LinkedListOrb(new PVector(width / 2 + 250, height / 2 - 275), 1, 50, color(255, 0, 0));
		// LinkedListOrb orb8 = new LinkedListOrb(new PVector(width / 2 + 375, height / 2 - 350), 1, 50, color(255, 0, 0));
		// LinkedListOrb orbLast = new LinkedListOrb(new PVector(width / 2 + 500, height / 2 - 400), 1, 50, color(255, 0, 0));

		float orbDistance = 150;
		LinkedListOrb orbFirst = new LinkedListOrb(new PVector(width / 2 - orbDistance * 4, height / 2 - 400), 1, 50, color(255, 0, 0));
		LinkedListOrb orb2 = new LinkedListOrb(new PVector(width / 2 - orbDistance * 3, height / 2 - 400), 1, 50, color(255, 0, 0));
		LinkedListOrb orb3 = new LinkedListOrb(new PVector(width / 2 - orbDistance * 2, height / 2 - 400), 1, 50, color(255, 0, 0));
		LinkedListOrb orb4 = new LinkedListOrb(new PVector(width / 2 - orbDistance * 1, height / 2 - 400), 1, 50, color(255, 0, 0));
		LinkedListOrb orbCenter = new LinkedListOrb(new PVector(width / 2, height / 2 - 400), 10, 50, color(255, 0, 0));
		LinkedListOrb orb6 = new LinkedListOrb(new PVector(width / 2 + orbDistance * 1, height / 2 - 400), 1, 50, color(255, 0, 0));
		LinkedListOrb orb7 = new LinkedListOrb(new PVector(width / 2 + orbDistance * 2, height / 2 - 400), 1, 50, color(255, 0, 0));
		LinkedListOrb orb8 = new LinkedListOrb(new PVector(width / 2 + orbDistance * 3, height / 2 - 400), 1, 50, color(255, 0, 0));
		LinkedListOrb orbLast = new LinkedListOrb(new PVector(width / 2 + orbDistance * 4, height / 2 - 400), 1, 50, color(255, 0, 0));

		orbFirst.fixed = true;
		orbLast.fixed = true;

		linkOrbs(orbFirst, orb2, orb3, orb4, orbCenter, orb6, orb7, orb8, orbLast);		
		addOrbs(orbFirst, orb2, orb3, orb4, orbCenter, orb6, orb7, orb8, orbLast);
	}
}

class DragScene extends Scene {
	// maybe also add in mass & radius comparisons?
	// and some handy text above
	DragScene() {
		super();

		physicsToggles.add(PhysicsToggle.DOWNWARD_GRAVITY);
		physicsToggles.add(PhysicsToggle.DRAG);
		physicsToggles.add(PhysicsToggle.WALL_BOUNCE);
		physicsToggles.add(PhysicsToggle.COLLISIONS);

		simulationConstants.put(SimulationConstant.GRAVITATIONAL_ACCELERATION, 500.0);

		float regionHeight = 400;
		addDragRegions(new DragRegion(0.0000005, color(0, 90, 255, 10), 0, height - regionHeight, width / 3, regionHeight));
		addDragRegions(new DragRegion(0.0000015, color(0, 90, 255, 50), width / 3, height - regionHeight, width / 3, regionHeight));
		addDragRegions(new DragRegion(0.0000050, color(0, 90, 255, 100), width * 2 / 3, height - regionHeight, width / 3, regionHeight));

		Orb orb1 = new Orb(new PVector(width * 1 / 6, height / 2 - 300), 1, 50, color(255, 0, 0));
		Orb orb2 = new Orb(new PVector(width * 3 / 6, height / 2 - 300), 1, 50, color(255, 0, 0));
		Orb orb3 = new Orb(new PVector(width * 5 / 6, height / 2 - 300), 1, 50, color(255, 0, 0));

		addOrbs(orb1, orb2, orb3);
	}
}

class CollisionsScene extends Scene {
	CollisionsScene() {
		super();
		// physicsTicksPerSecond = 1000;

		physicsToggles.add(PhysicsToggle.DOWNWARD_GRAVITY);
		// physicsToggles.add(PhysicsToggle.DRAG);
		physicsToggles.add(PhysicsToggle.WALL_BOUNCE);
		physicsToggles.add(PhysicsToggle.COLLISIONS);

		simulationConstants.put(SimulationConstant.GRAVITATIONAL_ACCELERATION, 2000.0);
		// simulationConstants.put(SimulationConstant.DRAG_COEFFICIENT, 0.0000001);

		Orb orb1 = new Orb(new PVector(width / 2 - 450, height / 2 - 200), 1, 50, color(255, 0, 0));
		Orb orb2 = new Orb(new PVector(width / 2 + 400, height / 2 + 200), 1, 50, color(0, 255, 0));

		orb1.vel.set(500, -500);
		orb2.vel.set(-500, 1000);

		addOrbs(orb1, orb2);
	}
}
