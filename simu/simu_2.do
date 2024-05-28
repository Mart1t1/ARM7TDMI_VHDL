vlib work

vcom -93 ../src/signextender.vhd
vcom -93 ../src/pc_selection_unit.vhd
vcom -93 ../src/pc_unit.vhd
vcom -93 ../src/instruction_memory.vhd
vcom -93 ../src/instruction_control_unit.vhd
vcom -93 instruction_control_tb.vhd

vsim instruction_control_tb(Bench)

view signals
add wave -radix hexadecimal *

run -all