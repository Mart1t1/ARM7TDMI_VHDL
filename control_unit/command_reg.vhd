library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity BReg is
  port(
    DataIN    : in std_logic_vector(32 downto 0);
    Rst, Clk  : in std_logic;
    WE        : in std_logic;
    DataOUT   : out std_logic_vector(32 downto 0);
);
end BReg;

architecture arch of BReg is
begin
  process(Clk, Rst)
  begin
    if Rst = '1' then
      DataOUT <= (others => '0');
    elsif rising_edge(Clk) then
      if WE = '1' then
        DataOUT <= DataIN;
      end if;
    end if;
  end process;
end arch;