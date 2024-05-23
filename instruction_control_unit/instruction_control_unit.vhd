library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity instruction_control_unit is
    port (
        Offset : in std_logic_vector(23 downto 0);
        nPCsel : in std_logic;
        Instruction : out std_logic_vector(31 downto 0)
    );
end entity

architecture arch of instruction_control_unit is
    signal PC : std_logic_vector(31 downto 0);
    signal Offset_ext : std_logic_vector(31 downto 0);
    signal selected : std_logic_vector(31 downto 0);
begin
    -- make PC_unit with clock and input output
    -- make PCSel_unit with input(PC, Offset_Ext) output(selected)

end arch ; -- arch