# Batch 002 design record

## Wedge governing relationship

For one fixed wedge and one opposing moving wedge with parallel exterior surfaces:

    vertical step = register pitch × tan(wedge angle)

The retained wedge geometry selects the printable register pitch first:

    register pitch = 10.00 mm
    vertical step  = 0.20 mm
    tan(angle)     = 0.20 / 10.00 = 0.02
    angle          = atan(0.02) = 1.145762838°

Twenty register movements provide 4.00 mm of elevation change over 200 mm of horizontal travel.

## Saddle design objective

The TPU saddle and PLA+ datum insert have separate responsibilities.

### TPU component

- wraps and protects the ceramic edge;
- supplies compliant grip through three broad ribs;
- accommodates normal tile-thickness and print variation;
- retains the rigid insert during handling;
- includes relief at both ceramic edge radii.

### PLA+ component

- passes through a window in the TPU jaw;
- directly contacts the ceramic face;
- supplies the rigid external datum deck;
- prevents long-term TPU compression from defining station height;
- can be replaced later by dovetail, flange or other station adapters.

The TPU guide lips retain the insert but are not intended to carry the vertical station load. The load path is ceramic face → PLA+ contact boss → PLA+ external deck → future wedge adapter.

## Fit strategy

The nominal body gap is 9.30 mm for a 9.00 mm tile. The rigid insert projects 0.15 mm into the gap and the opposing TPU ribs project 0.65 mm. The nominal effective rib gap is therefore:

    9.30 - 0.15 - 0.65 = 8.50 mm

This produces 0.50 mm total interference against a nominal 9.00 mm tile. The deformation is intentionally concentrated in the TPU rib profile rather than the full jaw.

The fit coupon set changes the unloaded body gap by ±0.25 mm. Physical results, not the nominal tile specification, determine the final `saddle_fit_offset`.

## Insert interface

The insert slides parallel to the ceramic edge. The datum window opens at the insertion end so the ceramic-contact boss can slide into place. A closed far stop establishes repeatable location. Opposed TPU detents seat in shallow flange reliefs to retain the unloaded insert during handling. The insert includes a pull tab for removal and two provisional 6.5 mm holes in the rigid deck.

The holes are not the final attachment decision. They allow temporary fastening and leave the TPU saddle unchanged while wedge attachment geometry evolves.

## Wedge load path retained

The broad outer wedge rails are the intended vertical bearing surfaces. The rack and cassette resist horizontal retreat; they are not intended to carry the full vertical load on their tooth crests.

The central rack channel is 5.20 mm below the bearing plane. The moving rack projects 3.60 mm into that channel, leaving nominal clearance beneath its lowest tooth regions for cassette release.

## Next design dependency

The wedge-to-saddle adapter should not be committed until the user reports:

- measured tile thickness;
- selected saddle fit coupon;
- TPU hardness and print settings;
- whether the full saddle remains stable during normal tile handling;
- whether the PLA+ datum deck rocks against either tile face.
