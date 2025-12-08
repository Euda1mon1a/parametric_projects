# Dice Tower Design Notes

## Project: Corkscrew Wizard Tower Dice Tower

**Project Status:** v1.2 complete, v1.3 in development
**Author:** Aaron Montgomery
**Date:** 2024-12-07
**Repository:** https://github.com/Euda1mon1a/parametric_projects

## Overview

A parametric 3D-printable dice tower featuring a helical spiral ramp around a central pillar, integrated catch tray, and entry funnel. Designed for tabletop gaming (D&D, board games).

## Design Requirements

### Functional Requirements
- **Continuous ramp surface** - No gaps that dice can fall through
- **Clear entry point** - Visible opening from top view where dice can enter the spiral
- **Unobstructed funnel area** - Central pillar must not block dice rolling at top
- **Adequate ramp width** - Minimum 20mm to accommodate standard gaming dice (d4-d20)
- **Containment walls** - Minimum 15mm height to prevent dice escaping
- **Integrated catch tray** - Self-contained design with built-in collection area
- **Support-free printing** - Designed to print without internal supports

### Dimensional Requirements
- **Total height:** 150mm (comfortable desktop size)
- **Spiral diameter:** 70mm outer, 30mm pillar
- **Ramp width:** 20mm
- **Rotations:** 2.5 complete loops
- **Tray diameter:** 90mm (contains bounced dice)
- **Entry opening:** 50mm (wide enough for multiple dice)

### Print Requirements
- **Layer adhesion:** Continuous surfaces for structural integrity
- **Overhang angles:** ≤45° for support-free printing
- **Wall thickness:** 2mm minimum for rigidity
- **Manifold geometry:** Watertight mesh for reliable slicing

## Technical Approach

### Version History

#### v1.0 - Initial Implementation
- Hull-based spiral generation between consecutive segments
- Separate ramp and wall components
- Optional internal support posts
- **Status:** Functional but support posts were masking geometry issues

#### v1.1 - Structural Improvements
- Unified spiral (ramp + wall in single hull operations)
- Added overlap parameter (0.1mm) for manifold connections
- Continuous pillar from base to top
- **Issue:** Support posts still needed, geometry errors when removed

#### v1.2 - Self-Supporting Design
- Removed all internal support posts
- Increased segment width (2mm → 30mm) for proper overlap
- Tapered inner walls at top 20% for open funnel entry
- Added entry ramp module
- **Issue:** No clear entry point for dice, continuous closed loop

#### v1.3 - Entry Slot Design (In Development)
- Using difference() to cut entry slot after building geometry
- Simplified code structure
- **Issue:** BOSL2 primitive conflicts, needs fixing

### Key Design Patterns

#### 1. Spiral Generation with Hull()

**Principle:** Create smooth continuous surface by hulling between consecutive segments.

```openscad
for (i = [0 : steps-1]) {
    hull() {
        rotate([0, 0, i * angle_step]) segment();
        rotate([0, 0, (i+1) * angle_step]) segment();
    }
}
```

**Critical Parameters:**
- **Steps:** 200 (balance between smoothness and render time)
- **Segment width:** Must be ≥1.5x angular spacing for overlap
- **Calculation:** `segment_width ≥ (360 / steps) * radius * π/180 * 1.5`
  - For 200 steps, 35mm radius: minimum ~3mm, use 20-30mm for solid overlap

#### 2. Entry/Exit with difference()

**Principle:** Build complete structure first, then cut openings.

```openscad
difference() {
    union() {
        spiral_ramp();      // Complete spiral
        pillar();
        tray();
    }
    entry_slot_cut();       // Subtract opening
}
```

**Benefits:**
- Cleaner code than conditional segment generation
- Avoids edge cases at boundaries
- Easier to visualize and adjust

#### 3. Wall Tapering

**Principle:** Reduce inner wall height near top to create open funnel area.

```openscad
taper_start = 0.8;  // Start tapering at 80% height
taper_factor = (i / steps) < taper_start ? 1.0 :
               1.0 - ((i / steps) - taper_start) / (1.0 - taper_start);
wall_height_actual = wall_height * taper_factor;
```

**Effect:**
- Bottom 80%: Full 15mm walls for dice containment
- Top 20%: Tapers from 15mm → 0mm for open entry
- Creates ~50mm open funnel diameter at top

## Common Pitfalls and Solutions

### 1. Thin Segment Gaps

**Symptom:** Spiral looks like a "picket fence" with gaps between segments

**Cause:** Segment width too narrow relative to angular spacing
- Example: 2mm segments with 4.5° spacing = visible gaps

**Solution:** Calculate minimum width and add safety margin
```openscad
min_width = (360 / steps) * radius * PI / 180;
segment_width = min_width * 1.5;  // 50% safety margin
```

### 2. Blocked Entry Area

**Symptom:** No visible opening at top for dice to enter spiral

**Root Causes:**
- Continuous closed spiral loop
- Pillar extending into funnel blocking center
- Inner walls extending too high

**Solutions:**
- Use difference() to cut entry slot at top
- Stop pillar below funnel area (`height = tower_height - entry_funnel_height`)
- Taper inner walls to 0mm at top 20%

### 3. Non-Manifold Geometry

**Symptom:** Warning "Object may not be a valid 2-manifold and may need repair"

**Causes:**
- Overlapping segments without union
- Missing overlap parameter at connections
- Floating disconnected pieces

**Solutions:**
- Wrap all components in top-level union()
- Use overlap parameter (0.1-0.2mm) at all connections
- Verify no floating pieces in visual inspection

**Note:** Usually printable if Preview (F5) looks correct, but always verify with Render (F6)

### 4. BOSL2 Primitive Conflicts

**Symptom:** Error "spin direction is parallel to anchor"

**Cause:** BOSL2 overrides standard OpenSCAD primitives with attachable versions

**Solutions:**
- Use BOSL2 primitives: `cuboid()` instead of `cube()`
- Or avoid including BOSL2 for simple models
- See OpenSCAD Library Check skill for details

## Design Validation Checklist

Before finalizing any version:

- [ ] **Preview renders without errors** (F5)
- [ ] **Console shows no warnings** (or only expected manifold warnings)
- [ ] **Full render completes** (F6) - tests geometry validity
- [ ] **Visual inspection from 4+ angles** - check for gaps, floating pieces
- [ ] **Entry path is clear and visible** from top view
- [ ] **Pillar doesn't block funnel center** - dice need rolling room
- [ ] **Walls taper properly at top** - verify from side view
- [ ] **Ramp is continuous** - no picket fence gaps
- [ ] **All parameters have units** [mm] in comments
- [ ] **Parametric ranges tested** - try min/max reasonable values

## Parametric Design Philosophy

### Core Parameters (User-Facing)
```openscad
tower_height = 150;           // Total height [mm]
pillar_diameter = 30;         // Central column [mm]
spiral_diameter = 70;         // Outer diameter [mm]
spiral_rotations = 2.5;       // Number of loops
ramp_width = 20;              // Spiral ramp width [mm]
wall_height = 15;             // Containment wall [mm]
entry_diameter = 50;          // Top opening [mm]
tray_diameter = 90;           // Catch tray [mm]
```

### Derived Parameters (Calculated)
```openscad
ramp_radius = spiral_diameter / 2;
pillar_radius = pillar_diameter / 2;
total_angle = 360 * spiral_rotations;
ramp_height = tower_height - entry_funnel_height - ramp_start_z;
```

### Parameter Relationships

**Constraints:**
- `pillar_diameter < spiral_diameter - 2*ramp_width` (ramp must fit)
- `entry_diameter < spiral_diameter` (funnel tapers inward)
- `tray_diameter > spiral_diameter` (catches bounced dice)
- `ramp_width ≥ 20mm` (accommodate dice sizes)
- `wall_height ≥ 15mm` (contain dice bounces)

**Recommendations:**
- `spiral_rotations = 2-3` (good randomization without excessive height)
- `tower_height = 100-200mm` (desktop-appropriate size)
- `ramp_thickness = 2-3mm` (structural but not wasteful)

## Future Enhancements

### Decorative Elements (v2.0+)
After v1.3 is functional, consider:
- **Brick texture** on outer tower wall
- **Crenellations** at top of funnel rim
- **Arched windows** cut into outer wall
- **Stone texture** on base tray
- **Wizard motifs** (stars, moons, runes)

**Implementation Approach:**
- Design functionally first (v1.x series)
- Export STL
- Add decorative elements in Meshmixer/Fusion 360
- Decorative features are sculptural, not parametric

### Alternative Entry Designs
- **Side door** - Entry slot at 90° angle to exit
- **Multiple entry points** - Several slots around circumference
- **Drawbridge** - Hinged entry that closes
- **Rotating entry** - Turnable top section

### Size Variants
- **Mini** (100mm tall) - Single d20 roller
- **Standard** (150mm tall) - Current design
- **Mega** (250mm tall) - Multiple dice sets simultaneously

## Technical Reference

### Render Performance
- **Preview (F5):** ~1-2 seconds for 200-segment spiral
- **Full Render (F6):** ~10-15 seconds with unions
- **Geometry:**
  - Vertices: ~6,000-7,000
  - Faces: ~3,000-3,500
- **Optimization:** Reduce `$fn` for preview, increase for final render

### Print Settings (Recommended)
- **Layer Height:** 0.2mm (balance of speed/quality)
- **Wall Lines:** 3-4 (2mm walls = 2-3 lines at 0.4mm nozzle)
- **Infill:** 15-20% (adequate rigidity)
- **Supports:** None required (designed support-free)
- **Material:** PLA, PETG, or ABS (all suitable)
- **Print Time:** ~4-6 hours at 0.2mm (varies by printer)

### File Organization
```
parametric_projects/dnd/dice-tower-corkscrew/
├── dice-tower-corkscrew-v1.0.scad    # First working version
├── dice-tower-corkscrew-v1.1.scad    # Structural improvements
├── dice-tower-corkscrew-v1.2.scad    # Self-supporting (current)
├── dice-tower-corkscrew-v1.3.scad    # Entry slot (in dev)
├── README.md                          # Project overview
├── DESIGN-NOTES.md                    # This file
└── exports/
    ├── dice-tower-v1.2.stl           # Printable files
    └── dice-tower-v1.2-preview.png   # Renders
```

## Lessons Learned

### What Worked Well
1. **Hull-based spiral generation** - Creates smooth continuous surfaces
2. **Parametric design** - Easy to adjust proportions and test variants
3. **Iterative approach** - Build, test, identify issues, refine
4. **Visual inspection** - Rotating preview catches issues early
5. **difference() for openings** - Much cleaner than conditional generation

### What Didn't Work
1. **Thin radial segments** - Created gaps instead of continuous surface
2. **Conditional segment skipping** - Complex logic with edge cases
3. **Internal support posts** - Masked underlying geometry problems
4. **Including BOSL2 unnecessarily** - Added complexity and primitive conflicts

### Key Insights
- **Segment overlap is critical** - Width must exceed angular spacing by 1.5-2x
- **Visual function matters** - Entry must be clearly visible from user's view
- **Simplicity wins** - difference() is cleaner than complex conditional logic
- **Test incrementally** - Each version should solve one problem
- **Library awareness** - Know when BOSL2 helps vs. hinders

## References

- **Repository:** https://github.com/Euda1mon1a/parametric_projects
- **OpenSCAD:** https://openscad.org/documentation.html
- **BOSL2:** https://github.com/BelfrySCAD/BOSL2/wiki
- **3D Printing Settings:** https://www.prusa3d.com/page/prusaslicer_424/

## Contact

For questions or suggestions about this design:
- **Repository Issues:** https://github.com/Euda1mon1a/parametric_projects/issues
- **Designer:** Aaron Montgomery

---

*Last Updated: 2024-12-08*
*Version: 1.2 (current), 1.3 (in development)*
