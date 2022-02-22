/*
=======CUSTOM SPOTIFY CODE=======
https://www.thingiverse.com/thing:4933844
By OutwardB - https://www.thingiverse.com/outwardb/about
Updated 2021-09-11

This work is licensed under the Creative Commons - Attribution - Non-Commercial - ShareAlike license.
https://creativecommons.org/licenses/by-nc-sa/3.0/

-- MODIFICATIONS --
Changed default values
*/

/*[Basic Settings]*/
// Enter the File Name/Path
code_file = "code.svg";
// Length of code frame (in MM) Does not include the keyring if enabled
size_in_mm = 70; //[40:200]
// If set, size value will be altered so that the width of each small line is a multiple of this value (set to your nozzle width or line size setting in your slicer, or 0 to disable)
line_size = 0; //[0:0.001:2]
// Select A Type
code_type = "cut-out"; //[raised:Raised,cut-out:Cut-Out,multi-color:Multi-Color | Code is displayed in preview ,code:Multi-Color Code | Use with Multi-Color,2D]
// Logo Options
logo_type = "Yes"; //[Yes:Default,No:None,Custom,Heart Top,Heart Bottom]
// Rounded Corners
corner_roundness = 5; // [0:10]
// Height of Base (0 to disable)
base_height = 5.0; //[0:0.01:20]
// Height of the Code (0 to disable)
code_height = 0.6; //[0:0.01:20]

/*[Custom Logo Settings]*/
Note = "Select Custom for Logo Type to enable these";
// Set the scale of the custom logo
custom_logo_scale = 0.385; //[0.001:0.001:20]
// Enter the filename (use a .svg file)
custom_logo_file = "";
// Rotate the logo (this also works for the heart-hole keyring option)
custom_logo_rotate = 0; //[-180:0.01:180]
// If enabled, the custom icon will be masked to the size of the default spotify logo)
mask_logo = false;

/*[Keyring Settings]*/
// Basic or minimal keyhole
keyhole_type = "tag"; //[None,basic:Basic,basic-alt:Basic Alt,minimal:Minimal,minimal-alt:Minimal Alt,tag:Tag,tag-squared:Tag Squared,hole:Hole,heart-hole:Heart Hole]
// Pick a side for the keyhole
keyhole_side = "left"; //[left,right]
// Choose how high the keyhole should be (doesn't work on Raised type)
keyhole_top_layer = true;
// Diameter of the hole (in mm)
hole_size = 5; //[1:0.001:20]
// Border around the hole (in mm)
hole_border = 3; //[1:0.001:20]
// Move the hole further/closer to the center
hole_pos_buffer = 0; //[-5:0.1:5]

/*[Border Settings]*/
// Tick to enable a border - This will enable keyhole_top_layer
border = false;
// Width of border
border_width = 1; //[0.1:0.01:10]
// Border around the keyhole (if enabled)?
border_around_hole = true;

/*[Text Settings]*/
// Select text to use text instead of a spotify code
thing_to_draw = "code"; //[code:Spotify Code,text:Custom Text]
// Enter the text
input_text = "Hi There";
// Font for the text. You can set styles by using this format | Impact:type=Bold
text_font = "Impact:type=Bold";
// Set to 0 to use auto-calculated value
overide_text_size = 0; //[0:0.1:40]

/*[Advanced Text Settings]*/
// Move text left/right
text_x_nudge = 0; //[-40:0.1:40]
// Move text up/down
text_y_nudge = 0; //[-40:0.1:40]
// Align text to left or right side
halign = "left"; //[left,right]
// Spacing between characters (Default is 1)
spacing = 1; //[0.1:0.1:5]
// Direction to draw text (Default is ltr)
direction = "ltr"; //[ltr:left-to-right,rtl:right-to-left,ttb:top-to-bottom,btt:bottom-to-top]
// Language of text (Default is en)
language = "en";
// Text Script (Default is Latin)
script = "latin";

/*[Advanced Corner Settings]*/
// Corners will use this setting if the boxes below are ticked
alt_rounded_val=0;
// Bottom Left
bl = false;
// Bottom Right
br = false;
// Top Left
tl = false;
// Top Right
tr = false;

/*[Colors (For Preview Only)]*/
// Use hex values (#FFFFFF) or any of the named colors listed here:
color_name_format = "https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/Transformations#color";
// Color of the Base
base_color = "Gainsboro";
// Color of the Code & Logo
code_color = "#F1828D";
// Outer color for cutout/multi-color preview
outer_color = "#765D69";

/*[Hidden]*/
// WIP - Height is auto-calculated but you can override it here (0 for auto-calculated value | default is roughly 25% of length value)
height_override = 0;
// WIP - Space between code and base
multi_color_tolerance = 0.05; //[0:0.01:1]

$fn = $preview?50:100;
//// Default Import Size - 225.78 x 56.44
//// Default line size - 3.3
x = size_in_mm/225.78; // Divide size varible by default import X size to get scale ratio

// Optimize by line_size
item_size = 3.3*x;
a_line_count = round(item_size/line_size); // Line count per square rounded
a_item_size = line_size*a_line_count; // New square size
a_scale_ratio = a_item_size/3.3; // New scale ratio
a_size = a_scale_ratio*225.78; // New size value
size = line_size==0 ? size_in_mm : a_size;
scale_value = line_size==0 ? x : a_scale_ratio;
if(line_size!=0) echo(actual_size=a_size);

y = 56.44 * scale_value; // Times the default Y size by the ratio to get the height
echo(Height=y);
r = corner_roundness; // Just adding a friendly varible name for the customizer
height = height_override==0?y:height_override;

logo = keyhole_type=="heart-hole" ? "Custom": keyhole_type=="hole" ? "Custom": logo_type; // Set logo type to 'custom' if cutting out a hole
size_val = logo != "No" ? size : size -y*0.8; // Sets the length value based on if there is a logo or not
corner_val = r==0?0.1:(y/20) * r; // Sets the corner radius value from a 0-10 slider
rotate_code = keyhole_type=="hole"||keyhole_type=="heart-hole"||keyhole_side=="left" ? false : true; // Rotate code if specified (unless cutting out a hole)
custom_logo_file_val = logo=="Heart Top" || logo=="Heart Bottom" || keyhole_type=="heart-hole" || keyhole_type=="hole" ?  "" : custom_logo_file; // Blank the custom logo file name if needed (removes the spotify logo
text_size = overide_text_size==0?size/8:overide_text_size; // Calculate text font size unless defined
if(thing_to_draw=="text"&&overide_text_size==0){
    echo(Text_Size=text_size);
}
text_align = direction=="ttb"||direction=="btt" ? "bottom" : "center";

//base_height_val = base_height==0 && code_type=="raised" ? 0.1 : base_height;
base_height_val = base_height;

key_hole_top_layer = border ? true : keyhole_top_layer;

alt_rounded=alt_rounded_val==0?0.1:alt_rounded_val;
blr=bl?alt_rounded:corner_val;
brr=br?alt_rounded:corner_val;
tlr=tl?alt_rounded:corner_val;
trr=tr?alt_rounded:corner_val;

/////////////////// MODULES
module frame(x,y,r){
    hull(){
        translate([blr  , blr])   circle(blr);
        translate([x-brr, brr])   circle(brr);
        translate([tlr  , y-tlr]) circle(tlr);
        translate([x-trr, y-trr]) circle(trr);
    }
}

module rounded_square(x,y=undef,r,center=undef){
    yv = y ? y : x;
    n = x > yv ? yv : x;
    rv = r == 0 ? 0.1 : r > n/2 ? n/2 : r;
    translate([center?-x/2:0,center?-yv/2:0,0])
        hull(){
            translate([rv,rv,0]) circle(rv);
            translate([x-rv,rv,0]) circle(rv);
            translate([x-rv,yv-rv,0]) circle(rv);
            translate([rv,yv-rv,0]) circle(rv);
        }
}

module custom_logo(){
    intersection(){
        translate([y/2,y/2,0]) circle(mask_logo ? y/3.25 : y/2.1); //// TO DO - UPDATE SECOND VALUE
        color("grey") translate([y/2,y/2,0]) scale([custom_logo_scale,custom_logo_scale,1]) rotate(-custom_logo_rotate) import(custom_logo_file, center=true);
    }
}

module import_code(){
    difference(){
        offset(-0.1) frame(size_val,y,corner_val);
        if(code_file != ""){
            if(logo == "Yes"){
                scale([scale_value,scale_value,1])  import(code_file);
            } else if(logo == "No") {
                difference(){
                    translate([-y*0.8,0,0]) scale([scale_value,scale_value,1]) import(code_file);
                    translate([(-y*0.8)-1,0]) square([(1+y*0.8),y+1]);
                }
            } else {
                // Custom
                difference(){
                    union(){
                        scale([scale_value,scale_value,1]) import(code_file);
                        square([y,y]);
                    }
                    if(custom_logo_file_val != "") custom_logo();
                }
            }
        }
    }
}


module keyhole(type){
    if(type=="basic"){
        translate([hole_pos_buffer-(hole_size/2),height/2]) circle(d=hole_size+(hole_border*2), $fn=(hole_size+1)*10);
    } else if(type=="basic-alt") {
        translate([hole_pos_buffer-hole_size-hole_border+blr,blr]) circle(blr);
        translate([hole_pos_buffer-hole_size-hole_border+tlr,height-tlr]) circle(tlr);
    } else if(type=="minimal") {
        hull(){
            translate([hole_pos_buffer-hole_size/2,height/2,0]) circle(d=hole_size+(hole_border*2));
            translate([size_val/10,height/2,0]) square([0.01,hole_size+(hole_border*2)], center=true);
        }
    } else if(type=="minimal-alt") {
        translate([hole_pos_buffer-hole_size/2,height/2,0]) circle(d=hole_size+(hole_border*2));
    } else if (type=="tag"||type=="tag-squared"){
        translate([hole_pos_buffer-hole_size-hole_border+blr,blr,0]) circle(blr);
        translate([hole_pos_buffer-hole_size-hole_border+tlr,height-tlr,0]) circle(tlr);
    }
}

module heart(size){
    translate([0,-size/5,0]){
        rotate(45){
            square(size, center = true);
            translate([0,size/2,0]) circle(size/2);
            translate([size/2,0,0]) circle(size/2);
        }
    }
}

module keyhole_hole(type){
    if(type=="basic"){
        translate([hole_pos_buffer-(hole_size/2),height/2]) circle(d=hole_size, $fn=hole_size*10);
    } else if(type=="basic-alt") {
        translate([hole_pos_buffer-(hole_size/2),height/2]) circle(d=hole_size, $fn=hole_size*10);
    } else if(type=="minimal") {
        translate([hole_pos_buffer-0.01-hole_size/2,height/2,0]) circle(d=hole_size);
    } else if(type=="minimal-alt") {
        translate([hole_pos_buffer-hole_size/2,height/2]) translate([-0.01,0]) circle(d=hole_size);
    } else if (type=="tag"){
        translate([hole_pos_buffer-hole_size-hole_border,0,0]) intersection(){
            offset(-hole_border) rounded_square(size_val,height,corner_val);
            difference(){
                square([hole_border+hole_size+hole_border+hole_pos_buffer,height]);
                translate([hole_pos_buffer+hole_size+hole_border,0]) rounded_square(size_val,height,corner_val);
            }
        }
    } else if(type=="tag-squared") {
        translate([hole_pos_buffer-hole_size-hole_border,0,0]) intersection(){
            offset(-hole_border) rounded_square(size_val,height,corner_val);
            square([hole_size+hole_border,height]);
        }
    } else if(type=="hole") {
        translate([y/2,height/2]) circle(y/3.25);
    } else if(type=="heart-hole") {
        translate([y/2,height/2]) rotate(-custom_logo_rotate) heart(y/2.5);
    }
}


module hu(x=1){
    if(x){ hull() children(); } else { union() children(); }
}

module draw_frame(keyhole=0){
    rotate([0,0,rotate_code?180:0]) translate([rotate_code?-size_val:0,rotate_code?-height:0,0]) difference(){
        if(keyhole){
            hu(keyhole_type=="minimal"||keyhole_type=="minimal-alt"?0:1){
                keyhole(keyhole_type);
                frame(size_val,height,corner_val);
            }
        } else {
            frame(size_val,height,corner_val);
        }
        keyhole_hole(keyhole_type);
    }
}

module draw_code(shell=false){
    if(shell){
       difference(){
            draw_frame(key_hole_top_layer);
            translate([0,height_override==0?0:(height_override-y)/2,0]) import_code();
        }
    } else {
        translate([0,height_override==0?0:(height_override-y)/2,0]) import_code();
    }
}

module spotify_logo(){
    difference(){
        square([(y*0.8),y]);
        scale([scale_value,scale_value,1]) translate([0,0,0]) import(code_file);
    }
}

module text_it(){
    intersection(){
        offset(-y/10) draw_frame();
        translate([logo!="No"?y:y/5,text_align=="baseline"? y/2 -(text_size/2): y/2,0]) translate([text_x_nudge,-text_y_nudge,0]) translate([halign=="right"?size-(y*1.2):0,halign=="right"&&(direction=="ttb"||direction=="btt")?-text_size/2:0,0])
rotate(direction=="ttb"||direction=="btt"?halign=="left"?90:-90:0)
text(input_text, font=text_font, size=text_size, halign=halign, valign=text_align, spacing=spacing,direction=direction,language=language,script=script);
    }
    if(logo=="Yes"){
        spotify_logo();
    } else if(logo=="Custom"){
        if(custom_logo_file_val != "") custom_logo();
    }
}

module draw_text(shell=false){
    if(shell){
        difference(){
            draw_frame(key_hole_top_layer);
            translate([0,height_override==0?0:(height_override-y)/2,0]) text_it();
        }
    } else {
        translate([0,height_override==0?0:(height_override-y)/2,0]) text_it();
    }
}

module draw_item(val){
    if(thing_to_draw=="code"){
        draw_code(val);
    } else {
        draw_text(val);
    }    
}

module border(type=0){
    if(type){
        difference(){
            draw_frame(1);
            offset(-border_width) draw_frame(1);
        }
    } else {
        difference(){
            hu(keyhole_type=="minimal"||keyhole_type=="minimal-alt"?0:1){
                keyhole(keyhole_type);
                frame(size_val,height,corner_val);
            }
            offset(-border_width) hu(keyhole_type=="minimal"||keyhole_type=="minimal-alt"?0:1){
                keyhole(keyhole_type);
                frame(size_val,height,corner_val);
            }
        }
    }
}

module the_thing(){
    if(code_type == "code"){
        color(code_color) translate([0,0,base_height_val]) linear_extrude(code_height) {
            draw_item();
            if(border) border(border_around_hole);
        }
    } else if(code_type == "2D"){
        color(code_color) translate([0,0,base_height_val]) {
            draw_item(1);
        }
    } else {
        color(base_color) linear_extrude(base_height_val) draw_frame(1);
        if(code_type == "raised"){
            color(code_color) translate([0,0,base_height_val]) linear_extrude(code_height) draw_item();
        } 
        if(code_type == "cut-out"){
            color(outer_color) translate([0,0,base_height_val]) linear_extrude(code_height) draw_item(1);
        }
        if(code_type == "multi-color"){
            color(outer_color) translate([0,0,base_height_val]) linear_extrude(code_height) 
            if(border){
                difference(){
                   draw_item(1);
                   border(border_around_hole);
                }
            } else {
                draw_item(1);
            }
            if($preview) color(code_color) translate([0,0,base_height_val]) linear_extrude(code_height){ 
                draw_item();
                if(border) border(border_around_hole);
            }
        }
        if(border&&code_type!="multi-color") color(code_color) translate([0,0,code_type=="cut-out"? base_height+code_height : base_height]) linear_extrude(code_height) border(border_around_hole);
    }
}

///////////////////// PROGRAM
if(logo == "Heart Top" || logo == "Heart Bottom"){
    difference(){
        the_thing();
        translate([y/1.5,logo == "Heart Bottom" ? 0 : height,-0.001]) rotate(90) linear_extrude(base_height_val+code_height+0.002) heart(y/2);
    }
} else {
    the_thing();
}
