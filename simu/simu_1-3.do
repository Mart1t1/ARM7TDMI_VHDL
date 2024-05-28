vlib work

vcom -93 ../src/alu.vhd
vcom -93 ../src/reg_bus.vhd
vcom -93 ../src/memory.vhd
vcom -93 ../src/signextender.vhd
vcom -93 ../src/mux.vhd
vcom -93 ../src/treatment_unit_1-3.vhd 
vcom -93 treatment_unit_tb_1-3.vhd

vsim treatmnt_unit_tb(Bench)

view signals
add wave -radix hexadecimal *
add wave -radix hexadecimal /treatmnt_unit_tb/t1/memdata/datain
add wave -radix hexadecimal /treatmnt_unit_tb/t1/memdata/dataout
add wave -radix hexadecimal /treatmnt_unit_tb/t1/memdata/memory_array
add wave -radix hexadecimal /treatmnt_unit_tb/t1/memdata/addr
add wave -radix hexadecimal /treatmnt_unit_tb/t1/busreg/banc

run -all