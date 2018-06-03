include <MCAD/units.scad>;
include <common.scad>

difference() {
  rounded_box([ useful_size.x, useful_size.y, 0 ], wall_size, round_radius);
  at_four_corners([ [ 0, 0 ], useful_size ]) {
    translate([ (cover_screw_hole_diameter + 0.5) / 2 , (cover_screw_hole_diameter + 0.5) / 2 , -wall_size - epsilon ])
      cylinder(d = cover_screw_hole_diameter + 0.5, h = wall_size + 2 * epsilon);
  }
}
