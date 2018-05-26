
include <MCAD/units.scad>;
use <OpenSCAD-Pattern-Filling/pattern.scad>;

$fn = 36;
useful_size = [ 14 * cm, 17 * cm, 9 * cm ];
wall_size = 3 * mm;
round_radius = 3 * mm;

// Vent Parameters
vent_alveolus_size = 8 * mm;
vent_margin = 1 * mm;
vent_xstep = cos(30) * (vent_margin + sqrt(3) * vent_alveolus_size / 2);
vent_ystep = sin(30) * (vent_margin + sqrt(3) * vent_alveolus_size / 2);

module box(useful_size, wall_size) {
  difference() {
    translate([ -wall_size, -wall_size, -wall_size ])
      cube([ useful_size.x + 2 * wall_size, useful_size.y + 2 * wall_size, useful_size.z + wall_size ]);
    translate([ 0, 0, epsilon])
      cube([ useful_size.x, useful_size.y, useful_size.z ]);
  }
}

module rounded_corner(round_radius, length) {
  difference() {
    cube([ round_radius, round_radius, length ]);
    translate([ round_radius, round_radius, -epsilon ])
      cylinder(r=round_radius, h=length + 2 * epsilon);
  }
}

module at_four_corners(box) {
  translate([ box[0].x, box[0].y, 0 ])
      children();
  translate([ box[1].x, box[0].y, 0 ])
    rotate([ 0, 0, 90 ])
      children();
  translate([ box[1].x, box[1].y, 0 ])
    rotate([ 0, 0, 180 ])
      children();
  translate([ box[0].x, box[1].y, 0 ])
    rotate([ 0, 0, 270 ])
      children();
}

module rounded_box(useful_size, wall_size, round_radius) {
  difference() {
    union() {
      box(useful_size, wall_size);
      at_four_corners([ [ 0, 0 ], useful_size ])
        rounded_corner(round_radius, useful_size.z);
    }
    at_four_corners([ [ -wall_size, -wall_size ], useful_size + [ wall_size, wall_size ] ])
      translate([ -epsilon, -epsilon, -wall_size - epsilon ])
        rounded_corner(round_radius, useful_size.z + wall_size + 2 * epsilon);
  }
}

difference() {
  rounded_box(useful_size, wall_size, round_radius);

  // Main socket
  socket_position = [ 0, -133 * mm, 20 * mm ];
  socket_dimension = [ wall_size + 2 * epsilon, 31 * mm, 22 * mm ];
  socket_mounting_holes_diameter = 2.5 * mm;
  socket_mounting_holes_position = [ 0, - 4.5 * mm, socket_dimension.z / 2 ];
  translate([ -wall_size - epsilon + socket_position.x, useful_size.y + socket_position.y, socket_position.z ]) {
    cube(socket_dimension);
    translate(socket_mounting_holes_position)
      rotate([ 0, 90, 0 ])
        cylinder(d = socket_mounting_holes_diameter, h = wall_size + 2 * epsilon);
    translate([ socket_mounting_holes_position.x, socket_dimension.y - socket_mounting_holes_position.y, socket_mounting_holes_position.z ] )
      rotate([ 0, 90, 0 ])
        cylinder(d = socket_mounting_holes_diameter, h = wall_size + 2 * epsilon);
  }

  // Main switch
  switch_position = [ 0, -127 * mm, 60 * mm ];
  switch_dimension = [ wall_size + 2 * epsilon, 19 * mm, 13 * mm ];
  translate([ -wall_size - epsilon + switch_position.x, useful_size.y + switch_position.y, switch_position.z ]) {
    cube(switch_dimension);
  }

  // Fan vent
  fan_vent_size = [ 76.5 * mm, 76.5 * mm, wall_size + 2 * epsilon ];
  fan_vent_position = [ 10 * mm, 5 * mm ];
  fan_vent_diameter = 90 * mm;
  fan_vent_mounting_hole_position = [ 36 * mm, 36 * mm ];
  fan_vent_mounting_hole_diameter = 5.5 * mm;
  translate([ -wall_size - epsilon, useful_size.y - fan_vent_position.x - fan_vent_size.x / 2, fan_vent_position.y + fan_vent_size.y / 2 ])
  rotate([ 0, 90, 0 ]) {
    intersection() {
      translate(-[ fan_vent_size.x, fan_vent_size.y] / 2)
        cube(fan_vent_size);
      cylinder(d = fan_vent_diameter, h = wall_size + 2 * epsilon, $fn = 180);
      spray_pattern([ fan_vent_size / -2, fan_vent_size / 2 ], [ [ 2 * vent_xstep, 0 ], [ vent_xstep, vent_ystep ] ]) {
        cylinder(d = vent_alveolus_size, h = wall_size + 2 * epsilon, $fn = 6);
      }
    }

    at_four_corners([ -fan_vent_mounting_hole_position, fan_vent_mounting_hole_position ])
      cylinder(d = fan_vent_mounting_hole_diameter, h = wall_size + 2 * epsilon);
  }

  // Back vents
  back_vent_crop = [ 10 * mm, 10 * mm ];
  back_vent_size = [ useful_size.y - 2 * back_vent_crop.x, useful_size.z - 2 * back_vent_crop.y ];
  translate([ useful_size.x - epsilon, 0, 0 ])
  rotate([ 0, 0, 180 ])
  rotate([ 0, -90, 0 ])
  rotate([ 0, 0, -90 ])
  spray_pattern([ back_vent_crop, back_vent_size + back_vent_crop ], [ [ 2 * vent_xstep, 0 ], [ vent_xstep, vent_ystep ] ]) {
    cylinder(d = vent_alveolus_size, h = wall_size + 2 * epsilon, $fn = 6);
  }

}
