$fa=0.5;
$fs=0.2;

module rounded_rectangle(l, w, r) {
  union() {
    square([l-2*r, w], center=true);
    square([l, w-2*r], center=true);
    translate([l/2-r, w/2-r]) circle(r=r);
    translate([-l/2+r, w/2-r]) circle(r=r);
    translate([-l/2+r, -w/2+r]) circle(r=r);
    translate([l/2-r, -w/2+r]) circle(r=r);
  }
}

module box(l, w, h, r, thickness) {
  difference() {
    scale([1,1,-1])
      linear_extrude(height=h)
        rounded_rectangle(l, w, r);
    scale([1,1,-1])
      translate([0,0,-thickness])
      linear_extrude(height=h)
        rounded_rectangle(l-thickness*2, w-thickness*2, r);
  }
}

// Small box
box(10, 20, 10, 1, 1);

// Bigger box
translate([30, 30, 0])
  box(15, 15, 5, 3, 0.5);
