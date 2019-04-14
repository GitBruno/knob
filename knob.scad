// AWG Knob

// Parameters
// -----------------

// Knob Height
shaft_depth = 15;
height_addon = 4; // At least the wall thickness

// Knob width
knob_width = 17;

// D-shaft
dshaft_startdepth = 6;
dshaft_inset = 6.75;

// Knob finish
skirt_addon = 0; // Will add to knob width
skirt_depth = 2;
skirt_slope_height = 6;

grip_star = 5;
top_round_inset = 3;
top_round_height = 1;

// -----------------


// Build
// -----------------

shaft_depth = shaft_depth - dshaft_startdepth;
shaft_clear = shaft_depth - shaft_depth;
height = shaft_depth + height_addon;
diameterBottom = knob_width + skirt_addon;

$fn = 100; // Smooth Model

difference(){
    intersection(){
        union(){
            cylinder(d=knob_width,h=height,$fn=grip_star);
            rotate(a=360/grip_star/2,v=[0,0,1]) {
                cylinder(d=knob_width,h=height,$fn=grip_star);
            };
            // bottom finish
            cylinder(d=diameterBottom,h=skirt_depth);
            translate([0,0,skirt_depth]) {
                cylinder(d1=diameterBottom,d2=0,h=skirt_slope_height);
            };
        };
        // top finish
        union(){
            cylinder(d1=diameterBottom,d2=knob_width,h=height-top_round_height);
            translate([0,0,height-top_round_height]) {
                cylinder(d1=knob_width,d2=knob_width-top_round_inset,h=top_round_height);
            };
        };
    };
    
    // Shaft
    //------
    difference(){
        union(){
            translate([0,0, -1]){
                cylinder(d=6,h=shaft_depth+1);
                cylinder(d1=6.5,d2=0,h=6.5);
            };
        }
        translate([0,0, shaft_clear])
        translate([dshaft_inset,0,dshaft_startdepth])
        cube([10,10,shaft_depth-shaft_clear],center=true);
    }
}
