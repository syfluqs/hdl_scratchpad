# My VHDL scratchpad

## Instructions

- Install ```GHDL``` and dependencies (ADA compiler or libgnat for ubuntu) from AUR [https://aur.archlinux.org/packages/ghdl/](https://aur.archlinux.org/packages/ghdl/).
- Clone this repo with ```git clone https://github.com/syfluqs/vhdl.git```.
- ```cd vhdl```
- ```source vhdl```
- Create new project with ```new_vhdl_proj <project_name>```
- Create the vhdl source and/or test bench files.
- Compile with ```make``` if project folder contains only one vhdl source file. Use ```make in=<vhdl_file_name.vhdl>``` if more than one source files are present.
- For projects with test bench, run ```make import in=<component_file_name.vhdl> && make in=<testbench_file_name.vhdl>```