# Corkscrew Wizard Tower Dice Tower

A parametric 3D-printable dice tower featuring a helical spiral ramp around a central pillar with an integrated catch tray. Designed for tabletop gaming.

![Status](https://img.shields.io/badge/status-functional_prototype-green)
![Version](https://img.shields.io/badge/version-1.4-blue)

**Current Status:** v1.4 is functionally complete, manifold, and ready for testing. It relies on gravity-fed geometry rather than complex boolean cuts. A proposal for professional-grade aesthetic refinements (v1.6) has been developed but not yet implemented.

## Features

- **Helical spiral ramp** - Dice tumble down 2.5 rotations for good randomization.
- **Gravity-Fed Continuous Path** - Innovative architecture where the ramp extends up into a hollow funnel for reliable, jam-free feeding.
- **Guaranteed Manifold** - Uses BOSL2's `spiral_sweep` for robust geometry.
- **Integrated catch tray** - Self-contained design.
- **Support-free printing** - Designed with overhangs suitable for FDM printing without supports.
- **Fully parametric** - Easily customize dimensions in OpenSCAD.

## Documentation

- **[Design Notes](DESIGN-NOTES.md):** Comprehensive history of the project, including failed attempts and lessons learned.
- **[Architecture: Continuous Path](ARCHITECTURE-continuous-path-v1.4.md):** Technical explanation of the gravity-fed design breakthrough in v1.4.
- **[Proposal: Professional Refinements](PROPOSAL-v1.6-professional-refinements.md):** A detailed plan for v1.6 to elevate the design from "functional prototype" to "professional product quality."

## Usage

1.  Open `dice-tower-corkscrew-v1.4.scad` in OpenSCAD.
2.  Ensure you have the [BOSL2](https://github.com/BelfrySCAD/BOSL2) and [Round-Anything](https://github.com/Irev-Dev/Round-Anything) libraries installed.
3.  Adjust parameters in the editor window if desired.
4.  Press F5 for preview, F6 for full render.
5.  Export as STL.

## Printing

- **Material**: PLA, PETG, or ABS
- **Layer Height**: 0.2mm recommended
- **Infill**: 15-20%
- **Supports**: None required

---
**Author:** Aaron Montgomery
**License:** CC-BY-4.0
