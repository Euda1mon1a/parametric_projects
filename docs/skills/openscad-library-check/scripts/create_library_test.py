#!/usr/bin/env python3
"""
OpenSCAD Library Test Generator

Creates a test file to verify BOSL2 and Round-Anything libraries are properly installed
and accessible in OpenSCAD.

Usage:
    python3 create_library_test.py
"""

import os

test_code = '''include <BOSL2/std.scad>
include <Round-Anything/polyround.scad>

// Test BOSL2
echo("BOSL2 Version: ", BOSL_VERSION);

cuboid([20, 20, 20], rounding=2);

translate([30, 0, 0])
    polyRoundExtrude([[0,0,2], [10,0,2], [10,10,2], [0,10,2]], 5);
'''

def main():
    output_path = os.path.expanduser('~/Documents/OpenSCAD/library-test.scad')

    # Ensure the directory exists
    output_dir = os.path.dirname(output_path)
    os.makedirs(output_dir, exist_ok=True)

    # Write the test file
    with open(output_path, 'w') as f:
        f.write(test_code)

    print(f"✓ Created test file: {output_path}")
    print("\nNext steps:")
    print("1. Open the file in OpenSCAD")
    print("2. Press F5 to preview")
    print("3. Check the console for BOSL2 version output")
    print("4. Verify both shapes render without errors")

if __name__ == '__main__':
    main()
