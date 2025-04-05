class Scene {
	List<Orb> orbs;
	Set<PhysicsToggle> physicsToggles;
	Map<PhysicsConstant, Float> physicsConstants;

	Scene() {
		orbs = new ArrayList<>();
		physicsToggles = new HashSet<>();
		physicsConstants = new EnumMap<>(PhysicsConstant.class);
	}

	void physicsUpdate(int ticks, float tickDuration) {
		for (int i = 0; i < ticks; i++) {
			for (Orb orb : orbs) {
				if (physicsToggles.contains(PhysicsToggle.GRAVITY)) orb.applyForce(getGravityForce(physicsConstants.get(PhysicsConstant.GRAVITATIONAL_CONSTANT), orb, orbs));
				
				if (physicsToggles.contains(PhysicsToggle.WALL_BOUNCE)) wallBounceOrb(orb);
			}
			for (Orb orb : orbs) {
				orb.applyAcceleration(tickDuration);
				orb.applyVelocity(tickDuration);
			}
		}
	}

	void drawOrbs() {
		for (Orb orb : orbs) {
			orb.draw();
		}
	}

	void draw() {
		background(255);
		drawOrbs();
	}
}