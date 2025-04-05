class Scene {
	List<Orb> orbs;
	Set<PhysicsToggle> physicsToggles;
	Map<SimulationConstant, Float> simulationConstants;

	Scene() {
		orbs = new ArrayList<>();
		physicsToggles = new HashSet<>();
		simulationConstants = new EnumMap<>(SimulationConstant.class);
	}

	void physicsUpdate(int ticks, float tickDuration) {
		for (int i = 0; i < ticks; i++) {
			for (Orb orb : orbs) {
				if (physicsToggles.contains(PhysicsToggle.GRAVITY)) orb.applyForce(getGravityForce(simulationConstants.get(SimulationConstant.GRAVITATIONAL_CONSTANT), orb, orbs));
				if (physicsToggles.contains(PhysicsToggle.DOWNWARD_GRAVITY)) orb.applyForce(getDownwardGravityForce(simulationConstants.get(SimulationConstant.GRAVITATIONAL_ACCELERATION), orb));
				if (physicsToggles.contains(PhysicsToggle.SPRING) && orb instanceof LinkedListOrb) orb.applyForce(getSpringForce(simulationConstants.get(SimulationConstant.SPRING_CONSTANT), simulationConstants.get(SimulationConstant.SPRING_LENGTH), (LinkedListOrb) orb));
				
			}
			for (Orb orb : orbs) {
				orb.applyAcceleration(tickDuration);
				orb.applyVelocity(tickDuration);
				if (physicsToggles.contains(PhysicsToggle.WALL_BOUNCE)) wallBounceOrb(orb);
			}
		}
	}

	void drawOrbs() {
		for (Orb orb : orbs) {
			orb.draw();
		}
	}

	void drawSprings() {
		strokeWeight(3);
		for (Orb genericOrb : orbs) {
			if (!(genericOrb instanceof LinkedListOrb)) continue;
			LinkedListOrb orb = (LinkedListOrb) genericOrb;
			if (orb.previous != null) {
				stroke(orb.previous.pos.dist(orb.pos) < simulationConstants.get(SimulationConstant.SPRING_LENGTH) ? color(0, 255, 0) : color(255, 0, 0));
				line(orb.previous.pos.x, orb.previous.pos.y, orb.pos.x, orb.pos.y);
			}
			if (orb.next != null) {
				stroke(orb.next.pos.dist(orb.pos) < simulationConstants.get(SimulationConstant.SPRING_LENGTH) ? color(0, 255, 0) : color(255, 0, 0));
				line(orb.next.pos.x, orb.next.pos.y, orb.pos.x, orb.pos.y);
			}
		}
	}

	void draw() {
		background(255);
		drawSprings();
		drawOrbs();
	}
}