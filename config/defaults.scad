/*
  Ceramic Surface - Batch 001 defaults
  Units: millimetres
*/

// ---------- OpenSCAD Customizer ----------
part = "assembly"; // [assembly,fixed_wedge,moving_wedge,lock_cassette,register_coupon]
position_steps = 8; // [0:1:20]
lock_state = "engaged"; // [engaged,released]
show_grout_cutaway = false;
exploded_view = false;

// ---------- Precision adjustment ----------
vertical_step = 0.20;
register_pitch = 10.00;
working_steps = 20;
working_travel = register_pitch * working_steps;
wedge_slope = vertical_step / register_pitch;
wedge_angle = atan(wedge_slope);

// ---------- Wedge envelope ----------
wedge_width = 100;
moving_length = 360;
fixed_length = 160;
fixed_base_height = 18;
moving_top_height = 26;

// The moving wedge begins 200 mm left of the fixed wedge at step 0.
moving_x_at_step_zero = -working_travel;

// ---------- Bearing and register layout ----------
bearing_rail_width = 24;
central_channel_y = bearing_rail_width;
central_channel_width = wedge_width - 2 * bearing_rail_width;
central_channel_depth = 5.20;

rack_width = 14;
rack_y_positions = [30, 56];
rack_margin = 15;
rack_depth = 3.60;
rack_crest_width = 2.20;
rack_holding_run = 0.70;
rack_root_chamfer = 0.60;

// ---------- Lock cassette ----------
lock_x = fixed_length / 2;
lock_body_length = 30;
lock_body_y = 26;
lock_body_width = 48;
lock_body_height = 5.50;
lock_body_top_clearance = 0.60;
lock_release_travel = 4.50;
lock_side_arm_length = 16;
lock_tab_projection = 10;
lock_tab_length = 24;
lock_tab_height = 5.50;
pawl_pairs = 2;
pawl_height = 3.00;
pawl_crest_width = 2.00;
pawl_holding_run = 0.80;
pawl_clearance = 0.35;

// ---------- Grout shell ----------
shell_wall = 5;
fixed_bottom_skin = 5;
fixed_top_skin = 7;
moving_bottom_skin = 6;
moving_top_skin = 6;
grout_fill_diameter = 14;
grout_vent_diameter = 4;
internal_rib_thickness = 4;

// ---------- Manufacturing clearances ----------
general_clearance = 0.40;
sliding_clearance = 0.55;

// ---------- Preview ----------
preview_tile_thickness = 9;
preview_tile_length = 584.2; // 23 inches
preview_tile_width = 279.4;  // 11 inches
$fn = 48;

// ---------- Derived values ----------
selected_step = min(max(position_steps, 0), working_steps);
selected_travel = selected_step * register_pitch;
moving_x = moving_x_at_step_zero + selected_travel;
moving_z = fixed_base_height + wedge_slope * moving_x;
minimum_stack_height = fixed_base_height + moving_top_height
                     + wedge_slope * moving_x_at_step_zero;
maximum_stack_height = minimum_stack_height
                     + working_steps * vertical_step;

assert(register_pitch > 0, "register_pitch must be positive");
assert(vertical_step > 0, "vertical_step must be positive");
assert(moving_length >= working_travel + fixed_length,
       "moving_length must cover full travel plus fixed-wedge overlap");
assert(central_channel_width > 2 * rack_width,
       "central channel is too narrow for both register racks");
assert(moving_top_height > wedge_slope * moving_length + moving_bottom_skin,
       "moving wedge becomes too thin at its narrow end");
