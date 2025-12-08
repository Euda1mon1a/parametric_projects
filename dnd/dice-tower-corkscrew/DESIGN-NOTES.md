# Dice Tower Design Notes

**Project:** Corkscrew Wizard Tower Dice Tower
**Current Version:** v1.4 (Stable Functional Prototype)
**Date:** 2024-12-08

## Overview

This document tracks the development journey of the parametric dice tower, detailing the technical challenges encountered, solutions implemented, and the evolution of the design architecture.

## Version History & Key Learnings

### v1.0 - v1.2: The "Manual" Era
**Approach:** Attempted to construct the spiral using manual `hull()` operations between rotated segments.
**Challenges:**
- Resulted in non-manifold geometry ("picket fence" effect with gaps).
- Required internal support posts to mask geometry errors, violating the support-free goal.
- Complex conditional logic needed for tapering walls.
**Lesson:** Don't reinvent the wheel. Manual spiral generation is fragile and error-prone in OpenSCAD.

### v1.3: The "Boolean Cut" Failure
**Approach:** Tried to create an entry point by punching a `difference()` cut through a solid funnel floor.
**Challenges:**
- Encountered severe conflicts when mixing BOSL2 primitives with standard OpenSCAD shapes within boolean operations.
- The resulting path was unreliable; dice had to bounce on a flat floor to find the hole.
**Lesson:** Mixing library primitive types can cause unexpected errors. Designing "barriers and holes" is inferior to designing continuous paths.

### v1.4: The Functional Breakthrough (Current Stable)
**Approach:** Switched to professional libraries and a new architectural paradigm.
- **Library Usage:** Adopted BOSL2's `spiral_sweep()` for guaranteed manifold helical geometry and Round-Anything's `polyRound()` for smooth 2D profiles.
- **Architecture:** Implemented a "Continuous Gravity-Fed Path." The funnel is a hollow shell with NO floor. The spiral ramp extends physically UP into the funnel area. Dice fall through the hollow funnel directly onto the start of the ramp.
**Outcome:** A robust, printable, jam-free, fully parametric model.
**Lesson:** Professional tools (BOSL2) and smart architecture (continuous path) yield vastly superior results with less code.

### v1.5 (Rejected): The False Start on Polish
**Approach:** Attempted quick aesthetic fixes by extending the central pillar to the very top and adding a basic internal fillet.
**Outcome:** Rejected during design review. While better, it still looked like "raw geometry" rather than a designed product. It highlighted the gap between a functional prototype and professional CAD quality.
**Lesson:** "It renders" is not the final standard. True professional quality requires intentional design of every edge, transition, and termination.

### v1.6 (Proposed): Professional Refinements
**Status:** [Planned defined in PROPOSAL document](PROPOSAL-v1.6-professional-refinements.md).
**Goal:** Bridge the gap identified in the v1.5 rejection.
**Scope:** Add substantial fillets, rounded funnel lips, chamfered pillar caps, and smooth ramp runouts to achieve a finished, injection-molded aesthetic.

## References

- [OpenSCAD Library Check Skill](../../docs/skills/openscad-library-check/SKILL.md)
- [BOSL2 Documentation](https://github.com/BelfrySCAD/BOSL2/wiki)
