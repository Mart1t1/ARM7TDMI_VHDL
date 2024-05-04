library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity TREATMNT_UNIT_TB is
end entity TREATMNT_UNIT_TB;

architecture Bench of TREATMNT_UNIT_TB is
    signal RA, RB, RW                   : std_logic_vector(3 downto 0);
    signal OP                           : std_logic_vector(2 downto 0);
    signal Clk, Reset, WE, N, C, V, Z   : std_logic;
begin

    TU1 : entity work.TREATMNT_UNIT port map (
        RA => RA, RB => RB, RW => RW, OP => OP, Clk => Clk, Reset => Reset,
        WE => WE, N => N, C => C, V => V, Z => Z
    );

    process
    begin
    Clk <= '0'; 
    WE <= '1';
    -- R(1) = R(15)
    OP <= "001"; -- B
    RW <= "0001";
    RB <= "1111";
    wait for 5 NS;
    Clk <= '1';
    wait for 5 NS;
    Clk <= '0';
    -- R(1) = R(1) + R(15)
    OP <= "000"; -- A + B
    RA <= "0001";
    wait for 5 NS;
    Clk <= '1';
    wait for 5 NS;
    Clk <= '0';
    -- R(2) = R(1) + R(15)
    RW <= "0010";
    wait for 5 NS;
    Clk <= '1';
    wait for 5 NS;
    Clk <= '0';
    -- R(3) = R(1) - R(15)
    OP <= "010"; -- A - B
    RW <= "0011";
    wait for 5 NS;
    Clk <= '1';
    wait for 5 NS;
    Clk <= '0';
    -- R(5) = R(7) - R(15)
    RA <= "0111";
    RW <= "0101";
        wait for 5 NS;
    Clk <= '1';
    wait for 5 NS;
    Clk <= '0';
    wait;

    end process;
end Bench;