$fa=1;
$fs=0.5;
$fn = 50;

// Place balls inside the bearing groove, based on a sample ball provided as
// children
module place_evenly(n) {
  step = 360 / n;
  for(t=[0:step:369]) {
    rotate([0,0,t])
      children();
  }
}

// Create a ball bearing based on:
// - outer diameter
// - inner diameter
// - ball diameter
// - width
// - groove depth (as a percentage of the ball size)
// - space between balls (as a percentage of the ball size)
module ball_bearing(od, id, bd, width, groove, space) {
  center_line_radius = (od-id)/4+id/2;

  difference() {
    union() {
      // outer ring
      difference() {
        cylinder(d=od, h=width, center=true);
        cylinder(d=id+bd*(1-groove)*2, h=width+1, center=true);
      }
      // inner ring
      difference() {
        cylinder(d=od-bd*(1-groove)*2, h=width, center=true);
        cylinder(d=id, h=width+1, center=true);
      }
    }

    // groove
    rotate_extrude(convexity = 10) {
      translate([center_line_radius, 0, 0]) circle(d=bd);
    }
  }

  // Place balls inside the groove
  n = floor(center_line_radius * 2 * PI / (bd * (1+space)));
  place_evenly(n) {
    translate([center_line_radius, 0, 0]) sphere(d=bd);
  }
}

// 6017 SKF Metric Open Deep Groove Ball Bearing 85x130x22mm
ball_bearing(130, 85, 19, 22, 0.15, 0.5);
