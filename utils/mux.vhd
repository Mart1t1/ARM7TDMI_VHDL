library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity mux2 is
  Generic(
  N : integer;
  );
  port(
    COM: in std_logic;
    A,B : in std_logic_vector(N-1 downto 0);
    S: out std_logic_vector(N-1 downto 0);
);

architecture arch of mux2 is
begin:
  S <= A when (COM = '0') else B;
end arch;
