/* Lower fixed wedge with bearing rails, register channel and lock pocket. */

module fixed_grout_chamber(x_start, chamber_length) {
    cavity_y = shell_wall;
    cavity_width = wedge_width - 2 * shell_wall;
    cavity_low_height = fixed_base_height
                      + wedge_slope * x_start
                      - fixed_bottom_skin
                      - fixed_top_skin;

    if (chamber_length > 4 && cavity_low_height > 4) {
        translate([x_start, cavity_y, fixed_bottom_skin])
            lower_wedge_prism(
                chamber_length,
                cavity_width,
                cavity_low_height,
                wedge_slope * chamber_length
            );
    }
}

module fixed_grout_cavities() {
    bulkhead_half = lock_body_length / 2 + 8;
    first_start = shell_wall;
    first_length = lock_x - bulkhead_half - first_start;
    second_start = lock_x + bulkhead_half;
    second_length = fixed_length - shell_wall - second_start;

    fixed_grout_chamber(first_start, first_length);
    fixed_grout_chamber(second_start, second_length);
}

module fixed_grout_ports() {
    first_z = fixed_base_height / 2;
    second_z = fixed_base_height
             + wedge_slope * fixed_length
             - fixed_top_skin - 3;

    translate([-1, wedge_width / 2, first_z])
        cylinder_x(shell_wall + 4, grout_fill_diameter);

    translate([fixed_length - shell_wall - 2,
               wedge_width / 2,
               second_z])
        cylinder_x(shell_wall + 4, grout_fill_diameter);

    translate([-1, wedge_width / 2 - 12, first_z + 5])
        cylinder_x(shell_wall + 4, grout_vent_diameter);

    translate([fixed_length - shell_wall - 2,
               wedge_width / 2 - 12,
               second_z + 2])
        cylinder_x(shell_wall + 4, grout_vent_diameter);
}

module fixed_register_channel() {
    translate([0, central_channel_y, 0])
        sloped_block(
            fixed_length,
            central_channel_width,
            fixed_base_height - central_channel_depth,
            wedge_slope * fixed_length,
            central_channel_depth + 2
        );
}

module fixed_lock_pockets() {
    body_x_start = lock_x - lock_body_length / 2 - sliding_clearance;
    body_length = lock_body_length + 2 * sliding_clearance;
    pocket_bottom = 3.0;
    body_top = fixed_base_height
             + wedge_slope * body_x_start
             - central_channel_depth
             + sliding_clearance;

    // Main cassette pocket beneath the central register channel.
    translate([body_x_start,
               lock_body_y - sliding_clearance,
               0])
        sloped_block(
            body_length,
            lock_body_width + 2 * sliding_clearance,
            pocket_bottom,
            wedge_slope * body_length,
            body_top - pocket_bottom
        );

    // Narrow side-arm slot through both bearing-rail walls.
    arm_x_start = lock_x - lock_side_arm_length / 2 - sliding_clearance;
    arm_length = lock_side_arm_length + 2 * sliding_clearance;
    translate([arm_x_start,
               -general_clearance,
               0])
        sloped_block(
            arm_length,
            wedge_width + 2 * general_clearance,
            pocket_bottom,
            wedge_slope * arm_length,
            body_top - pocket_bottom
        );
}

module fixed_wedge(show_cutaway = false) {
    difference() {
        lower_wedge_prism(
            fixed_length,
            wedge_width,
            fixed_base_height,
            wedge_slope * fixed_length
        );

        fixed_register_channel();
        fixed_grout_cavities();
        fixed_grout_ports();
        fixed_lock_pockets();

        if (show_cutaway) {
            translate([-2, wedge_width / 2, -2])
                cube([fixed_length + 4,
                      wedge_width / 2 + 4,
                      fixed_base_height
                      + wedge_slope * fixed_length + 6]);
        }
    }
}
