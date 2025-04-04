import java.util.List;
import java.util.Set;
import java.util.Map;
import java.util.EnumMap;
import java.util.HashSet;

int resx = 1920, resy = 1080;
int orbSize = 50;
int physicsTicksPerSecond = 100;

void settings() {
	size(resx, resy);
	
}

float physicsTickDuration = 1.0 / physicsTicksPerSecond;

float lastFrameTime;
float deltaTimeForPhysics;
List<Orb> orbs = new ArrayList<>();
Set<PhysicsToggles> physicsToggles = new HashSet<>();
Map<PhysicsConstants, Float> physicsConstants = new EnumMap<>(PhysicsConstants.class);

void draw() {
	float delta = float(millis()) / 1000 - lastFrameTime;
	lastFrameTime = float(millis()) / 1000;
	deltaTimeForPhysics += delta;

	while (deltaTimeForPhysics >= physicsTickDuration) {
		deltaTimeForPhysics -= physicsTickDuration;
		
		if (!physicsToggles.contains(PhysicsToggles.MOVEMENT)) continue;
		for (Orb orb : orbs) {
			if (physicsToggles.contains(PhysicsToggles.WALL_BOUNCE)) wallBounceOrb(orb);
			if (physicsToggles.contains(PhysicsToggles.GRAVITY)) orb.applyForce(getGravityForce(physicsConstants.get(PhysicsConstants.GRAVITATIONAL_CONSTANT), orb, orbs));
		}
	}

	for (Orb orb : orbs) {
		orb.applyAcceleration(delta);
		orb.applyVelocity(delta);
	}

	background(255);
	println(orbs);
	for (Orb orb : orbs) {
		orb.draw();
	}
}

void keyPressed() {
	if (key == '1') setupOrbits(orbs, physicsToggles, physicsConstants);
}