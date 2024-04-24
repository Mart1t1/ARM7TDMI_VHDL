library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity TREATMNT_UNIT is
    port (
        Clk, Reset, WE : in std_logic;
        RW, RA, RB : in std_logic_vector(3 downto 0);
        OP : in std_logic_vector(2 downto 0);
        N, C, V, Z : out std_logic;
    );
end TREATMNT_UNIT;

architecture arch of TREATMNT_UNIT is
    signal busA, busB, busW : std_logic_vector(31 downto 0);
begin
    ALU : entity work.ALU port map(busA => A, busB => B, busW => S, OP => OP,
                                    N => N, C => C, V => V, Z => Z);
    BUSREG : entity work.REGBUS port map(Clk => Clk, Reset => Reset, WE => WE, RW => RW,
                                    RA => RA, RB => RB, busA => A, busB => B, busW => W);
end arch;