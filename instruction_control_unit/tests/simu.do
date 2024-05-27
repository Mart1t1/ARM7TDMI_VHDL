vlib work

vcom -93 ../../utils/signextender.vhd
vcom -93 ../pc_selection_unit.vhd
vcom -93 ../pc_unit.vhd
vcom -93 ../instruction_memory.vhd
vcom -93 ../instruction_control_unit.vhd
vcom -93 instruction_control_tb.vhd

vsim instruction_control_tb(Bench)

view signals
add wave -radix hexadecimal *

run -all