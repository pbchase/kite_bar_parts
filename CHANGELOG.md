# Change Log
All notable changes to the Kite Bar Parts project will be documented in this file.
This project adheres to [Semantic Versioning](http://semver.org/).


## [1.4.2] - 2019-05-05
### Changed
- Promote the cleat bead to a tested model (Philip Chase)
- Update cleat_bead and separation_block_v1 STLs to 80 facets (Philip Chase)


## [1.4.1] - 2019-02-19
### Changed
- Realign the flag line path with the sphere surface and campher the trimline_bore in cleat_bead (Philip Chase)
- Expand back face of cleat bead to have 1mm thick, radiused edges (Philip Chase)
- Make the cleat_bead taller, add a radius to the base, widen flag_line_path, use true sphere for bead body (Philip Chase)

## [1.4.0] - 2019-02-16
### Added
- Add cleat_bead, an interface between the cleat, bar and flag line to substitute for a moveable stopper [Philip Chase]


## [1.3.0] - 2018-09-25
### Added
 - Add three-part, segmented wichard snaphook - Philip Chase

### Changed
 - Narrow the width of the flange to match the height in stopper_block_v4 so as to diminish interference when cleating the trimline - Philip Chase
 - Form the stopper block flange with a hulled, squashed torus - Philip Chase
 - Rotate the cross bores in the stopper ball to eliminate the twisting of the bungie inside the block's bungie path - Philip Chase
 - Use a broad flat base on the stopper ball to reduce separation from the raft during printing - Philip Chase
 - Add trimline bore diameter for multiple lines sizes to stopper ball and stopper_block_v4 standardizing on modern 5mm amsteel - Philip Chase
 - Parameterize and adjust magnet, bungie path, and block depth of stopper_block_v4 - Philip Chase


## [1.2.0] - 2018-08-12
### Added
 - Add separation_block_v2 - Philip Chase
 - Add separation_block - Philip Chase
 - Add STL files for all fiels that did not have them

### Changed
 - Move the documentation for older designs and primitives to their own files - Philip Chase
 - Extend flange of stopper_block_v4 laterally to make it more comfortable to push - Philip Chase


## [1.1.0] - 2018-06-24
### Added
 - Add stopper_block_v4 a narrow, rounded block with a wide pushable flange on the backside - Philip Chase
 - Add elliptical_sphere to elliptical_torus.scad - Philip Chase
 - Add trapezoided_cube.scad - Philip Chase

### Changed
 - Fatten the contact surface at the base of the cone at the bottom of the stopper_ball - Philip Chase


## [1.0.0] - 2018-06-10
### Added
- First release provides these designs:
-   stopper_ball
-   stopper_block
-   stopper_block_v2
-   stopper_block_v3
-   wichard_snaphook_handle
-   wichard_snaphook_handle_golf_tee_style
-   wichard_snaphook_release_cone

