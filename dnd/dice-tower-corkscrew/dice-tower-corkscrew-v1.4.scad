// ===================================================================
// Corkscrew Wizard Tower Dice Tower v1.4 (Stable)
//
// A parametric, gravity-fed corkscrew dice tower.
// Uses BOSL2 for manifold geometry and Round-Anything for fillets.
//
// Architecture: Continuous path, gravity-fed (Ramp extends into hollow funnel)
// Status: Functional prototype complete. Ready for testing.
//
// Author: Aaron Montgomery
// Date: 2024-12-08
// License: CC-BY-4.0
// Repository: https://github.com/Euda1mon1a/parametric_projects
// ===================================================================

include <BOSL2/std.scad>
include <Round-Anything/polyround.scad>

// ===================================================================
// PARAMETERS - Customize these values
// ===================================================================

/* [Tower Dimensions] */
tower_height = 150;           // Total height of tower [mm]
pillar_diameter = 30;         // Central pillar diameter [mm]
spiral_diameter = 70;         // Outer diameter of spiral path [mm]
spiral_rotations = 2.5;       // Number of complete rotations

/* [Ramp Design] */
ramp_width = 20;              // Width of the spiral ramp [mm]
ramp_thickness = 2;           // Thickness of the ramp surface [mm]
wall_height = 15;             // Height of outer wall along ramp [mm]
wall_thickness = 2;           // Thickness of outer wall [mm]
corner_radius = 1;            // Radius for rounded corners on ramp profile [mm]

/* [Entry & Exit] */
entry_funnel_height = 20;     // Height of entry funnel at top [mm]
entry_diameter = 50;          // Diameter of entry opening [mm]
tray_diameter = 90;           // Diameter of catch tray [mm]
tray_depth = 15;              // Depth of catch tray [mm]
tray_wall_thickness = 2;      // Thickness of tray walls [mm]

/* [Advanced] */
$fn = 100;                    // Rendering quality (higher = smoother)

// ===================================================================
// CALCULATIONS - Derived values
// ===================================================================

ramp_radius = spiral_diameter / 2;
pillar_radius = pillar_diameter / 2;
ramp_start_z = tray_depth + 5;

// --- Continuous Path Calculation ---
// The ramp must extend UP into the hollow funnel area to catch dice.
funnel_bottom_z = tower_height - entry_funnel_height;
ramp_overlap_in_funnel = 10;  // Amount ramp extends into funnel [mm]
ramp_height = funnel_bottom_z + ramp_overlap_in_funnel - ramp_start_z;

// Pillar height ends just below the funnel top to avoid blocking entry
pillar_height = tower_height - 5;

// Spiral at mid-radius of ramp for physics calc
spiral_mid_radius = pillar_radius + ramp_width / 2;

// Ramp physics check
ramp_path_length = 2 * PI * spiral_mid_radius * spiral_rotations;
ramp_descent_angle = atan(ramp_height / ramp_path_length);
// Result: ~15.7° descent angle with default params

// ===================================================================
// MAIN MODEL
// ===================================================================

module corkscrew_dice_tower() {
    union() {
        // Base catch tray (Standard OpenSCAD)
        catch_tray();

        // Central pillar (Standard OpenSCAD)
        // Provides structural support for the entire ramp length
        translate([0, 0, 0])
            cylinder(h = pillar_height, d = pillar_diameter);

        // Spiral ramp (BOSL2 & Round-Anything)
        // Extends from above tray up into the funnel
        translate([0, 0, ramp_start_z])
            spiral_ramp();

        // Entry funnel (Standard OpenSCAD)
        // Hollow shell placed over the top of the ramp
        entry_funnel();
    }
}

// ===================================================================
// COMPONENT MODULES
// ===================================================================

module catch_tray() {
    difference() {
        cylinder(h = tray_depth, d = tray_diameter);
        translate([0, 0, tray_wall_thickness])
            cylinder(h = tray_depth, d = tray_diameter - 2*tray_wall_thickness);
    }
}

module spiral_ramp() {
    // Define ramp cross-section with rounded corners using Round-Anything
    // Format: [x, y, radius] - radius at each vertex
    // Defines the floor and outer wall of the ramp
    ramp_profile = polyRound([
        [0, 0, 0],                                          // Inner edge at pillar (no radius)
        [ramp_width, 0, corner_radius],                     // Outer edge of floor
        [ramp_width, wall_height, corner_radius],           // Top of outer wall
        [ramp_width - wall_thickness, wall_height, 0.5],    // Inner top of wall
        [ramp_width - wall_thickness, ramp_thickness, corner_radius], // Step up to inner wall
        [0, ramp_thickness, 0]                              // Back to inner edge (no radius)
    ], fn=20);

    // Sweep the profile along a spiral path using BOSL2
    // Creates guaranteed manifold helical geometry
    spiral_sweep(
        ramp_profile,
        h = ramp_height,
        r = pillar_radius,
        turns = spiral_rotations,
        higbee = 0.05,  // Taper ends slightly for cleaner mesh
        anchor = BOTTOM
    );
}

module entry_funnel() {
    // Funnel is a hollow conical shell ONLY.
    // It has NO floor. Dice fall through it directly onto the ramp start.
    translate([0, 0, tower_height - entry_funnel_height]) {
        difference() {
            // Outer shell
            cylinder(h = entry_funnel_height,
                     d1 = spiral_diameter,
                     d2 = entry_diameter);

            // Inner cutout to create walls
            translate([0, 0, -0.1])
                cylinder(h = entry_funnel_height + 0.2,
                         d1 = spiral_diameter - 2*wall_thickness,
                         d2 = entry_diameter - 2*wall_thickness);
        }
    }
}

// ===================================================================
// RENDER
// ===================================================================

corkscrew_dice_tower();
