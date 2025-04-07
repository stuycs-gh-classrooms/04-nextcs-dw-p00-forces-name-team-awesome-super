// this class just adds on next and previous attributes
class LinkedListOrb extends Orb {
	LinkedListOrb next;
	LinkedListOrb previous;

	LinkedListOrb(PVector pos, float mass, float radius, color fillColor) {
		super(pos, mass, radius, fillColor);
	}
}
