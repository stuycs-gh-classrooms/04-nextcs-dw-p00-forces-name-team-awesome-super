// This class holds all the information for a physics simulation, including
// the orbs in it, what forces are enabled, what constants are set to, and some time/physics controls
class Scene {
	List<Orb> orbs;
	Set<PhysicsToggle> physicsToggles;
	Map<SimulationConstant, Float> simulationConstants;
	List<DragRegion> dragRegions; // regions with a unique drag coefficient
	float physicsTicksPerSecond; // how many physics updates will occur each second
	float timeScale; // 1.0 for default speed, 0.5 for slow motion, 2 to speed things up, etc.

	Scene() {
		// init variables
		orbs = new ArrayList<>();
		physicsToggles = new HashSet<>();
		simulationConstants = new EnumMap<>(SimulationConstant.class);
		dragRegions = new ArrayList<>();
		physicsTicksPerSecond = 5000;
		timeScale = 1.0;
	}

	// a convenience method to add orbs to the scene
	void addOrbs(Orb... orbs) {
		this.orbs.addAll(Arrays.asList(orbs));
	}

	// a convenience method to add drag regions to the scene
	void addDragRegions(DragRegion... regions) {
		dragRegions.addAll(Arrays.asList(regions));
	}

	// perform all physics for the scene
	// `ticks` controls how many physics updates are run
	// tickDuration is the deltatime used for each update
	void physicsUpdate(int ticks, float tickDuration) {
		for (int i = 0; i < ticks; i++) {
			for (Orb orb : orbs) {
				if (physicsToggles.contains(PhysicsToggle.GRAVITY)) orb.applyForce(getGravityForce(simulationConstants.get(SimulationConstant.GRAVITATIONAL_CONSTANT), orb, orbs));
				if (physicsToggles.contains(PhysicsToggle.DOWNWARD_GRAVITY)) orb.applyForce(getDownwardGravityForce(simulationConstants.get(SimulationConstant.GRAVITATIONAL_ACCELERATION), orb));
				if (physicsToggles.contains(PhysicsToggle.SPRING) && orb instanceof LinkedListOrb) orb.applyForce(getSpringForce(simulationConstants.get(SimulationConstant.SPRING_CONSTANT), simulationConstants.get(SimulationConstant.SPRING_LENGTH), (LinkedListOrb) orb));

				if (physicsToggles.contains(PhysicsToggle.DRAG)) {
					float dragCoefficient = dragRegions.stream().filter(region -> region.contains(orb.pos)).findFirst().map(region -> region.dragCoefficient).orElse(simulationConstants.getOrDefault(SimulationConstant.DRAG_COEFFICIENT, 0.0));
					orb.applyForce(getDragForce(dragCoefficient, orb));
				}
			}

			if (physicsToggles.contains(PhysicsToggle.COLLISIONS)) collideOrbs(orbs);
			
			for (Orb orb : orbs) {
				orb.applyAcceleration(tickDuration);
				orb.applyVelocity(tickDuration);
				if (physicsToggles.contains(PhysicsToggle.WALL_BOUNCE)) wallBounceOrb(orb);
			}
		}
	}

	void drawOrbs() {
		// call the draw method on every orb
		for (Orb orb : orbs) {
			orb.draw();
		}
	}

	void drawSprings() {
		// draws lines connecting each orb
		// lines are colored green if the spring's compressed and red if it's stretched
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

	void drawDragRegions() {
		// call the draw method on every drag region
		for (DragRegion region : dragRegions) {
			region.draw();
		}
	}

	// main method to draw the scene to the screen
	void draw() {
		background(255);
		drawDragRegions();
		drawSprings();
		drawOrbs();
	}
}