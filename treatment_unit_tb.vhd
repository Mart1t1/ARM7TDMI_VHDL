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

    Clk : process
    begin
    while now <= 3000 NS loop
      Clock <= '0';
      wait for 5 NS;
      Clock <= '1';
      wait for 5 NS;
    end loop;
    wait;
    end process;

    process;

    WE <= '1';
    -- R(1) = R(15)
    OP <= "001" -- B
    RW <= "0001";
    RB <= "1111";
    wait for 10 NS;
    -- R(1) = R(1) + R(15)
    OP <= "000"; -- A + B
    RA <= "0001";
    wait for 10 NS;
    -- R(2) = R(1) + R(15)
    RW <= "0010";
    wait for 10 NS;
    -- R(3) = R(1) - R(15)
    OP <= "010"; -- A - B
    RW <= "0011";
    wait for 10 NS;
    -- R(5) = R(7) - R(15)
    RA <= "0111";
    RW <= "0101";
    wait;

    end process;

    TU1 : entity work.TREATMNT_UNIT port map (
        RA => RA, RB => RB, RW => RW, OP => OP, Clk => Clk, Reset => Reset,
        WE => WE, N => N, C => C, V => V, Z => Z
    );

end Bench;