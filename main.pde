import java.util.List;
import java.util.Set;
import java.util.Map;
import java.util.EnumMap;
import java.util.HashSet;
import java.util.Arrays;
import java.util.stream.*;

int resx = 1920, resy = 1080;
float timeScale = 1.0;
float physicsTickRateMultiplier = 1.0;
boolean paused = false;

void settings() {
	size(resx, resy);

	changeScene(new OrbitsScene());
}

float physicsTicksPerSecond;
float physicsTickDuration;

Scene activeScene;
float lastFrameTime;
float deltaTimeForPhysics;

void draw() {
	physicsTicksPerSecond = activeScene.physicsTicksPerSecond * physicsTickRateMultiplier;
	physicsTickDuration = 1.0 / physicsTicksPerSecond;

	float delta = float(millis()) / 1000 - lastFrameTime;
	lastFrameTime = float(millis()) / 1000;
	deltaTimeForPhysics += delta;
	int physicsTicks = floor(deltaTimeForPhysics / physicsTickDuration);
	deltaTimeForPhysics = deltaTimeForPhysics % physicsTickDuration;

	if (!paused) activeScene.physicsUpdate(physicsTicks, physicsTickDuration * timeScale);
	activeScene.draw();
	drawInterface();
}

void drawInterface() {
	textSize(28);
	String[] labels = {"Moving", "Wall Bounce (b)", "Gravity", "Drag", "Spring", "Collisions", str((float)round(timeScale * 100) / 100) + "x", str(round(physicsTicksPerSecond)) + "tps"};
	boolean[] state = {
		!paused,
		activeScene.physicsToggles.contains(PhysicsToggle.WALL_BOUNCE),
		activeScene.physicsToggles.contains(PhysicsToggle.GRAVITY) || activeScene.physicsToggles.contains(PhysicsToggle.DOWNWARD_GRAVITY),
		activeScene.physicsToggles.contains(PhysicsToggle.DRAG),
		activeScene.physicsToggles.contains(PhysicsToggle.SPRING),
		activeScene.physicsToggles.contains(PhysicsToggle.COLLISIONS),
		abs(timeScale - 1.0) > 0.00001,
		abs(physicsTickRateMultiplier - 1.0) > 0.00001,
	};

	List<Float> widths = Stream.of(labels).map(label -> textWidth(label)).collect(Collectors.toList());
	
	float horizontalPadding = 12.0;
	float toggleHeight = 40.0;
	float gap = 10.0;
	float borderRadius = 10.0;
	float bottomMargin = 30.0;

	float togglesTotalWidth = widths.stream().reduce(0.0, Float::sum) + horizontalPadding * 2 * widths.size() + gap * (widths.size() - 1);
	float leftMargin = (width - togglesTotalWidth) / 2;
	float topMargin = height - bottomMargin - toggleHeight;

	float currentX = leftMargin;
	for (int i = 0; i < labels.length; i++) {
		fill(state[i] ? color(0, 255, 0) : color(255, 0, 0));
		rectMode(CORNER);
		noStroke();
		rect(currentX, topMargin, widths.get(i) + horizontalPadding * 2, toggleHeight, borderRadius);
		textAlign(LEFT, CENTER);
		fill(255);
		text(labels[i], currentX + horizontalPadding, topMargin + toggleHeight / 2.0);
		currentX += widths.get(i) + horizontalPadding * 2 + gap;
	}
}

void changeScene(Scene scene) {
	activeScene = scene;
	deltaTimeForPhysics = 0;
}

void keyPressed() {
	if (key == '1') changeScene(new OrbitsScene());
	if (key == '2') changeScene(new SpringsScene());
	if (key == '3') changeScene(new DragScene());
	if (key == '4') changeScene(new CollisionsScene());
	if (key == ' ') paused = !paused;
	if (key == 'b') if (activeScene.physicsToggles.contains(PhysicsToggle.WALL_BOUNCE)) activeScene.physicsToggles.remove(PhysicsToggle.WALL_BOUNCE); else activeScene.physicsToggles.add(PhysicsToggle.WALL_BOUNCE);
	if (keyCode == UP) timeScale += 0.2;
	if (keyCode == DOWN) timeScale -= 0.2;
	if (keyCode == RIGHT) physicsTickRateMultiplier += 0.05;
	if (keyCode == LEFT) physicsTickRateMultiplier -= 0.05;

	if (physicsTickRateMultiplier <= 0) physicsTickRateMultiplier = 0.05;
}