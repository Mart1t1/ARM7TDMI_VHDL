library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ALU is
    port (
        OP          : in std_logic_vector(2 downto 0);
        A, B        : in std_logic_vector(31 downto 0);
        S           : out std_logic_vector(31 downto 0);
        N, Z, C, V  : out std_logic
    );
end ALU;

architecture arch of ALU is
    signal result : std_logic_vector(32 downto 0);
    signal extA, extB : std_logic_vector(32 downto 0);
begin
    process(OP, A, B, extA, extB, result)
    begin
        extA <= '0' & A;
        extB <= '0' & B;
        case OP is
            when "000" =>
                -- Addition
                result <= std_logic_vector(unsigned(extA) + unsigned(extB)); 
            when "001" =>
                -- B
                result <= extB;
            when "010" =>
                -- Substraction
                result <= std_logic_vector(unsigned(extA) - unsigned(extB));
            when "011" =>
                -- A
                result <= extA;
            when "100" =>
                -- OR
                result <= extA or extB;
            when "101" =>
                -- AND
                result <= extA and extB;
            when "110" =>
                -- XOR
                result <= extA xor extB;
            when "111" =>
                -- NOT A
                result <= not extA;
            when others =>
                result <= extA;
        end case;
        C <= result(32);
        N <= result(31);
        if (A(31) = B(31)) and (A(31) = not result(31)) then
            V <= '1'; else V <= '0';
            end if;
        if (signed(result) = 0) then
            V <= '1'; else V <= '0';
            end if;
        S <= result(31 downto 0);
    end process;
end arch;