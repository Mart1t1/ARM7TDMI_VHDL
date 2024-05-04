vlib work

vcom -93 ../alu.vhd
vcom -93 ../reg_bus.vhd
vcom -93 ../../utils/memory.vhd
vcom -93 ../../utils/signextender.vhd
vcom -93 ../../utils/mux.vhd
vcom -93 ../treatment_unit_1-3.vhd 
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