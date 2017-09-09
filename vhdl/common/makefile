ghdl := ghdl
gtkwave := gtkwave
in = 0
entity = 0
std = 08


.PHONY: make
make: 
	@$(MAKE) --no-print-directory syntax
	@$(MAKE) --no-print-directory import
	@$(MAKE) --no-print-directory build
	@$(MAKE) --no-print-directory run_simulation
	@$(MAKE) --no-print-directory waveform

.PHONY: auto
auto:
	@$(shell ./auto_cmd.sh >&2 )

.PHONY: nowave
nowave: 
	@$(MAKE) --no-print-directory syntax
	@$(MAKE) --no-print-directory import
	@$(MAKE) --no-print-directory build
	@$(MAKE) --no-print-directory run_simulation

.PHONY: test_entity
test_entity: get_entity_name
	@$(MAKE) --no-print-directory testbench
	@$(MAKE) --no-print-directory import
	@$(eval entity=$(shell cat .entity_name))
	@$(MAKE) --no-print-directory import in=$(entity)_tb.vhdl entity=$(entity)_tb
	@$(MAKE) --no-print-directory build in=$(entity)_tb.vhdl entity=$(entity)_tb
	@$(MAKE) --no-print-directory run_simulation in=$(entity)_tb.vhdl entity=$(entity)_tb
	@$(MAKE) --no-print-directory waveform in=$(entity)_tb.vhdl entity=$(entity)_tb
	@rm -f .entity_name

.PHONY: test_entity_nowave
test_entity_nowave: get_entity_name
	@$(MAKE) --no-print-directory testbench
	@$(MAKE) --no-print-directory import
	@$(eval entity=$(shell cat .entity_name))
	@$(MAKE) --no-print-directory import in=$(entity)_tb.vhdl entity=$(entity)_tb
	@$(MAKE) --no-print-directory build in=$(entity)_tb.vhdl entity=$(entity)_tb
	@$(MAKE) --no-print-directory run_simulation in=$(entity)_tb.vhdl entity=$(entity)_tb
	@rm -f .entity_name

.PHONY: clean
clean: 
	@find . -type f ! \( -name '*.vhdl' -o -name '*.vhd' -o -name 'makefile' \) -delete


# check syntax of input file

.PHONY: syntax
syntax:
ifeq ($(in),0)
	@# Evaluating input file name
	@$(eval in = $(shell if [ $$(find . -type f \( -name '*.vhd' -o -name '*.vhdl' \) | wc -l) -eq 1 ]; then echo $$(find . -type f \( -name '*.vhd' -o -name '*.vhdl' \) | cut -f 2- -d '.' | cut -f 2 -d '/') ; else echo "too_many_files_no_in_error_condition"; fi ))
	@if [ $(in) == "too_many_files_no_in_error_condition" ]; then echo -e "\033[1mSpecify input VHDL file with the in parameter\033[0m" && exit 127; else exit 0; fi
endif
	@echo -e "\033[1m* Checking syntax of \033[0m\033[3m$(in)\033[0m"
	@$(ghdl) -s --std=$(std) $(in)
	@echo -e "\u2714 Syntax is correct"
	



# import input file into current working space

.PHONY: import
import: 
ifeq ($(in),0)
	@# Evaluating input file name
	@$(eval in = $(shell if [ $$(find . -type f \( -name '*.vhd' -o -name '*.vhdl' \) | wc -l) -eq 1 ]; then echo $$(find . -type f \( -name '*.vhd' -o -name '*.vhdl' \) | cut -f 2- -d '.' | cut -f 2 -d '/') ; else echo "too_many_files_no_in_error_condition"; fi ))
	@if [ $(in) == "too_many_files_no_in_error_condition" ]; then echo -e "\033[1mSpecify input VHDL file with the in parameter\033[0m" && exit 127; else exit 0; fi
endif
	@echo -e "\033[1m* Importing \033[0m\033[3m$(in)\033[0m\033[1m into current work cache\033[0m"
	$(ghdl) -i --std=$(std) $(in)



# output executable file

.PHONY: build
build: 
ifeq ($(in),0)
	@# Evaluating input file name
	@$(eval in = $(shell if [ $$(find . -type f \( -name '*.vhd' -o -name '*.vhdl' \) | wc -l) -eq 1 ]; then echo $$(find . -type f \( -name '*.vhd' -o -name '*.vhdl' \) | cut -f 2- -d '.' | cut -f 2 -d '/') ; else echo "too_many_files_no_in_error_condition"; fi ))
	@if [ $(in) == "too_many_files_no_in_error_condition" ]; then echo -e "\033[1mSpecify input VHDL file with the in parameter\033[0m" && exit 127; else exit 0; fi
endif
ifeq ($(entity),0)
	@# Evaluating entity name from input file name
	@#$(eval entity = $(shell echo $(in) | cut -f 1 -d '.'))
	$(eval entity = $(shell cat $(in) | grep entity -m 1 | cut -f 2 -d ' '))
endif
	@$(MAKE) --no-print-directory $(entity) in=$(in) entity=$(entity) std=$(std) 

$(entity): $(in)
	@#@echo $(filter-out $@,$(MAKECMDGOALS) | cut -f 2 -d ' ')
	@echo -e "\033[1m* Building \033[0m\033[3m$(in)\033[0m"
	@# Analyze, elaborate and build exe from top level entity name
	@# Top level entity name is same as that of filename by default
	@# Specify top level entity name with the 'entity' parameter
	$(ghdl) -m --std=$(std) $(entity)





.PHONY: run_simulation
run_simulation:
ifeq ($(in),0)
	@# Evaluating input file name
	@$(eval in = $(shell if [ $$(find . -type f \( -name '*.vhd' -o -name '*.vhdl' \) | wc -l) -eq 1 ]; then echo $$(find . -type f \( -name '*.vhd' -o -name '*.vhdl' \) | cut -f 2- -d '.' | cut -f 2 -d '/') ; else echo "too_many_files_no_in_error_condition"; fi ))
	@if [ $(in) == "too_many_files_no_in_error_condition" ]; then echo -e "\033[1mSpecify input VHDL file with the in parameter\033[0m" && exit 127; else exit 0; fi
endif
ifeq ($(entity),0)
	@# Evaluating entity name from input file name
	@#$(eval entity = $(shell echo $(in) | cut -f 1 -d '.'))
	@$(eval entity = $(shell cat $(in) | grep entity -m 1 | cut -f 2 -d ' '))
endif
	@# Evaluating waveform file name from input file name
	@$(eval ghw = $(shell echo "$(shell echo $(entity) | cut -f 1 -d '.')""_wave.ghw"))
	@echo -e "\033[1m* Running simulation for \033[0m\033[3m$(entity)\033[0m"
	./$(entity) --wave=$(ghw)






.PHONY: waveform
waveform: 
ifeq ($(in),0)
	@# Evaluating input file name
	@$(eval in = $(shell if [ $$(find . -type f \( -name '*.vhd' -o -name '*.vhdl' \) | wc -l) -eq 1 ]; then echo $$(find . -type f \( -name '*.vhd' -o -name '*.vhdl' \) | cut -f 2- -d '.' | cut -f 2 -d '/') ; else echo "too_many_files_no_in_error_condition"; fi ))
	@if [ $(in) == "too_many_files_no_in_error_condition" ]; then echo -e "\033[1mSpecify input VHDL file with the in parameter\033[0m" && exit 127; else exit 0; fi
endif
ifeq ($(entity),0)
	@# Evaluating entity name from input file name
	@#$(eval entity = $(shell echo $(in) | cut -f 1 -d '.'))
	@$(eval entity = $(shell cat $(in) | grep entity -m 1 | cut -f 2 -d ' '))
endif
	@# Evaluating waveform file name from input file name
	@$(eval ghw = $(shell echo "$(shell echo $(entity) | cut -f 1 -d '.')""_wave.ghw"))
	@echo -e "\033[1m* Running gtkwave for \033[0m\033[3m$(ghw)\033[0m"
	@gtkwave $(ghw) -r ../common/gtkwaverc




.PHONY: testbench
testbench:
ifeq ($(in),0)
	@# Evaluating input file name
	@$(eval in = $(shell if [ $$(find . -type f \( -name '*.vhd' -o -name '*.vhdl' \) | wc -l) -eq 1 ]; then echo $$(find . -type f \( -name '*.vhd' -o -name '*.vhdl' \) | cut -f 2- -d '.' | cut -f 2 -d '/') ; else echo "too_many_files_no_in_error_condition"; fi ))
	@if [ $(in) == "too_many_files_no_in_error_condition" ]; then echo -e "\033[1mSpecify input VHDL file with the in parameter\033[0m" && exit 127; else exit 0; fi
endif
ifeq ($(entity),0)
	@# Evaluating entity name from input file name
	@#$(eval entity = $(shell echo $(in) | cut -f 1 -d '.'))
	@$(eval entity = $(shell cat $(in) | grep entity -m 1 | cut -f 2 -d ' '))
endif
	@$(MAKE) --no-print-directory syntax in=$(in) std=$(std) 
	@$(MAKE) --no-print-directory $(entity)_tb.vhdl entity=$(entity) in=$(in) std=$(std) 
	@$(MAKE) --no-print-directory syntax in=$(entity)_tb.vhdl std=$(std) 


$(entity)_tb.vhdl: $(in)
	@echo -e "\033[1m* Making testbench for \033[0m\033[3m$(in)\033[0m"
	@sh -c "export in=$(in); export entity=$(entity); sh ../common/testbench_maker.sh"



.PHONY: get_entity_name
get_entity_name:
ifeq ($(in),0)
	@# Evaluating input file name
	@$(eval in = $(shell if [ $$(find . -type f \( -name '*.vhd' -o -name '*.vhdl' \) | wc -l) -eq 1 ]; then echo $$(find . -type f \( -name '*.vhd' -o -name '*.vhdl' \) | cut -f 2- -d '.' | cut -f 2 -d '/') ; else echo "too_many_files_no_in_error_condition"; fi ))
	@if [ $(in) == "too_many_files_no_in_error_condition" ]; then echo -e "\033[1mSpecify input VHDL file with the in parameter\033[0m" && exit 127; else exit 0; fi
endif
ifeq ($(entity),0)
	@# Evaluating entity name from input file name
	@#$(eval entity = $(shell echo $(in) | cut -f 1 -d '.'))
	@$(eval entity = $(shell cat $(in) | grep entity -m 1 | cut -f 2 -d ' '))
endif
	@echo $(entity) > .entity_name


# ~Subham Roy
# 2017