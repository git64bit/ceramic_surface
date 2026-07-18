/* Ratchet rack and pawl profiles. */

function ramp_z(x, slope) = x * slope;

module downward_register_tooth(
    x_start,
    y_start,
    width,
    pitch,
    depth,
    slope,
    crest_width,
    holding_run,
    root_chamfer
) {
    x_end = x_start + pitch;
    crest_start = x_start + holding_run;
    crest_end = crest_start + crest_width;
    points = [
        [x_start, ramp_z(x_start, slope)],
        [x_end, ramp_z(x_end, slope)],
        [x_end - root_chamfer,
         ramp_z(x_end - root_chamfer, slope) - root_chamfer / 2],
        [crest_end, ramp_z(crest_end, slope) - depth],
        [crest_start, ramp_z(crest_start, slope) - depth],
        [x_start + root_chamfer,
         ramp_z(x_start + root_chamfer, slope) - 1.20]
    ];
    extrude_xz(points, y_start, width);
}

module downward_register_rack(
    length,
    y_start,
    width,
    pitch,
    margin,
    depth,
    slope,
    crest_width,
    holding_run,
    root_chamfer
) {
    tooth_count = floor((length - 2 * margin) / pitch);
    for (index = [0 : tooth_count - 1]) {
        downward_register_tooth(
            margin + index * pitch,
            y_start,
            width,
            pitch,
            depth,
            slope,
            crest_width,
            holding_run,
            root_chamfer
        );
    }
}

module upward_pawl_tooth(
    x_start,
    y_start,
    width,
    tooth_width,
    height,
    crest_width,
    holding_run
) {
    crest_start = x_start + holding_run;
    crest_end = crest_start + crest_width;
    x_end = x_start + tooth_width;
    points = [
        [x_start, 0],
        [x_end, 0],
        [x_end - 0.50, 0.70],
        [crest_end, height],
        [crest_start, height],
        [x_start + 0.45, 1.00]
    ];
    extrude_xz(points, y_start, width);
}
