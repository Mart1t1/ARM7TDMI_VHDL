library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity TREATMNT_UNIT is
    port (
        Clk, Reset      : in std_logic;
        COM1, COM2      : in std_logic;
        WrEn1, WrEn2    : in std_logic;
        RW, RA, RB      : in std_logic_vector(3 downto 0);
        OP              : in std_logic_vector(2 downto 0);
        C, V, Z, N      : out std_logic;
        Imm             : in std_logic_vector(7 downto 0)
    );
end TREATMNT_UNIT;

architecture arch of TREATMNT_UNIT is
    signal busA, busB, busW : std_logic_vector(31 downto 0);
    signal ALUout, DataOut  : std_logic_vector(31 downto 0);
    signal MuxOut, ExtOut   : std_logic_vector(31 downto 0);
begin
    BUSREG : entity work.REGBUS port map (Clk => Clk, Reset => Reset, W => busW,
                A => busA, B => busB, RW => RW, RA => RA, RB => RB, WE => WrEn1);

    ALU : entity work.ALU port map (OP => OP, A => busA, B => MuxOut, S => ALUout,
                N => N, C => C, V => V, Z => Z);

    MUX1 : entity work.mux2 generic map (N => 32)
            port map (COM => COM1, A => busB, B => ExtOut, S => MuxOut);

    MUX2 : entity work.mux2 generic map (N => 32)
            port map (COM => COM2, A => ALUout, B => DataOut, S => busW);

    MEMDATA : entity work.MEMORY port map (Clk => Clk, Reset => Reset, WrEn => WrEn2,
                DataIn => busB, DataOut => DataOut, Addr => ALUout(5 downto 0));
                
    EXTENDER : entity work.EXTENDER port map (DataIn => Imm, DataOut => ExtOut);
end arch;