$fa=1;
$fs=0.5;

hull() {
  translate([-10, -10, -10]) sphere(r=2);
  translate([-10, -10, 10]) sphere(r=2);
  translate([10, -10, 10]) sphere(r=2);
  translate([10, -10, -10]) sphere(r=2);
  translate([10, 10, -10]) sphere(r=2);
  translate([10, 10, 10]) sphere(r=2);
  translate([-10, 10, 10]) sphere(r=2);
  translate([-10, 10, -10]) sphere(r=2);
}
