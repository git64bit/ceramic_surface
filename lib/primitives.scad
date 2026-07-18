/* Reusable geometry primitives. */

module lower_wedge_prism(length, width, low_height, rise) {
    points = [
        [0,      0,     0],
        [length, 0,     0],
        [length, width, 0],
        [0,      width, 0],
        [0,      0,     low_height],
        [length, 0,     low_height + rise],
        [length, width, low_height + rise],
        [0,      width, low_height]
    ];
    faces = [
        [0, 3, 2, 1],
        [4, 5, 6, 7],
        [0, 1, 5, 4],
        [1, 2, 6, 5],
        [2, 3, 7, 6],
        [3, 0, 4, 7]
    ];
    polyhedron(points = points, faces = faces, convexity = 10);
}

module upper_wedge_prism(length, width, bottom_low, rise, top_height) {
    points = [
        [0,      0,     bottom_low],
        [length, 0,     bottom_low + rise],
        [length, width, bottom_low + rise],
        [0,      width, bottom_low],
        [0,      0,     top_height],
        [length, 0,     top_height],
        [length, width, top_height],
        [0,      width, top_height]
    ];
    faces = [
        [0, 3, 2, 1],
        [4, 5, 6, 7],
        [0, 1, 5, 4],
        [1, 2, 6, 5],
        [2, 3, 7, 6],
        [3, 0, 4, 7]
    ];
    polyhedron(points = points, faces = faces, convexity = 10);
}

module sloped_block(length, width, bottom_low, rise, height) {
    points = [
        [0,      0,     bottom_low],
        [length, 0,     bottom_low + rise],
        [length, width, bottom_low + rise],
        [0,      width, bottom_low],
        [0,      0,     bottom_low + height],
        [length, 0,     bottom_low + rise + height],
        [length, width, bottom_low + rise + height],
        [0,      width, bottom_low + height]
    ];
    faces = [
        [0, 3, 2, 1],
        [4, 5, 6, 7],
        [0, 1, 5, 4],
        [1, 2, 6, 5],
        [2, 3, 7, 6],
        [3, 0, 4, 7]
    ];
    polyhedron(points = points, faces = faces, convexity = 10);
}

// Extrudes a polygon defined in the X/Z plane through a width in Y.
module extrude_xz(points, y_start, width) {
    translate([0, y_start + width, 0])
        rotate([90, 0, 0])
            linear_extrude(height = width, convexity = 10)
                polygon(points = points);
}

module cylinder_x(length, diameter) {
    rotate([0, 90, 0])
        cylinder(h = length, d = diameter);
}

module cylinder_y(length, diameter) {
    rotate([-90, 0, 0])
        cylinder(h = length, d = diameter);
}
