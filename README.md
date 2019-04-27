My personal NixOS configurations
================================

This Repository contains my configurations for NixOS.
My goal is to create an abstract way to define all my systems,
but also to share my approaches with the NixOS community.

Usage
-----

You probably shouldn't use my complete configurations directly.
However a lot of my configurations inside `/modules` and `/overlays` should work
as stand-alone. Feel free to use them in your own configuration. :)

Folders
-------

### `/host`

All my devices are defined here.

### `/profiles`

Profiles which define the base structure of a Device.

### `/modules`

Configuration of NixOS modules using the same directory structure as the
official [nixpkgs](https://github.com/NixOS/nixpkgs/tree/master/nixos/modules)
Repository.

### `/overlays`

Miscellaneous configurations.

### `/user`

Unix user definitions.


Support
-------

I am open to any suggestions to inprove my configurations. If you find a better
solution to a problem, or a mistake/misinformation in it, feel free to open an
issues. I would be very pleased about it. :)
