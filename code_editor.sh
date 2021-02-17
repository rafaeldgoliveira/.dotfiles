#!/bin/bash

#extract last argument (the file path)
for last; do true; done

#get all the initial command arguments
all="${@:1:$(($#-1))}"

#launch code with windows path
code $all $last
