vlib work

vcom -93 ../alu.vhd
vcom -93 ../reg_bus.vhd
vcom -93 ../treatment_unit.vhd 
vcom -93 treatment_unit_tb.vhd

vsim treatmnt_unit_tb(Bench)

view signals
add wave -radix hexadecimal *
add wave -radix hexadecimal /treatmnt_unit_tb/tu1/busreg/banc
add wave -radix hexadecimal /treatmnt_unit_tb/tu1/busreg/a
add wave -radix hexadecimal /treatmnt_unit_tb/tu1/busreg/b
add wave -radix hexadecimal /treatmnt_unit_tb/tu1/alu/exta
add wave -radix hexadecimal /treatmnt_unit_tb/tu1/alu/extb

run -all