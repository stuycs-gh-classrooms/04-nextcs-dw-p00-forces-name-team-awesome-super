[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-22041afd0340ce965d47ae6ef1cefeee28c7c493a6346c4f15d667ab976d596c.svg)](https://classroom.github.com/a/Dzq9z9T4)
# Project 00 For NeXT CS
### Class Period: 04
### Name0: Nicolai Selector
---

This project will be completed in phases. The first phase will be to work on this document. Use makrdown formatting. For more markdown help [click here](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet) or [here](https://docs.github.com/en/get-started/writing-on-github/getting-started-with-writing-and-formatting-on-github/basic-writing-and-formatting-syntax)

All projects will require the following:
- Researching new forces to impliment.
- Methods for each new force the returns a `PVector` similar to how `getGravity` and `getSpring` (using whatever parameters are necessary).
- A distinct demonstration for each individual force (including gravity and the spring force).
- A visual menu at the top providing information about which simulation is currently active and if movement is on or off.
- The ability to toggle movement on/off
- The ability to toggle bouncing on/off
- The user shoudl be able to switch between simluations using the numebr keys as follows:
  - `1`: Gravity
  - `2`: Spring Force
  - `3`: Drag
  - `4`: Custom Force
  - `5`: Combination

## Phase 0: Force Selection, Analysis & Plan

#### Custom Force: Collision

### Forumla
What is the formula for your force? Including descriptions/definitions for the symbols. You may include a picture of the formula if it is not easily typed.

calculate velocities via momentum and KE (todo: figure out how to do that)
then reflect velocity over angle to other and flip

### Custom Force
- What information that is already present in the `Orb` or `OrbNode` classes does this force use?
  - mass, velocity, bsize to detect collisions

- Does this force require any new constants, if so what are they and what values will you try initially?
  - nope

- Does this force require any new information to be added to the `Orb` class? If so, what is it and what data type will you use?
  - nuh-uh

- Does this force interact with other `Orbs`, or is it applied based on the environment?
  - it interacts with other orbs

- In order to calculate this force, do you need to perform extra intermediary calculations? If so, what?
  - the speeds after collision
  - the angle of collision

### Simulation 1: Gravity
Describe how you will attempt to simulate orbital motion.

one large fixed orb in the center with a bunch of mass and no velocity, and a bunch of orbs around it with some initial velocity so they move in circles

### Simulation 2: Spring
Describe what your spring simulation will look like. Explain how it will be setup, and how it should behave while running.

YOUR ANSWER HERE

### Simulation 3: Drag
Describe what your drag simulation will look like. Explain how it will be setup, and how it should behave while running.

YOUR ANSWER HERE

### Simulation 4: Custom force
Describe what your Custom force simulation will look like. Explain how it will be setup, and how it should behave while running.

YOUR ANSWER HERE

### Simulation 5: Combination
Describe what your combination simulation will look like. Explain how it will be setup, and how it should behave while running.

YOUR ANSWER HERE
