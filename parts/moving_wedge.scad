/* Upper moving wedge with twin full-length register racks. */

module moving_grout_cavity() {
    cavity_x = shell_wall;
    cavity_length = moving_length - 2 * shell_wall;
    cavity_y = shell_wall;
    cavity_width = wedge_width - 2 * shell_wall;
    cavity_bottom = wedge_slope * cavity_x + moving_bottom_skin;
    cavity_top = moving_top_height - moving_top_skin;

    translate([cavity_x, cavity_y, 0])
        upper_wedge_prism(
            cavity_length,
            cavity_width,
            cavity_bottom,
            wedge_slope * cavity_length,
            cavity_top
        );
}

module moving_grout_ports() {
    fill_z = moving_top_height / 2;
    translate([-1, wedge_width / 2, fill_z])
        cylinder_x(shell_wall + 3, grout_fill_diameter);

    vent_z = moving_top_height - moving_top_skin - 2;
    translate([moving_length - shell_wall - 2,
               wedge_width / 2,
               vent_z])
        cylinder_x(shell_wall + 4, grout_vent_diameter);
}

module moving_internal_ribs() {
    rib_positions = [60, 120, 180, 240, 300];
    for (rib_x = rib_positions) {
        rib_bottom = wedge_slope * rib_x + moving_bottom_skin;
        rib_height = moving_top_height - moving_top_skin - rib_bottom;
        if (rib_height > 4) {
            difference() {
                translate([rib_x - internal_rib_thickness / 2,
                           shell_wall,
                           rib_bottom])
                    cube([internal_rib_thickness,
                          wedge_width - 2 * shell_wall,
                          rib_height]);
                translate([rib_x - internal_rib_thickness,
                           wedge_width / 2,
                           rib_bottom + rib_height / 2])
                    cylinder_x(
                        internal_rib_thickness * 3,
                        min(18, rib_height - 2)
                    );
            }
        }
    }
}

module moving_wedge(show_cutaway = false) {
    difference() {
        union() {
            difference() {
                upper_wedge_prism(
                    moving_length,
                    wedge_width,
                    0,
                    wedge_slope * moving_length,
                    moving_top_height
                );
                moving_grout_cavity();
                moving_grout_ports();
            }

            moving_internal_ribs();

            for (rack_y = rack_y_positions) {
                downward_register_rack(
                    moving_length,
                    rack_y,
                    rack_width,
                    register_pitch,
                    rack_margin,
                    rack_depth,
                    wedge_slope,
                    rack_crest_width,
                    rack_holding_run,
                    rack_root_chamfer
                );
            }
        }

        if (show_cutaway) {
            translate([-2, wedge_width / 2, -2])
                cube([moving_length + 4,
                      wedge_width / 2 + 4,
                      moving_top_height + 8]);
        }
    }
}
