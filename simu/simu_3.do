vlib work

vcom -93 ../src/memory.vhd
vcom -93 ../src/mux.vhd
vcom -93 ../src/alu.vhd
vcom -93 ../src/signextender.vhd
vcom -93 ../src/reg_bus.vhd
vcom -93 ../src/pc_selection_unit.vhd
vcom -93 ../src/pc_unit.vhd
vcom -93 ../src/instruction_memory.vhd
vcom -93 ../src/instruction_control_unit.vhd
vcom -93 ../src/psr_register_unit.vhd
vcom -93 ../src/decoder.vhd
vcom -93 ../src/control_unit.vhd
vcom -93 control_unit_tb.vhd

vsim control_unit_tb(Bench)

view signals
add wave -radix hexadecimal *
add wave -radix hexadecimal /control_unit_tb/t1/d/*
add wave -radix hexadecimal /control_unit_tb/t1/instruction_unit/instr_mem/*
add wave -radix hexadecimal /control_unit_tb/t1/regaff_unit/*
add wave -radix hexadecimal /control_unit_tb/t1/regpsr/*

run -all