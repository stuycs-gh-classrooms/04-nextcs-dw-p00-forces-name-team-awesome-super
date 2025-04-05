void linkOrbs(LinkedListOrb... orbs) {
	for (int i = 1; i < orbs.length; i++) {
		orbs[i - 1].next = orbs[i];
		orbs[i].previous = orbs[i - 1];
	}
}
