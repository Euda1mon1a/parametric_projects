# Architecture: Continuous Gravity-Fed Path (v1.4)

This document explains the core architectural concept that makes the v1.4 dice tower functional and reliable.

## The Problem with Previous Designs

Early iterations (v1.3 and earlier) modeled the tower as a stack of separate components:
1.  A funnel on top with a solid floor.
2.  A spiral ramp below it.

To get dice from the funnel to the ramp, a hole had to be "cut" into the funnel floor. This created a poor user experience: dice would hit the flat floor, bounce randomly, and hopefully fall into the slot. It was prone to jamming and relied on complex boolean logic.

## The v1.4 Solution: Extended Ramp

v1.4 fundamentally changes this approach by ensuring the dice path is continuous from entry to exit, driven entirely by gravity.

### Key Design Elements

1.  **Hollow Funnel Shell:** The `entry_funnel()` module creates *only* the outer conical walls. It has absolutely no floor. It is an open-bottomed hopper.

2.  **Upwardly Extended Ramp:** The `spiral_ramp()` does not stop below the funnel. Its height is calculated to extend physically *up inside* the hollow funnel shell.

### Parametric Calculation

The geometry is defined dynamically to ensure this overlap always occurs, regardless of tower height changes:

```openscad
// 1. Define the bottom Z-plane of the funnel
funnel_bottom_z = tower_height - entry_funnel_height;

// 2. Define how far the ramp should stick up past that plane
ramp_overlap_in_funnel = 10; // mm

// 3. Calculate total ramp height required to achieve this overlap
ramp_height = funnel_bottom_z + ramp_overlap_in_funnel - ramp_start_z;
```

### How it Works

1.  A user drops dice into the wide top opening of the funnel.
2.  The angled walls of the hollow funnel guide the dice inward.
3.  Because there is no floor, gravity pulls the dice straight down.
4.  They land directly onto the starting section of the spiral ramp, which is positioned waiting inside the funnel.
5.  The dice immediately begin their corkscrew descent.

This architecture eliminates flat surfaces, vertical drops, and complex boolean cuts, resulting in a highly reliable, jam-free mechanism.
