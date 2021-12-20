// When a small distance is needed to overlap shapes for boolean cutting, etc.
epsilon = 0.01;

module bevel(l, w, h){
   polyhedron(
           points=[[0,0,0], [l,0,0], [l,w,0], [0,w,0], [0,0,h], [l,0,h]],
           faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]
           );
}

module shim(l, w, h){
   polyhedron(
           points=[[-l/2,-w/2,0], [l/2,-w/2,0], [l/2,w/2,0], [-l/2,w/2,0], [-l/2+w/4,0,h], [l/2-w/4,0,h]],
           faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]
           );
}

module halfBevel(l, w, h) {
    bevel(l,h,h);
    translate([0,w,0])
        rotate(a = 270)
            bevel(w,h,h);
}

module fullBevel(l, w, h, b) {
    halfBevel(l, w, b);
    translate([l,w,0])
    rotate(a = 180)
        halfBevel(l, w, 1);
    
    translate([0,0,h])
        rotate(a = 90, v = [0, 1, 0])
            bevel(h,b,b);
    translate([l,0,h])
        rotate(a = 90)
            rotate(a = 90, v = [0, 1, 0])
                bevel(h,b,b);
    translate([l,w,h])
        rotate(a = 180)
            rotate(a = 90, v = [0, 1, 0])
                bevel(h,b,b);
    translate([0,w,h])
        rotate(a = 270)
            rotate(a = 90, v = [0, 1, 0])
                bevel(h,b,b);

}

module tubeBevel(l, w, h, b) {
    translate([0,0,h])
        rotate(a = 90, v = [0, 1, 0])
            bevel(h,b,b);
    translate([l,0,h])
        rotate(a = 90)
            rotate(a = 90, v = [0, 1, 0])
                bevel(h,b,b);
    translate([l,w,h])
        rotate(a = 180)
            rotate(a = 90, v = [0, 1, 0])
                bevel(h,b,b);
    translate([0,w,h])
        rotate(a = 270)
            rotate(a = 90, v = [0, 1, 0])
                bevel(h,b,b);
}

module beveledCube(l, w, h, b) {
  difference() {
      cube([l,w,h]);
      translate([-epsilon, -epsilon, -epsilon])
        fullBevel(l + 2 * epsilon, w + 2 * epsilon, h + 2 * epsilon, 1);
  }
}

module squareTube(l, w, h, t) {
   difference() {
      cube([l,w,h]);
      translate([t,t,-epsilon])
         cube([l - 2 * t, w - 2 * t, h + 2 * epsilon]);
   }
}

module beveledTube(l, w, h, t, b) {
    difference() {
        squareTube(l, w, h, 2);
        translate([-epsilon,-epsilon,epsilon])
            tubeBevel(l + 2 * epsilon, w + 2 * epsilon, h + epsilon, b);
    }
    translate([t,t,0])
        tubeBevel(l - 2 * t, w - 2 * t, h, b);
}

module endCap(cl, cw, ch, tl, tw, th, sl, sw, sh, t, b) {
    translate([ (cl - tl) / 2, (cw - tw) / 2, 0])
        beveledTube(tl, tw, th, t, b);

    translate([ 0, 0, -ch ])
        beveledCube(cl, cw, ch, b);
    
    
    translate([ cl / 2, (cw - tw) / 2, th / 2 ])
    rotate(a = 90, v = [1, 0, 0])
        shim(sl, sw, sh);
    
    translate([ cl / 2, cw / 2 + tw / 2, th / 2 ])
        rotate(a = 270, v = [1, 0, 0])
            shim(sl, sw, sh);

}

endCap(50, 30, 4, 46.5, 27.14, 13, 4, 2, 0.5, 2, 1);

