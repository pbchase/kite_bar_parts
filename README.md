# 3D models of components for kite control bars

This repository is a collection of 3D models for components that could be used in the construction of kite control bars. The models were created with a OpenSCAD, a programming language and development environment for 3D modelling. Some of these modules are complete components that have been used in actual gear. Some are speculative designs. Other are primivites used as part of a complete component.

## How to view and manipulate these models

These OpenSCAD models can be opened, viewed, and revised using free software found at [www.openscad.org](http://www.openscad.org/). The software is available for Mac OS X, Windows, and Linux.

For the most basic use, download and install OpenSCAD. Open a model and preview it. Use the viewer controls to examine the model from all sides.

To make changes you need very basic programming skills. The editor window of OpenSCAD will show the code that generates the model. Most of the dimensions of the model have been parameterized. Revise the values of variables defined the file and preview the revised model to understand how each variable affects the model. Note that all dimensions are in millimeters.


## How to print these models

To print the model you will need to generate a vector file in STL format. OpenSCAD can generate an STL file after the render the model. Most 3D printers can use an STL file as input.

Default 3D printer settings often use a minimal number of shells and a sparse infill that is too weak to handle the loads required in the field. To address this use at least 3 shells and a high infill. 80% infill is not unreasonable.

Most of these designs do not need supports. In some cases overhangs have been specifically tailored to meet the Makerbot standard of an overhang of no more than 68 degrees off vertical.


## About the models

## Tested models

* wichard_snaphook_handle_golf_tee_style - a cone-and-flange handle to open the gate of a Wichard Snap shackle.
* wichard_snaphook_handle - a cone-and-ball handle to open the gate of a Wichard Snap shackle. The wall thickness is thin at the base of the cone and the transition is harsh.

### Untested models

* stopper_ball - The ball used in a moveable stopper on a kite bar trim line. This component has never been tested.
* stopper_block - The block in a moveable stopper. This component has never been tested. Its edges are far harsher than what is possible when machining such a block from Delrin.
* wichard_snaphook_release_cone - a cone to open the gate of a Wichard Snap shackle.  This component has never been tested.


### Primitives

* elliptical_cone - a primitive the generates a vertically orients cone with a profile of 1/4 of an ellipse.
* elliptical_torus - a primitive the generates a torus with a eliptical cross section. It includes a primitive for an ellipse as well.
* fillet_around_cylinder_base - a primitive that generates a cylinder surrounded by a 1/4 circle fillet.


## Contributing

If you would like to contribute revisions to these models or add new models and are familiar with Git and Github, feel free to fork this repo, make changes and submit a pull request. You are also welcome to open an issue and attach a file of send me files at philipbchase@gmail.com. All contributions should include a Creative Commons Public Domain license.

