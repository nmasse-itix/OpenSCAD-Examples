module alveolar_reinforcement(bounding_box, thickness, height, alveolus_size) {
  xstep = 2 * cos(30) * (thickness + sqrt(3) * alveolus_size / 2);
  ystep = sin(30) * (thickness + sqrt(3) * alveolus_size / 2);

  xn = ceil((bounding_box[1][0] - bounding_box[0][0]) / xstep);
  yn = ceil((bounding_box[1][1] - bounding_box[0][1]) / ystep);
  origin = bounding_box[0];

  // Bounding box debug
  /*
  #polygon(points = [
    [bounding_box[0][0], bounding_box[0][1]],
    [bounding_box[1][0], bounding_box[0][1]],
    [bounding_box[1][0], bounding_box[1][1]],
    [bounding_box[0][0], bounding_box[1][1]]
  ]);
  */

  difference() {
    linear_extrude(height = height) {
      children();
    }
    for (y = [0:1:yn]) {
      for (x = [0:1:xn]) {
        posx = origin[0] + (x * xstep) + (y % 2) * xstep / 2;
        posy = origin[1] + (y * ystep);
        translate([posx, posy, height / 2 + thickness])
          cylinder(d = alveolus_size, h = height - thickness, center = true, $fn = 6);
      }
    }
  }

  linear_extrude(height = height) {
    difference() {
      children();
      offset(-thickness)
        children();
    }
  }
}
