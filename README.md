My personal NixOS configurations
================================

This Repository contains my configurations for NixOS.
My minor goal is to create an abstract way to define all my systems,
but also to share my approaches with the NixOS community.

The major goal would be an encrypted self reproducible USB backup, with an be
easy deployed.

Usage
-----

You probably shouldn't use my complete configurations directly.
However a lot of my configurations inside `/modules`, `/overrides` and `/fix` should
work as stand-alone. Feel free to use them in your own configuration. :)

Folders
-------

### `/hosts`

All my devices are defined here.

### `/profiles`

Profiles which define the base structure of a device.

### `/modules`

Configuration of NixOS modules using the same directory structure as the
official [nixpkgs](https://github.com/NixOS/nixpkgs/tree/master/nixos/modules)
repository.

### `/overrides`

Miscellaneous configurations.

### `/fix`

Temporary patches tu fix undesirable bugs.

### `/config`

definition of custom config options.

### `/users`

Unix user definitions.

### `/references`


Support
-------

I am open to any suggestions to inprove my configurations. If you find a better
solution to a problem, or a mistake/misinformation in it, feel free to open an
issues. I would be very pleased about it. :)
