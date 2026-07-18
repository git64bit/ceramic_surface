# Ceramic Surface

Parametric OpenSCAD components for a three-point ceramic tooling surface. The system stacks two nominal 11 × 23 inch, 9 mm ceramic tiles. Three identical wedge stations establish the upper tile as a level XY datum.

This archive is **Batch 001**, prepared against repository initialization commit `6f218dc`.

## Batch 001 geometry

The initial station is intentionally generous rather than material-minimized:

- 10.00 mm register pitch
- 0.20 mm vertical change per register
- 1.14576° wedge angle
- 20 increments / 21 selectable positions
- 200 mm working travel
- 360 × 100 mm moving wedge
- 160 × 100 mm fixed wedge
- 40–44 mm wedge-stack height before the two ceramic tiles are counted
- twin full-length racks on the moving wedge
- broad fixed-wedge bearing rails that carry the vertical load
- one replaceable transverse lock cassette
- two pawl teeth per rack, four engaged teeth total
- grout cavities with fill and vent ports

The 0.20 mm step is created by travel along the shallow ramp. The rack teeth are 3.60 mm deep and are not limited to the adjustment step height.

## OpenSCAD use

Open `ceramic_surface.scad` in OpenSCAD. The Customizer exposes:

- `part`: assembly, individual components, or register coupon
- `position_steps`: 0 through 20
- `lock_state`: engaged or released
- `show_grout_cutaway`: inspect internal cavities
- `exploded_view`: separate the moving wedge vertically

Use **F5** for preview and **F6** before exporting STL.

## Register operation represented by this batch

The upper rack advances left-to-right. Its shallow tooth faces depress the spring-loaded lock cassette during forward movement. Attempted movement in the opposite direction loads the steep holding faces.

To disengage:

1. Nudge the moving wedge slightly farther right to unload the holding faces.
2. Press both external cassette tabs downward.
3. Hold the cassette down and retract the moving wedge to the left.

The direct press tabs are intentionally simple in Batch 001. They expose the rack, pawl, clearance, engagement depth, and release travel for inspection before a compound cam or removable release yoke is committed to the design.

## Grout construction

The fixed and moving wedge bodies contain enclosed cavities. Printed transverse ribs mechanically key the grout inside the moving wedge. The rack teeth, bearing skins, lock cassette, and sliding clearances remain printed features.

Recommended material roles for the first physical evaluation:

- PLA+ for moving wedge, fixed wedge shell, and lock cassette
- TPU for future ceramic edge saddles and lock-return springs
- non-shrink precision grout for optional wedge cores

Do not fill a part until fit and register operation have been tested as a dry printed assembly.

## Print orientation

- Fixed wedge: flat base on the build plate.
- Moving wedge: flat upper face on the build plate so the rack faces upward during printing.
- Lock cassette: body face on the build plate, pawls upward.
- Register coupon: export the coupon pieces individually if slicer separation is preferred.

A 0.4 mm nozzle is assumed. Critical walls and tooth widths are substantially larger than one extrusion line. Final perimeter count, layer height, infill, temperature, and material settings remain printer-specific.

## Files

- `ceramic_surface.scad` — project entry point
- `config/defaults.scad` — all primary dimensions and clearances
- `lib/primitives.scad` — wedge and extrusion primitives
- `lib/registers.scad` — rack and pawl profiles
- `parts/fixed_wedge.scad` — lower wedge shell and lock pocket
- `parts/moving_wedge.scad` — upper wedge, racks, cavity, and grout ribs
- `parts/lock_cassette.scad` — replaceable transverse lock
- `parts/register_coupon.scad` — short tooth and clearance test pieces
- `docs/DESIGN.md` — dimensional and test notes

## Current limitations

Batch 001 does not yet include the TPU ceramic saddles, rigid tile datum inserts, carriage guidance, the three-station tile layout, or tooling attachments. Those should be added only after the register mechanism and the selected stack height are reviewed.
