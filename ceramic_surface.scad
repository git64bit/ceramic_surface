/*
  Ceramic Surface
  Configurable three-point precision wedge station
  Batch 002, based on repository commit 776083d
*/

include <config/defaults.scad>
include <lib/primitives.scad>
include <lib/registers.scad>
include <parts/moving_wedge.scad>
include <parts/lock_cassette.scad>
include <parts/fixed_wedge.scad>
include <parts/register_coupon.scad>
include <parts/tile_saddle.scad>

module assembly_scene() {
    released = lock_state == "released";
    explode_z = exploded_view ? 22 : 0;

    color([0.70, 0.70, 0.72])
        fixed_wedge(show_grout_cutaway);

    color([0.88, 0.44, 0.18])
        lock_cassette(released);

    color([0.28, 0.46, 0.70])
        translate([moving_x, 0, moving_z + explode_z])
            moving_wedge(show_grout_cutaway);

    echo(str("Wedge angle: ", wedge_angle, " degrees"));
    echo(str("Selected step: ", selected_step));
    echo(str("Selected travel: ", selected_travel, " mm"));
    echo(str("Selected stack height: ",
             minimum_stack_height + selected_step * vertical_step,
             " mm"));
    echo(str("Adjustment range: ", minimum_stack_height,
             " to ", maximum_stack_height, " mm"));
}

if (part == "saddle_assembly") {
    saddle_assembly(show_saddle_tile);
} else if (part == "tpu_saddle") {
    tpu_saddle_printable();
} else if (part == "pla_datum_insert") {
    pla_datum_insert_local();
} else if (part == "saddle_fit_set") {
    saddle_fit_set_printable();
} else if (part == "assembly") {
    assembly_scene();
} else if (part == "fixed_wedge") {
    fixed_wedge(show_grout_cutaway);
} else if (part == "moving_wedge") {
    moving_wedge(show_grout_cutaway);
} else if (part == "lock_cassette") {
    lock_cassette_printable();
} else if (part == "register_coupon") {
    register_coupon();
} else {
    assert(false, str("Unknown part selection: ", part));
}
