library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity pc_unit is
    port (
        PC_in : in std_logic_vector(31 downto 0);
        PC_out : out std_logic_vector(31 downto 0);
        Clk, Reset : in std_logic
    );
end pc_unit;

architecture arch of pc_unit is 
begin
    process(Clk, Reset)
    begin
        if Reset = '1' then
            PC_out <= "00000000000000000000000000000000";
        elsif rising_edge(Clk) then
            PC_out <= PC_in;
        end if;
    end process;
end arch ; -- arch