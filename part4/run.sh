#! /bin/bash
file_name="main"
vlog -sv ${file_name}.sv && vsim -c -keepstdout ${file_name} -do "add wave *;run -all;quit"
