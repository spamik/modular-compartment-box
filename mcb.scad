
// modular, change:
box_x_compartments = 2;
box_y_compartments = 2;
box_height = 25;

// what generate:
box();
//translate([70, 0, 0]) lid();
//translate([-70, 150, 0]) divider(2);

// internal parameters:
out_wall_size = 2.5;
divider_wall_size = 2;
divider_size_tolerance = 1;
compartment_size = 20;

lid_angle = 65;
lid_tolerance = 0.4;

// internal computes
total_width = box_x_compartments * compartment_size + 2* out_wall_size;
total_height = box_y_compartments * compartment_size + 2*out_wall_size;
total_tall = box_height + 2*out_wall_size;
    
inner_width = total_width - 2*out_wall_size;
inner_height = total_height - 2*out_wall_size;

module divider(compartment_count) {
    divider_width = compartment_count * compartment_size - divider_size_tolerance;
    divider_height = box_height-out_wall_size;
    cube(size=[divider_width, divider_wall_size/2, divider_height], center=true);
    cube(size=[divider_width - 2*divider_wall_size, divider_wall_size, divider_height], center=true);
    
    if (compartment_count > 1) {
        for (i = [1:compartment_count-1]) {
            translate([divider_width/-2 - divider_size_tolerance/2 + i*compartment_size, divider_wall_size/-2, 0]) rotate(a=[0, 0, 0]) divider_holder(divider_wall_size, divider_height);
        translate([divider_width/-2 - divider_size_tolerance/2 + i*compartment_size, divider_wall_size/2, 0]) rotate(a=[0, 0, 180]) divider_holder(divider_wall_size, divider_height);
        }
    }
}

module lid() {
    rotate(a=[90, 0, 0]) lid_shape(inner_width+out_wall_size-lid_tolerance, inner_height+out_wall_size, 2*out_wall_size, lid_angle);
}

module box() {
    difference () {
        union() {
            translate([0, 0, out_wall_size]) difference() {
                cube(size=[total_width, total_height, total_tall], center=true);
                translate([0, 0, out_wall_size]) cube(size=[inner_width, inner_height, total_tall], center=true);                               
            }
           // vršek pro vyříznutí na víko
           translate([0, 0, box_height/2+out_wall_size]) cube(size=[total_width, total_height, 2*out_wall_size], center=true);  
        }   
    
        // víko
        translate([inner_width/-2-out_wall_size/2, inner_height/2, box_height/2-0.01]) rotate(a=[90, 0, 0]) lid_shape(inner_width+out_wall_size, inner_height+out_wall_size+1, 4*out_wall_size, lid_angle);
    }
    
    
   
    
    for (i=[1:box_x_compartments-1]) {
        translate([total_width/-2+out_wall_size+i*compartment_size, total_height/-2, 0]) rotate(a=[0, 0, 0]) divider_holder(out_wall_size);
        translate([total_width/-2+out_wall_size+i*compartment_size, total_height/2, 0]) rotate(a=[0, 0, 180]) divider_holder(out_wall_size);
    }
    
    for (i=[1:box_y_compartments-1]) {
        translate([total_width/2, total_height/-2+out_wall_size+i*compartment_size, 0]) rotate(a=[0, 0, 90]) divider_holder(out_wall_size);
        translate([total_width/-2, total_height/-2+out_wall_size+i*compartment_size, 0]) rotate(a=[0, 0, -90]) divider_holder(out_wall_size);
    }
    
}



module lid_shape(width, height, tall, angle) {
    linear_extrude(height=height) polygon([[0, 0], [tall/tan(angle), tall], [width-(tall/tan(angle)), tall], [width, 0]]);
}

module divider_holder(base_size, height=box_height) {
    translate([0, (base_size+divider_wall_size)/2, 0]) difference() {
        cube(size=[3*divider_wall_size, base_size+divider_wall_size, height], center=true);
        translate([0, (base_size-1)/-2+base_size, -1]) cube(size=[divider_wall_size, divider_wall_size+1, height+3], center=true);
    }


    
}