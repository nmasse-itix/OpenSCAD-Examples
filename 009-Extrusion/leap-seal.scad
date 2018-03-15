
rotate_extrude(convexity = 10, $fn = 100) {
  translate([100, 0]) {
    scale([-1, 1]) {
      difference() {
        square([40,40]);
        polygon(points=[[-1,-1],[-1,5],[5,-1]]);
        polygon(points=[[-1,41],[-1,36],[5,41]]);
        translate([7,7]) square([26,34]);
      }
      translate([33, 33]) circle(r=5);
      polygon(points=[[40, 40],[40,30],[42,35]]);
    }
  }
}
