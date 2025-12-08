# Parametric Projects

A collection of parametric CAD designs and 3D printable models, primarily built with OpenSCAD.

## Philosophy

Parametric design enables customizable, reproducible, and maintainable models. Rather than static STL files, these projects are defined by code with configurable parameters—making it easy to adapt designs for different sizes, materials, or use cases.

## Repository Structure

```
parametric_projects/
├── gridfinity/           # Gridfinity-compatible organizers and storage
├── workshop/             # Workshop organization and tool holders
├── dnd/                  # Dungeons & Dragons themed items
├── medical/              # Medical and educational tools
├── libraries/            # Reusable OpenSCAD libraries and modules
├── templates/            # Project templates and scaffolding
└── docs/                 # Documentation and guides
```

## Projects

### Active Projects
*Projects currently in development or iteration*

- **[Corkscrew Wizard Tower Dice Tower](dnd/dice-tower-corkscrew/)** (v1.3 in development)
  - Helical spiral dice tower with integrated catch tray
  - Support-free parametric design
  - See [Design Notes](dnd/dice-tower-corkscrew/DESIGN-NOTES.md) for technical details

### Completed Projects
*Stable, tested designs ready for use*

- Coming soon...

## Development Environment

### Tools
- **OpenSCAD** 2025.03.16 - Primary CAD software
- **BOSL2** 2.0.716 - OpenSCAD library for advanced features
- **Round-Anything** - Filleting and rounding utilities

### Library Verification
Before starting work, verify libraries are accessible:
```bash
# Generate and run the library test file
python3 docs/skills/openscad-library-check/scripts/create_library_test.py
open ~/Documents/OpenSCAD/library-test.scad
```
Press F5 in OpenSCAD to confirm BOSL2 and Round-Anything load correctly.

See the [OpenSCAD Library Check Skill](docs/skills/openscad-library-check/SKILL.md) for troubleshooting common library issues.

## Project Template

Each project should include:
```
project-name/
├── project-name.scad     # Main parametric model
├── README.md             # Project-specific documentation
├── parameters.json       # Default parameter sets
├── images/               # Renders and photos
│   ├── render.png
│   └── printed.jpg
└── exports/              # Pre-generated STL files
    └── project-name.stl
```

### Project README Template
```markdown
# Project Name

Brief description of what this is and why it exists.

## Parameters

| Parameter | Default | Description |
|-----------|---------|-------------|
| width     | 42      | Overall width in mm |
| height    | 10      | Overall height in mm |

## Printing

- **Material**: PLA/PETG/ABS
- **Layer Height**: 0.2mm
- **Infill**: 20%
- **Supports**: Yes/No

## Assembly

Steps if applicable...

## Images

![Render](images/render.png)
![Printed](images/printed.jpg)
```

## Skills & Documentation

The `docs/skills/` directory contains reusable knowledge and troubleshooting guides:

- **[OpenSCAD Library Check](docs/skills/openscad-library-check/SKILL.md)** - Verify BOSL2 and Round-Anything installation, troubleshoot common issues, best practices for spiral generation and geometry

## Design Principles

1. **Parametric First** - All dimensions should be variables, not magic numbers
2. **Documented Parameters** - Include comments explaining what each parameter controls
3. **Printability** - Designs should be printable without supports when possible
4. **Modularity** - Break complex designs into reusable modules
5. **Version Control** - Commit working versions before major changes

## Printing Notes

### General Settings
- **Printer**: [Your printer model]
- **Slicer**: [Your slicer]
- **Typical Settings**: 0.2mm layer height, 20% infill

### Material-Specific Notes
- **PLA**: Easy printing, good for prototypes
- **PETG**: Better strength and temperature resistance
- **ABS**: Requires enclosure, best mechanical properties

## Contributing

This is a personal repository, but design ideas and improvements are welcome through issues.

## License

[Choose appropriate license - MIT, CC-BY, GPL, etc.]

## Acknowledgments

- **BOSL2** by BelfrySCAD - Advanced OpenSCAD library
- **Round-Anything** by Irev-Dev - Filleting utilities
- **Gridfinity** by Zack Freedman - Storage system standard

---

**Status**: 🚀 Active development - First project (Dice Tower) in progress
**Last Updated**: 2024-12-08
