library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity instruction_control_tb is
end entity instruction_control_tb;

architecture Bench of instruction_control_tb is
    signal Clk, Reset, nPCsel : std_logic;
    signal Instruction : std_logic_vector(31 downto 0);
    signal Offset : std_logic_vector(23 downto 0); 
begin
    T1 : entity work.instruction_control_unit port map(Clk => Clk, Reset => Reset,
            nPCsel => nPCsel, Instruction => Instruction, Offset => Offset );
    
    process
    begin

        Reset <= '1';

        wait for 5 ns;

        Reset <= '0';
        Clk <= '0';
        Offset <= (others => '0');
        nPCsel <= '0';

        wait for 5 ns;

        Clk <= '1';

        wait for 5 ns;

        Clk <= '0';

        wait for 5 ns;

        Offset <= "111111111111111111111110"; -- -2 because PC => PC + 1 + Offset
        nPCsel <= '1';
        Clk <= '1';

        wait for 5 ns;

        Clk <= '0'; 

        wait for 5 ns;

        Clk <= '1';

        wait for 5 ns;

        Clk <= '0';

        wait;

    end process;

end Bench ; -- Bench