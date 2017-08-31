ghdl := ghdl
gtkwave := gtkwave
in = main.vhdl

.PHONY: make
make: $(in) syntax import build run_simulation waveform

.PHONY: clean
clean: 
	@find . -type f ! \( -name '*.vhdl' -o -name '*.vhd' -o -name 'makefile' \) -delete

.PHONY: import
import: eval_if $(in) eval_entity eval_ghw 
	@echo -e "\033[1m* Importing \033[4m$(in)\033[0m\033[1m into current work cache\033[0m"
	$(ghdl) -i $(in)

.PHONY: build
build: eval_if eval_entity eval_ghw $(in)
	@#@echo $(filter-out $@,$(MAKECMDGOALS) | cut -f 2 -d ' ')
	@echo -e "\033[1m* Building \033[4m$(in)\033[0m"
	@# Analyze, elaborate and build exe from top level entity name
	@# Top level entity name is same as that of filename by default
	@# Specify top level entity name with the 'entity' parameter
	$(ghdl) -m $(entity)

.PHONY: run_simulation
run_simulation: eval_if eval_entity eval_ghw $(in) $(entity)
	@echo -e "\033[1m* Running simulation for \033[4m$(entity)\033[0m"
	./$(entity) --wave=$(ghw)

.PHONY: waveform
waveform: eval_if eval_entity eval_ghw $(in) $(ghw)
	@echo -e "\033[1m* Running gtkwave for \033[4m$(ghw)\033[0m"
	@gtkwave $(ghw) -r ../common/gtkwaverc

.PHONY: syntax
syntax: $(in)
	@echo -e "\033[1m* Checking syntax of \033[4m$(in)\033[0m"
	@$(ghdl) -s $(in)
	@echo -e "\u2714 Syntax is correct"

.PHONY: make_tb
make_tb: eval_if eval_entity $(in)
	@echo -e "\033[1m* Making testbench for \033[4m$(in)\033[0m"
	@sh -c "export in=$(in); export entity=$(entity); sh ../common/testbench_maker.sh"

.PHONY: tb_and_make
tb_and_make: make_tb 
	@make import in=$(in) && make in=$(entity)_tb.vhdl

$(ghw):

$(entity): 

.PHONY: eval_if
eval_if:
	@# Evaluating in name
	$(eval in = $(shell if [ $$(find . -type f \( -name '*.vhd' -o -name '*.vhdl' \) | wc -l) -eq 1 ]; then echo $$(find . -type f \( -name '*.vhd' -o -name '*.vhdl' \) | cut -f 2- -d '.' | cut -f 2 -d '/') ; else echo "too_many_files_no_in_error_condition"; fi ))
	@if [ $(in) == "too_many_files_no_in_error_condition" ]; then echo -e "\033[1mSpecify input VHDL file with the in parameter\033[0m" && exit 127; else exit 0; fi

.PHONY: eval_entity
eval_entity:
	@# Evaluating entity name from input file name
	@#$(eval entity = $(shell echo $(in) | cut -f 1 -d '.'))
	$(eval entity = $(shell cat $(in) | grep entity | cut -f 2 -d ' '))

.PHONY: eval_ghw
eval_ghw:
	@# Evaluating waveform file name from input file name
	$(eval ghw = $(shell echo "$(shell echo $(entity) | cut -f 1 -d '.')""_wave.ghw"))

# ~Subham Roy
#  2017