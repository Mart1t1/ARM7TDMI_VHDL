library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity instruction_control_unit is
    port (
        Offset : in std_logic_vector(23 downto 0);
        nPCsel : in std_logic;
        Instruction : out std_logic_vector(31 downto 0);
        Clk, Reset : in std_logic
    );
end instruction_control_unit;

architecture arch of instruction_control_unit is
    signal PC : std_logic_vector(31 downto 0);
    signal Offset_ext : std_logic_vector(31 downto 0);
    signal selected : std_logic_vector(31 downto 0);
begin
    -- make PC_unit with clock and input output
    PC_unit : entity work.pc_unit port map(PC_in => selected, PC_out => PC, Clk => Clk, Reset => Reset);
    -- make PCSel_unit with input(PC, Offset_Ext) output(selected)
    PC_selection : entity work.pc_selection_unit port map(Offset => Offset_ext, PC => PC,
                PC_selected => selected, nPCsel => nPCsel);
    SignExt : entity work.EXTENDER generic map(N => 24) 
                port map(DataIn => Offset, DataOut => Offset_ext);
    Instr_mem : entity work.instruction_memory port map(PC => PC, Instruction => Instruction);
end arch ; -- arch