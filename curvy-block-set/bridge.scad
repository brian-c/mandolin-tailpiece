use <curvy_block.scad>;

module bridge(
  saddle_w = 44/3*4,
  saddle_t = 6.4,
  base_t = 1.5,
  post_h = 10.3,
  post_d = 6,
  post_rim_h = 1.5,
  post_rim_d = 10.4,
  stud_d = 13.5,
) {
  translate([0, 0, post_h/2]) {
    difference() {
      union() {
        // Side pieces
        for (i=[-1, 1]) {
          translate([(saddle_w+stud_d*1.25)/2/i, 0]) {
            rotate([0, 0, 90*i]) {
              curvy_block(size=[stud_d, stud_d*1.25, post_h], r1=stud_d/2, r2=stud_d/2, r3=post_h/2, r4=post_h/2);
            }
          }
        }

        difference() {
          // Bar
          cube(size=[saddle_w+stud_d, stud_d, post_h], center=true);

          // Saddle slot
          translate([0, 0, base_t]) {
            cube(size=[saddle_w+stud_d, saddle_t, post_h], center=true);
          }

          // Scoop
          translate([0, 0, post_h/2]) {
            resize([saddle_w+stud_d, stud_d+0.02, post_h*2-base_t*4]) {
              rotate([90]) {
                cylinder(d=1, h=1, center=true);
              }
            }
          }
        }
      }

      // Post holes
      for (i=[-1, 1]) {
        translate([(saddle_w+stud_d)/2/i, 0]) {
          cylinder(d=post_d, h=post_h+0.02, center=true);

          translate([0, 0, (post_h-post_rim_h)/-2]) {
            cylinder(d=post_rim_d, h=post_rim_h+0.01, center=true);
          }
        }
      }
    }
  }
}