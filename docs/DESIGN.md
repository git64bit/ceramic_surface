# Batch 001 design record

## Governing relationship

For one fixed wedge and one opposing moving wedge with parallel exterior surfaces:

    vertical step = register pitch × tan(wedge angle)

Batch 001 selects the printable register pitch first:

    register pitch = 10.00 mm
    vertical step  = 0.20 mm
    tan(angle)     = 0.20 / 10.00 = 0.02
    angle          = atan(0.02) = 1.145762838°

Twenty register movements provide 4.00 mm of elevation change over 200 mm of horizontal travel.

## Load path

The broad outer rails are the intended vertical bearing surfaces. The rack and cassette resist horizontal retreat; they are not intended to carry the full vertical load on their tooth crests.

The central rack channel is 5.20 mm below the bearing plane. The moving rack projects 3.60 mm into that channel, leaving nominal clearance beneath its lowest tooth regions for cassette release.

## Rack direction

The moving wedge raises the upper surface as it moves right. Each downward rack tooth therefore uses:

- a steep holding flank toward the left;
- a shallow advancing flank toward the right.

Natural leftward retreat loads the steep flank. Rightward adjustment depresses the pawls over the shallow flank.

## Lock cassette

One transverse cassette synchronizes both rack tracks. It contains two teeth per track. The cassette is intended to receive TPU return pads or another spring system after its required force is measured.

The modeled release travel is 4.50 mm. That travel should place all pawl crests below the path of the moving rack.

## Grout

The moving wedge uses one long cavity and five transverse perforated ribs. The fixed wedge uses two cavities separated by a solid lock bulkhead. Fill and vent ports are deliberately large enough for practical grout placement and air escape, but they remain configurable.

## First review checklist

1. Confirm that all files preview and render without OpenSCAD errors.
2. Inspect the assembly at steps 0, 10, and 20.
3. Confirm that the top of the moving wedge remains horizontal.
4. Inspect the register channel in cutaway mode.
5. Inspect the lock cassette in engaged and released states.
6. Review whether 40–44 mm is an acceptable wedge-stack range.
7. Review whether 100 mm station width is appropriate for the three-point tile layout.
8. Decide whether the next batch should refine the direct-release cassette or replace it with a compound cam/yoke.

No physical load rating is claimed by this initial geometry.
