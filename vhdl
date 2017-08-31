#!/bin/zsh

new_vhdl_proj() {
    mkdir $1 && ln -s ../common/makefile ./$1/makefile && cd $1
}

new_vhdl_project() {
    mkdir $1 && ln -s ../common/makefile ./$1/makefile && cd $1
}

vhdl_new_project() {
    mkdir $1 && ln -s ../common/makefile ./$1/makefile && cd $1
}

vhdl_new_proj() {
    mkdir $1 && ln -s ../common/makefile ./$1/makefile && cd $1
}