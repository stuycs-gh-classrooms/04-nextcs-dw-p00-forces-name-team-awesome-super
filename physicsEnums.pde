enum PhysicsToggle {
	WALL_BOUNCE,
	GRAVITY,
	DOWNWARD_GRAVITY, // for convenience
	DRAG,
	SPRING,
	COLLISIONS,
}

enum SimulationConstant {
	GRAVITATIONAL_CONSTANT, // G
	GRAVITATIONAL_ACCELERATION, // "g", for downward gravity
	SPRING_CONSTANT, // k
	SPRING_LENGTH,
	DRAG_COEFFICIENT,
}
