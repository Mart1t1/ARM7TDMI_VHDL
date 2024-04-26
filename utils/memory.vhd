library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity MEMORY is
  port(
    Clk, Reset, WrEn: in std_logic;
    DataIn: in std_logic_vector(31 downto 0);
    DataOut: out std_logic_vector(31 downto 0);
    Addr: std_logic_vector(5 downto 0); -- Input AND OUTPUT
);
end MEMORY;

architecture arch of MEMORY is
  type table is array(63 downto 0) of std_logic_vector(31 downto 0);

  function init_MEMORY return table is
    variable cleanROM: table;
  begin
    for i in 63 downto 0 loop
      cleanROM(i) := (others => '0');
    end loop;
    return cleanROM;
  end init_MEMORY;

    signal MEMORY_ARRAY: table := init_MEMORY;

  begin
    process(Clk, Reset, WrEn, Addr)
    begin
      DataOut <= MEMORY_ARRAY(to_integer(unsigned(Addr));
      if Reset = '1' then
        MEMORY_ARRAY := init_MEMORY;
      elsif rising_edge(Clk) then
        if WrEn = '1' then
          MEMORY_ARRAY(to_integer(unsigned(Addr)) <= DataIn;
        end if;
      end if;
    end process;
  end arch;