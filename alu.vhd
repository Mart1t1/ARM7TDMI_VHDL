library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ALU is
    port (
        OP          : in std_logic_vector(2 downto 0);
        A, B        : in std_logic_vector(32 downto 0);
        S           : out std_logic_vector(31 downto 0);
        N, Z, C, V  : out std_logic;
    );
end ALU;

architecture arch of ALU is
    signal result : std_logic_vector(32 downto 0);
begin
    process(OP, A, B)
    begin
        case OP is
            when "000" =>
                -- Addition
                result <= A + B; 
            when "001" =>
                -- B
                result <= B;
            when "010" =>
                -- Substraction
                result <= A - B;
            when "011" =>
                -- A
                result <= A;
            when "100" =>
                -- OR
                result <= A or B;
            when "101" =>
                -- AND
                result <= A and B;
            when "110" =>
                -- XOR
                result <= A xor B;
            when "111" =>
                -- NOT A
                result <= not A;
        end case;
        C <= result(32);
        N <= result(31);
        V <= (A(31) = B(31)) and (A(31) = not result(31));
        Z <= (result = (std_logic_vector(to_unsigned(0, 33))));
        S <= result(31 downto 0);
    end process;
end arch;