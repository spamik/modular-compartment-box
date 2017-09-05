Modular compartment box
=======================

OpenSCAD model of compartment box. Box dimensions are calculated by number of compartments (which have defined size). Then you can generate dividers for box in specified size. This allows to divide one box in several compartments with different sizes and changed it when it's needed.

Generating models
-----------------
In scad file you can modify these parameters:
* box_x_compartments - width of the box specified in number of compartments
* box_y_compartments - height of the box specified in number of compartments
* box_height - tall of the box

Now by commenting/uncommenting you can generate three types of object:
* box() generate box according to specified parameters
* lid() generate compatible lid
* divider(x) generate divider for box to divide x (use number what you want) compartments

There are several other parameters which may be useful to change:
* out_wall_size defines thicknes of the outside walls of the box
* compartment_sizes define size (compartment is square) of one compartment.
* lid_tolerance specifies the difference size between lid and the place for it on the box. If lid doesn't stay in place, you can try lower this number. If you can't close the lid, try increase this number.

3D printing
-----------
Objects was tested for print with 0.3mm layer height, printed as is (for compartments use raft). No support needed.