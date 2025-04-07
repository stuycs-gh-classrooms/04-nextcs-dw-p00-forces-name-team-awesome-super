float getOrbitVelocity(float gravitationalConstant, float centralMass, float radius) {
	return sqrt(gravitationalConstant * centralMass / radius);
}

class OrbitsScene extends Scene {
	float[] orbitRadii = {200, 250, 300, 350, 400, 450, 500, 550, 600};
	color[] planetColors = {
		color(215),
		color(255),
		color(50, 150, 255),
		color(255, 100, 0),
		color(255, 200, 0),
		color(255, 220, 150),
		color(255, 200, 70),
		color(70, 150, 255),
		color(0, 100, 255),
	};

	float[] planetSizes = {5, 10, 10, 8, 6, 20, 13, 10, 9};

	OrbitsScene() {
		super();

		physicsToggles.add(PhysicsToggle.GRAVITY);
		physicsToggles.add(PhysicsToggle.COLLISIONS);

		float gConst = 0.002;
		simulationConstants.put(SimulationConstant.GRAVITATIONAL_CONSTANT, gConst);

		float centralBodyMass = 1000000000;
		
		Orb centralBody1 = new Orb(new PVector(width / 2 - 40, height / 2), centralBodyMass, 30, color(255, 200, 100));
		Orb centralBody2 = new Orb(new PVector(width / 2 + 40, height / 2), centralBodyMass, 30, color(100, 200, 255));
		centralBody1.vel.set(0, sqrt(gConst * centralBodyMass / sq(80) * 40));
		centralBody2.vel.set(0, -sqrt(gConst * centralBodyMass / sq(80) * 40));

		for (int i = 0; i < orbitRadii.length; i++) {
			float radius = orbitRadii[i];
			color fillColor = planetColors[i];
			float size = planetSizes[i];
			Orb planet = new Orb(new PVector(width / 2 + radius, height / 2), 0.1, size, fillColor);
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
		LinkedListOrb orb2 = new LinkedListOrb(new PVector(width / 2 - orbDistance * 3, height / 2 - 400), 1, 50, color(215));
		LinkedListOrb orb3 = new LinkedListOrb(new PVector(width / 2 - orbDistance * 2, height / 2 - 400), 1, 50, color(215));
		LinkedListOrb orb4 = new LinkedListOrb(new PVector(width / 2 - orbDistance * 1, height / 2 - 400), 1, 50, color(215));
		LinkedListOrb orbCenter = new LinkedListOrb(new PVector(width / 2, height / 2 - 400), 10, 50, color(0));
		LinkedListOrb orb6 = new LinkedListOrb(new PVector(width / 2 + orbDistance * 1, height / 2 - 400), 1, 50, color(215));
		LinkedListOrb orb7 = new LinkedListOrb(new PVector(width / 2 + orbDistance * 2, height / 2 - 400), 1, 50, color(215));
		LinkedListOrb orb8 = new LinkedListOrb(new PVector(width / 2 + orbDistance * 3, height / 2 - 400), 1, 50, color(215));
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

		Orb orb1 = new Orb(new PVector(width * 1 / 12, height / 2 - 300), 3, 50, color(0));
		Orb orb2 = new Orb(new PVector(width * 2 / 12, height / 2 - 300), 1, 50, color(255, 0, 0));
		Orb orb3 = new Orb(new PVector(width * 3 / 12, height / 2 - 300), 1, 80, color(215));

		Orb orb4 = new Orb(new PVector(width * 5 / 12, height / 2 - 300), 3, 50, color(0));
		Orb orb5 = new Orb(new PVector(width * 6 / 12, height / 2 - 300), 1, 50, color(255, 0, 0));
		Orb orb6 = new Orb(new PVector(width * 7 / 12, height / 2 - 300), 1, 80, color(215));

		Orb orb7 = new Orb(new PVector(width * 9 / 12, height / 2 - 300), 3, 50, color(0));
		Orb orb8 = new Orb(new PVector(width * 10 / 12, height / 2 - 300), 1, 50, color(255, 0, 0));
		Orb orb9 = new Orb(new PVector(width * 11 / 12, height / 2 - 300), 1, 80, color(215));

		addOrbs(orb1, orb2, orb3, orb4, orb5, orb6, orb7, orb8, orb9);
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
		Orb orb3 = new Orb(new PVector(width / 2 + 800, height / 2 + 400), 1, 50, color(0, 0, 255));

		orb1.vel.set(500, -500);
		orb2.vel.set(-500, 1000);
		orb3.vel.set(200, -1000);

		addOrbs(orb1, orb2, orb3);
	}
}

// class CombinationScene extends Scene {
// 	CombinationScene() {
// 		super();

// 		physicsToggles.add(PhysicsToggle.GRAVITY);
// 		physicsToggles.add(PhysicsToggle.DRAG);
// 		physicsToggles.add(PhysicsToggle.COLLISIONS);
// 		physicsToggles.add(PhysicsToggle.SPRING);
// 		physicsToggles.add(PhysicsToggle.WALL_BOUNCE);

// 		simulationConstants.put(SimulationConstant.GRAVITATIONAL_CONSTANT, 200.0);
// 		simulationConstants.put(SimulationConstant.SPRING_CONSTANT, 5.0);
// 		simulationConstants.put(SimulationConstant.SPRING_LENGTH, 500.0);
// 		// simulationConstants.put(SimulationConstant.DRAG_COEFFICIENT, 0.0000008);

// 		Orb targetOrb1 = new Orb(new PVector(width / 2 - 70, height / 2 - 20), 1, 50, color(255, 0, 0));
// 		Orb targetOrb2 = new Orb(new PVector(width / 2 + 70, height / 2 + 20), 1, 50, color(0, 255, 0));
// 		LinkedListOrb springOrbFixed = new LinkedListOrb(new PVector(width - 80, height - 80), 1, 50, color(0, 0, 0));
// 		LinkedListOrb springOrbFree = new LinkedListOrb(new PVector(300, 80), 1, 50, color(255, 0, 0));

// 		linkOrbs(springOrbFixed, springOrbFree);

// 		targetOrb1.vel.set(0, 1000);
// 		targetOrb2.vel.set(0, 1000);
// 		springOrbFixed.fixed = true;

// 		addOrbs(targetOrb1, targetOrb2, springOrbFixed, springOrbFree);
// 	}
// }



class CombinationScene extends Scene {
	CombinationScene() {
		super();
		timeScale = 0.4;

		physicsToggles.add(PhysicsToggle.GRAVITY);
		physicsToggles.add(PhysicsToggle.DRAG);
		physicsToggles.add(PhysicsToggle.COLLISIONS);
		physicsToggles.add(PhysicsToggle.SPRING);
		physicsToggles.add(PhysicsToggle.WALL_BOUNCE);

		simulationConstants.put(SimulationConstant.GRAVITATIONAL_CONSTANT, 20000.0);
		simulationConstants.put(SimulationConstant.SPRING_CONSTANT, 50.0);
		simulationConstants.put(SimulationConstant.SPRING_LENGTH, 200.0);
		simulationConstants.put(SimulationConstant.DRAG_COEFFICIENT, 0.0000002);

		LinkedListOrb fixedOrb = new LinkedListOrb(new PVector(width / 2, height / 2 - 500), 0, 50, color(0));
		LinkedListOrb pendulum1 = new LinkedListOrb(new PVector(width / 2 + 200, height / 2 - 500), 1, 50, color(0, 255, 0));
		LinkedListOrb pendulum2 = new LinkedListOrb(new PVector(width / 2 + 400, height / 2 - 500), 2, 50, color(0, 255, 0));
		LinkedListOrb pendulum3 = new LinkedListOrb(new PVector(width / 2 + 500, height / 2 - 500), 0.5, 50, color(0, 255, 0));

		Orb projectileOrb1 = new Orb(new PVector(width / 2 - 800, height / 2 - 500), 5.0, 50, color(0, 100, 255));
		Orb projectileOrb2 = new Orb(new PVector(width / 2 - 800, height / 2 - 350), 5.0, 50, color(0, 100, 255));
		Orb projectileOrb3 = new Orb(new PVector(width / 2 - 800, height / 2 - 200), 5.0, 50, color(0, 100, 255));
		Orb projectileOrb4 = new Orb(new PVector(width / 2 - 800, height / 2 - 50), 5.0, 50, color(0, 100, 255));
		Orb projectileOrb5 = new Orb(new PVector(width / 2 - 800, height / 2 + 100), 5.0, 50, color(0, 100, 255));

		Orb earthOrb = new Orb(new PVector(width / 2, 99999), 999999999.0, 50, color(255, 0, 0));
		Orb gravityOrb = new Orb(new PVector(width / 2 + 800, height / 2), 6500.0, 50, color(255, 0, 0));

		linkOrbs(fixedOrb, pendulum1, pendulum2, pendulum3);

		fixedOrb.fixed = true;
		earthOrb.fixed = true;
		gravityOrb.fixed = true;

		projectileOrb1.vel.set(2000, -300);
		projectileOrb2.vel.set(2000, -300);
		projectileOrb3.vel.set(2000, -300);
		projectileOrb4.vel.set(2000, -300);
		projectileOrb5.vel.set(2000, -300);

		addOrbs(fixedOrb, pendulum1, pendulum2, pendulum3, earthOrb, gravityOrb, projectileOrb1, projectileOrb2, projectileOrb3, projectileOrb4, projectileOrb5);
	}
}