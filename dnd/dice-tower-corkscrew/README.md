# Corkscrew Wizard Tower Dice Tower

A parametric 3D-printable dice tower featuring a helical spiral ramp around a central pillar with an integrated catch tray. Designed for tabletop gaming (D&D, board games).

![Status](https://img.shields.io/badge/status-in_development-yellow)
![Version](https://img.shields.io/badge/version-1.2-blue)

## Features

- **Helical spiral ramp** - Dice tumble down 2.5 rotations for good randomization
- **Integrated catch tray** - Self-contained design, no separate parts
- **Open funnel entry** - Clear entry point visible from top
- **Support-free printing** - Designed to print without internal supports
- **Fully parametric** - Easy to customize size and proportions

## Parameters

| Parameter | Default | Description |
|-----------|---------|-------------|
| tower_height | 150mm | Total height including tray |
| pillar_diameter | 30mm | Central column diameter |
| spiral_diameter | 70mm | Outer spiral diameter |
| spiral_rotations | 2.5 | Number of complete loops |
| ramp_width | 20mm | Width of spiral ramp |
| wall_height | 15mm | Containment wall height |
| entry_diameter | 50mm | Top funnel opening |
| tray_diameter | 90mm | Catch tray diameter |

## Printing

### Recommended Settings
- **Material**: PLA, PETG, or ABS
- **Layer Height**: 0.2mm
- **Wall Lines**: 3-4 (2mm walls)
- **Infill**: 15-20%
- **Supports**: None required
- **Print Time**: ~4-6 hours

### Notes
- Designed for support-free printing with proper overhang angles
- May show manifold warnings but prints successfully if preview looks correct
- Test render (F6) before exporting to verify geometry

## Assembly

No assembly required - prints as a single piece.

## Files

- `DESIGN-NOTES.md` - Comprehensive design documentation and lessons learned
- `dice-tower-corkscrew-v1.2.scad` - Current stable version
- `dice-tower-corkscrew-v1.3.scad` - Development version (entry slot improvements)
- `exports/` - Pre-generated STL files

## Version History

- **v1.3** (In Development) - Entry slot improvements
- **v1.2** (Current) - Self-supporting design with tapered funnel
- **v1.1** - Structural improvements, unified spiral
- **v1.0** - Initial hull-based spiral implementation

## Known Issues

- v1.2: No clear entry point for dice (continuous closed loop)
- v1.3 (WIP): Resolving BOSL2 primitive conflicts

See `DESIGN-NOTES.md` for detailed technical information and troubleshooting.

## Future Enhancements

- Decorative wizard theme elements (brick texture, windows, crenellations)
- Alternative entry designs (side door, drawbridge)
- Size variants (mini, standard, mega)

## Design Philosophy

This project demonstrates:
- Hull-based spiral generation for smooth surfaces
- Parametric design for easy customization
- Support-free printing techniques
- Iterative development with version control

## References

- [Design Notes](DESIGN-NOTES.md) - In-depth technical documentation
- [OpenSCAD Library Check Skill](../../docs/skills/openscad-library-check/SKILL.md) - Library troubleshooting
- [BOSL2 Documentation](https://github.com/BelfrySCAD/BOSL2/wiki)

## License

[To be determined]

---

**Author:** Aaron Montgomery
**Repository:** https://github.com/Euda1mon1a/parametric_projects
**Last Updated:** 2024-12-08
