# Ceramic Surface

Parametric OpenSCAD components for a three-point ceramic tooling surface. The system stacks two nominal 11 × 23 inch, 9 mm ceramic tiles. Three identical wedge stations establish the upper tile as a level XY datum.

This archive is **Batch 002**, prepared against accepted repository commit `776083d`.

## Batch 002: first printable saddle system

Batch 002 adds the ceramic-edge saddle before the wedge mechanism is connected to the tiles. The saddle is deliberately separated into two materials:

- a reusable TPU edge saddle grips and protects the ceramic;
- a removable PLA+ datum insert passes through the TPU jaw and touches the ceramic face directly;
- the rigid insert carries the future station load, so TPU is not part of the precision height path;
- the complete saddle can be flipped for a lower-tile or upper-tile installation.

Default saddle dimensions:

- 110 mm length along the ceramic edge;
- 52 mm insertion depth;
- 9.30 mm unloaded internal gap for a nominal 9 mm tile;
- three 0.65 mm TPU grip ribs;
- 7.20 mm jaws and 9.60 mm ceramic-edge wall;
- 92 × 32 mm open-ended datum window;
- 8 mm thick rigid external datum deck;
- two 6.5 mm provisional attachment holes.

The attachment holes are deliberately generic. The future wedge, dovetail, flange or tooling adapter will attach to a replaceable PLA+ component rather than forcing the TPU saddle to change.

## First print sequence

### 1. TPU fit set

Set `part = "saddle_fit_set"`, render with **F6**, and export one STL. The STL contains three short TPU coupons:

- one notch: tight, `-0.25 mm` gap offset;
- two notches: nominal, `0.00 mm` gap offset;
- three notches: relaxed, `+0.25 mm` gap offset.

Test the coupons on the actual tile edge. The selected offset becomes `saddle_fit_offset` in `config/defaults.scad`.

A useful fit should:

- slide over the edge without tools;
- remain attached when the tile is lifted and moved;
- avoid visible bending stress in the ceramic;
- release by a deliberate straight pull rather than peeling sideways.

### 2. Full TPU saddle

Set `part = "tpu_saddle"`. The model is already rotated with its ceramic opening upward and its broad edge wall on the print bed.

### 3. PLA+ datum insert

Set `part = "pla_datum_insert"`. Print the broad external deck on the build plate. Slide the completed insert into the TPU guide rails from the open end until it contacts the far stop and the opposed TPU detents seat in the flange reliefs.

### 4. Assembly inspection

Set `part = "saddle_assembly"`. The translucent block represents the nominal tile. Verify that the orange PLA+ boss is slightly proud of the lower TPU jaw and directly touches the ceramic face.

## Batch 001 wedge geometry retained

- 10.00 mm register pitch;
- 0.20 mm vertical change per register;
- 1.14576° wedge angle;
- 20 increments / 21 selectable positions;
- 200 mm working travel;
- 360 × 100 mm moving wedge;
- 160 × 100 mm fixed wedge;
- twin moving racks and four-tooth lock cassette;
- grout cavities with fill and vent ports.

## OpenSCAD use

Open `ceramic_surface.scad`. Select a `part` in the Customizer, use **F5** for inspection, then **F6** before STL export.

## Files

- `ceramic_surface.scad` — project entry point;
- `config/defaults.scad` — dimensions, fit offsets and clearances;
- `parts/tile_saddle.scad` — TPU saddle, PLA+ insert and fit coupons;
- `parts/fixed_wedge.scad` — lower wedge shell and lock pocket;
- `parts/moving_wedge.scad` — upper wedge, racks, cavity and grout ribs;
- `parts/lock_cassette.scad` — replaceable transverse lock;
- `parts/register_coupon.scad` — tooth and clearance test pieces;
- `docs/SADDLE_TEST.md` — physical test record for the first prints;
- `docs/DESIGN.md` — dimensional design record.

No physical load rating is claimed by the current geometry. Do not fill wedge cavities with grout until the dry-printed mechanism has been evaluated.
