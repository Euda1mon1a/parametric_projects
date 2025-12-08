# Proposal: v1.6 Professional CAD Refinements

**Current Status:** v1.4 is a functional prototype. It works mechanically and prints correctly.
**Goal of v1.6:** Transform the model from raw geometric shapes into a professional-grade designed product.

## The "Human Standard" Gap

A design review concluded that v1.4, while functional, does not meet the aesthetic and ergonomic standards of a professional injection-molded or high-end consumer product. It looks like "math shapes" rather than designed parts.

Key deficiencies identified:
* Sharp, mathematically perfect edges that would be uncomfortable to touch.
* Raw cylinder terminations that look unfinished.
* Abrupt 90° intersections between major components (pillar to base).
* A sudden "drop-off" at the end of the ramp.

## Proposed Refinements

This proposal outlines four key areas for improvement to bridge this gap.

### 1. Funnel Lip & Thickness
**Problem:** The current funnel is a thin shell with a sharp top edge. It looks precarious.
**Solution:**
* Increase wall thickness substantially for a robust look.
* Add a prominent, fully rounded lip to the top rim. This improves aesthetics, structural rigidity, and tactile feel.

### 2. Pillar Cap Finishing
**Problem:** The central pillar ends abruptly inside the funnel as a flat, sharp-edged circle.
**Solution:** Implement a finished "cap."
* *Style A (Chamfer):* A clean, angled bevel at the top edge.
* *Style B (Dome):* A smooth, rounded hemispherical top.

### 3. Base Transition Fillets
**Problem:** The central pillar intersects the catch tray floor at a sharp 90° angle. This looks cheap and is a structural stress concentrator.
**Solution:** Add a generous radius fillet at the base of the pillar, creating a smooth, sweeping transition into the tray floor.

### 4. Ramp Runout Blend (Advanced)
**Problem:** The spiral ramp ends abruptly, stepping down onto the tray floor.
**Solution:** Design a "runout." The final section of the ramp should flatten its angle and taper its thickness, blending tangentially into the tray floor so dice glide out smoothly rather than dropping off a ledge.

## Implementation Impact

Implementing these changes moves the project from intermediate OpenSCAD usage to advanced. It will require:
* Mastery of the `minkowski()` function for rounding complex unions.
* Precision use of `rotate_extrude()` for custom profiles like lips and fillets.
* Complex boolean strategies to ensure fillets don't interfere with functional paths.

**Estimated Effort:** 8-12 hours of additional development time.
**Decision:** Given the effort required, v1.4 will remain the stable release for testing, with v1.6 reserved as a future project for production-quality requirements.
