use <3d/square_reinforcement.scad>
use <3d/alveolar_reinforcement.scad>
use <2d/rc_car.scad>

// Size of the RC Car plate
base = [135, 200];
tip = [50, 50];
junction = 25;

// Compute the bounding box size
size_x = base[0];
size_y = base[1]+2*tip[1]+2*junction;
bounding_box = [[-size_x/2, -size_y/2], [size_x/2, size_y/2]];

translate([-100, 0, 0])
  square_reinforcement(bounding_box = bounding_box, thickness = 2, height = 10, alveolus_size = 30)
    rc_car(base, tip, junction);

translate([100, 0, 0])
  alveolar_reinforcement(bounding_box = bounding_box, thickness = 1, height = 10, alveolus_size = 15)
    rc_car(base, tip, junction);
