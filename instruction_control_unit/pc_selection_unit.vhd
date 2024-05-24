library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity pc_selection_unit is
    port (
        Offset : in std_logic_vector(31 downto 0);
        PC : in std_logic_vector(31 downto 0);
        PC_selected : out std_logic_vector(31 downto 0);
        nPCsel : in std_logic
    );
end pc_selection_unit;architecture arch of ent is

architecture arch of pc_selection_unit is
    signal PC_next : std_logic_vector(31 downto 0); 
begin
    process(Offset, PC, nPCsel)
    begin
        PC_next <= std_logic_vector(unsigned(PC) + 1);
        if nPCsel = '1' then
            PC_selected <= std_logic_vector(unsigned(PC_next) + unsigned(Offset));
        else
            PC_selected <= PC_next;
        end if;
    end process;
end arch ; -- arch