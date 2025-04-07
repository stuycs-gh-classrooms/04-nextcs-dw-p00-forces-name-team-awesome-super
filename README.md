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

$
\begin{align}
v'_{1x} &= \frac{v_{1}\cos(\theta_1-\varphi)(m_1-m_2)+2m_2v_{2}\cos(\theta_2-\varphi)}{m_1+m_2}\cos(\varphi)+v_{1}\sin(\theta_1-\varphi)\cos(\varphi + \tfrac{\pi}{2})
\\[0.8em]
v'_{1y} &= \frac{v_{1}\cos(\theta_1-\varphi)(m_1-m_2)+2m_2v_{2}\cos(\theta_2-\varphi)}{m_1+m_2}\sin(\varphi)+v_{1}\sin(\theta_1-\varphi)\sin(\varphi + \tfrac{\pi}{2}),
\end{align}
$

$m$ is mass, $v$ and $\theta$ are velocity's direction and magnitude, $\varphi$ is the angle from object 1 to object 2  
You calculate second object's velocity by swapping the subscript '1's with subscript '2's

[[source](https://en.wikipedia.org/wiki/Elastic_collision#Two-dimensional_collision_with_two_moving_objects)]

### Custom Force
- What information that is already present in the `Orb` or `OrbNode` classes does this force use?
  - mass, velocity, and radius to detect collisions

- Does this force require any new constants, if so what are they and what values will you try initially?
  - nope

- Does this force require any new information to be added to the `Orb` class? If so, what is it and what data type will you use?
  - no

- Does this force interact with other `Orbs`, or is it applied based on the environment?
  - it interacts with other orbs

- In order to calculate this force, do you need to perform extra intermediary calculations? If so, what?
  - You need to get the magnitude and headings of the two orbs and the angle from one to the other

### Simulation 1: Gravity
Describe how you will attempt to simulate orbital motion.

For fun I want to have a two body system. I'll have two orbs with a huge amount of mass orbiting each other in the center and a handful of orbs orbiting around them.

To get the velocity for circular orbits I'll solve for v in $\frac{GMm}{r_d^2} = \frac{mv^2}{r_o}$, where $r_d$ is the distance from the body/bodies that's pulling you towards the center and $r_o$ is the radius of your orbit

### Simulation 2: Spring
Describe what your spring simulation will look like. Explain how it will be setup, and how it should behave while running.

I want to have a horizontal chain of orbs with both ends fixed and a really heavy orb in the center. When running the heavy orb should pull the chain downwards, and then the chain should pull the heavy orb back up.

### Simulation 3: Drag
Describe what your drag simulation will look like. Explain how it will be setup, and how it should behave while running.

I want to have three different drag regions at the bottom and three orbs fall into each. The first orb will have more mass and the last orb will have a larger radius (I want to include cross-sectional area in my drag calculation). When running it should create an oblique line of orbs, or at least a sawtooth wave of them.

### Simulation 4: Custom force
Describe what your Custom force simulation will look like. Explain how it will be setup, and how it should behave while running.

I'm planning to have three orbs, they'll start spread out with some initial velocity and bounce around the scene and on each other.

### Simulation 5: Combination
Describe what your combination simulation will look like. Explain how it will be setup, and how it should behave while running.

I'm going to try to make a double pendulum out of springs, along with a fixed orb on the right to attract things and a bunch of projectile orbs on the left to collide with the spring. When running there are going to be a bunch of collisions and some orbs floating towards each other
