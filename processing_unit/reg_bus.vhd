library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity REGBUS is
    port (
        Clk     : in std_logic;
        Reset   : in std_logic;
        W       : in std_logic_vector(31 downto 0);
        A, B    : out std_logic_vector(31 downto 0);
        RA, RB  : in std_logic_vector(3 downto 0);
        RW      : in std_logic_vector(3 downto 0);
        WE      : in std_logic
    );
end REGBUS;

architecture arch of REGBUS is
    -- Declaration Type Tableau Memoire
    type table is array(15 downto 0) of std_logic_vector(31 downto 0);
    
    -- Fonction d'Initialisation du Banc de Registres
    function init_banc return table is
        variable result : table;
        begin
        for i in 14 downto 0 loop
            result(i) := (others => '0');
        end loop;
        result(15) := X"00000030";
        return result;
    end init_banc;
    -- Déclaration et Initialisation du Banc de Registres 16x32 bits
    signal Banc : table := init_banc;

begin
    A <= Banc(to_integer(unsigned(RA)));
    B <= Banc(to_integer(unsigned(RB)));
    process(Clk, Reset)
    begin
        if Reset = '1' then
            Banc <= init_banc;
        elsif rising_edge(Clk) then
            if WE = '1' then
                Banc(to_integer(unsigned(RW))) <= W;
            end if;
        end if;
    end process;
end arch;