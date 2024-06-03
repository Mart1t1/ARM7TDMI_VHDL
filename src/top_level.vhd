library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.ALL;

entity arm7 is
    port(
        MAX10_CLK1_50 : in std_logic;
        KEY: in std_logic_vector (1 downto 0);
        SW: in std_logic_vector (9 downto 0);

        LEDR: out std_logic_vector(9 downto 0);

        HEX0             :  OUT  STD_LOGIC_VECTOR(0 TO 6);
        HEX1             :  OUT  STD_LOGIC_VECTOR(0 TO 6);
        HEX2             :  OUT  STD_LOGIC_VECTOR(0 TO 6);
        HEX3             :  OUT  STD_LOGIC_VECTOR(0 TO 6)

    );

    end entity;

architecture RTL of arm7 is
    signal Clk, Rst, RegAff: std_logic;
    signal regAffOut : std_logic_vector(31 downto 0);
begin
    Clk <= not KEY(0) when SW(0) = '1' else MAX10_CLK1_50;
    Rst <= not KEY(1);

    LEDR(9) <= Clk;
    LEDR(8) <= Rst;
    LEDR(7) <= RegAff;
    LEDR(6 downto 0) <= RegAffOut(6 downto 0);

    CPU: entity work.control_unit
        port map (
            Clk => Clk,
            Rst => Resest,
            regAffOut => Afficheur
        );
    
    SevenSeg0: entity work.SEVEN_SEG port map (RegAff, RegAffOut(3 downto 0), HEX0);
    SevenSeg1: entity work.SEVEN_SEG port map (RegAff, RegAffOut(7 downto 4), HEX1);
    SevenSeg2: entity work.SEVEN_SEG port map (RegAff, RegAffOut(11 downto 8), HEX2);
    SevenSeg3: entity work.SEVEN_SEG port map (RegAff, RegAffOut(15 downto 12), HEX3);
    
end architecture;
