// forces that can be enabled or disabled
enum PhysicsToggle {
	WALL_BOUNCE,
	GRAVITY,
	DOWNWARD_GRAVITY, // for convenience
	DRAG,
	SPRING,
	COLLISIONS,
}

// constants used by the forces above
enum SimulationConstant {
	GRAVITATIONAL_CONSTANT, // G
	GRAVITATIONAL_ACCELERATION, // "g", for downward gravity
	SPRING_CONSTANT, // k
	SPRING_LENGTH, // x
	DRAG_COEFFICIENT, // c_d
}
