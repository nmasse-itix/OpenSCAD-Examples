$fa=1;
$fs=0.5;

difference() {
  cylinder(d=30, h=5, center=true);
  cylinder(d=25, h=6, center=true);
}

difference() {
  cylinder(d=15, h=5, center=true);
  cylinder(d=10, h=6, center=true);
}

for(t=[0:30:369])
  rotate([0,0,t])
    translate([10,0,0])
      sphere(d=5, center=true);
