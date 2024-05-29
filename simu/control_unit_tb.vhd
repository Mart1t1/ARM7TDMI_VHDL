library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity control_unit_tb is
end entity control_unit_tb;

architecture Bench of control_unit_tb is
    signal Clk, Reset : std_logic;
    signal Afficheur : std_logic_vector(31 downto 0);

begin
    T1 : entity work.control_unit port map(Clk => Clk, Reset => Reset, Afficheur => Afficheur);
    process
    begin

        Clk <= '0';
        Reset <= '1';

        wait for 5 ns;

        Reset <= '0';
        Clk <= '1';
       
        for i in 60 downto 0 loop

            wait for 5 ns;

            Clk <= '0';

            wait for 5 ns;

            Clk <= '1';
        
            wait for 5 ns;

        end loop;
        wait;
    end process;
end Bench;