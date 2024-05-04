vlib work

vcom -2008 ../alu.vhd
vcom -2008 ../reg_bus.vhd
vcom -2008 ../treatment_unit_1-2.vhd 
vcom -2008 treatment_unit_tb_1-2.vhd

vsim treatmnt_unit_tb(Bench)

view signals
add wave -radix hexadecimal *
add wave -radix hexadecimal /treatmnt_unit_tb/tu1/busreg/banc
add wave -radix hexadecimal /treatmnt_unit_tb/tu1/busreg/a
add wave -radix hexadecimal /treatmnt_unit_tb/tu1/busreg/b
add wave -radix hexadecimal /treatmnt_unit_tb/tu1/alu/exta
add wave -radix hexadecimal /treatmnt_unit_tb/tu1/alu/extb

run -all