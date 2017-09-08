# VHDL scratchpad

## Instructions

- Install ```ghdl``` and dependencies (ADA compiler or libgnat for ubuntu) from AUR ([https://aur.archlinux.org/packages/ghdl/](https://aur.archlinux.org/packages/ghdl/)).
- Clone this repo with ```git clone https://github.com/syfluqs/vhdl.git```.
- ```cd hdl_scratchpad/vhdl```
- ```source vhdl```
- Create new project with ```new_vhdl_proj <project_name>```
- Create the vhdl source and/or test bench files.
- Compile with ```make``` if project folder contains only one vhdl source file. Use ```make in=<vhdl_file_name.vhdl>``` if more than one source files are present.
- For projects with test bench, run ```make import in=<component_file_name.vhdl> && make in=<testbench_file_name.vhdl>```

## Automatic Testbench Creation (experimental)

The makefile also supports auto-creation of testbenches for entites.
- Run ```make testbench in=<input_file_name.vhdl>``` for creating testbench for entity defined in ```input_file_name.vhdl```.
- Run ```make test_entity in=<input_file_name.vhdl>``` for testing entity by creating a testbench and simulating it.

## Makefile command list

| **Command** | **Description** |
|-------------|-----------------|
| ```make [in=input_file.vhdl] [std=08]``` **or** ```make make [in=input_file.vhdl] [std=08]``` | Execute the build process in the following order: <ol><li> Check Syntax </li><li> Import into current work cache </li><li> Build (analyze and elaborate) </li><li> Run the built executable file and generate the waveform output file. </li><li> Run gtkwave and show the waveforms. </li></ol> <br/> **Input parameters:** <br/> The following are the valid input parameters. These can be used with other of the commands too. <ul><li> **```in```** : The name of the file to be processed is supplied with the ```in``` parameter. The ```in``` parameter is optional if the directory contains only one vhdl file. The makefile will automatically determine the input file name in that case. </li><li> **```std```** : The ```std``` parameter specifies the VHDL standard that GHDL will use. Valid options are 87, 93, 93c, 00, 02 and 08. By default **08** is used. *For more info: [http://ghdl.readthedocs.io/en/latest/GHDL_implementation_of_VHDL.html#vhdl-standards](http://ghdl.readthedocs.io/en/latest/GHDL_implementation_of_VHDL.html#vhdl-standards)* </li><li> **```entity```** : This parameter is used to explicitly specify the entity name to be processed. </li></ul> |
| ```make nowave [in=input_file.vhdl]``` | Execute the entire build process, except showing the waveforms. Useful when the vhdl program is designed to only print its output. |
| ```make test_entity [in=input_file.vhdl]``` | Generates testbench file for  ```input_file.vhdl``` and executes the entity with test signals. Following order is followed: <ol><li>Check Syntax of input file.</li><li>Generate testbench file (testbench filename format: ```entity_name_tb.vhdl```).</li><li>Check Syntax of generated testbench file.</li><li>Import the input file into work cache. </li><li>Import the testbench file into work cache.</li><li>Build the testbench file (analyze original file, analyze testbench file and elaborate the testbench file).</li><li>Run the executable file and generate output waveforms</li><li>Invoke ```gtkwave``` with the generated waveforms.</li></ol> |
| ```make test_entity_nowave [in=input_file.vhdl]``` | Generate testbench file and execute it without showing the otuput waveforms. |
| ```make testbench [in=input_file.vhdl]``` | Generate a testbench file for the entity defined in the ```input_file.vhdl``` and exit. The testbench created has a filename in the format, ```entity_name_tb.vhdl```. |
| ```make syntax [in=input_file.vhdl]``` | Check syntax of ```input_file.vhdl``` |
| ```make import [in=input_file.vhdl]``` | Import ```input_file.vhdl``` into current work cache. The work cache is stored in the current directory with the file name ```work-objXX.cf``` where ```XX``` represents the VHDL standard used. |
| ```make build [in=input_file.vhdl]``` | Build the entity contained in the ```input_file.vhdl``` or explicitly specified entity name with ```enntity``` parameter. GHDL is invoked as ```ghdl -m --std=08 entity-name```. <br/>The ```input_file.vhdl``` must be imported into current work cache prior to running ```make build```. |
| ```make run_simulation [in=input_file.vhdl]``` | Runs the generated executable file. Any ```report```ed string in the VHDL program will be printed along with the time and a compressed dump of signal change values will be created as a ```ghw``` file. |
| ```make waveform [in=input_file.vhdl]``` | Invoke ```gtkwave``` with the generated ```ghw``` file and show the resultant waveforms. A custom ```gtkwaverc``` is used which is present in the location ```common/gtkwaverc```. |