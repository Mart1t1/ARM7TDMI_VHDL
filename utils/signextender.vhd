library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity EXTENDER is
    generic (
        N : integer := 8
    );
    port (
        DataIn      : in std_logic_vector(N - 1 downto 0);
        DataOut     : out std_logic_vector(31 downto 0)
    );
end EXTENDER;

architecture arch of EXTENDER is
begin
    DataOut <= std_logic_vector(resize(signed(DataIn), DataOut'length));
end arch;