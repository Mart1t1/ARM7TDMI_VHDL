library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity TREATMNT_UNIT_TB is
end entity TREATMNT_UNIT_TB;

architecture Bench of TREATMNT_UNIT_TB is
    signal Clk, Reset, COM1, COM2, WrEn1, WrEn2, C, V, N, Z     : std_logic;
    signal RW, RA, RB : std_logic_vector(3 downto 0);
    signal OP : std_logic_vector(2 downto 0);
    signal Imm : std_logic_vector(7 downto 0);
begin    

    process
    begin
        Reset <= '0';
        COM1 <= '0';
        COM2 <= '0';
        WrEn1 <= '0';
        WrEn2 <= '0';
        RW <= "0000";
        RA <= "0000";
        RB <= "0000";
        OP <= "000";
        Imm <= "00000000";

        Clk <= '0';

        -- Assignation d'une valeur immediate a un registre
        -- i.e. R(15) = 50 => "00110010"

        WrEn1 <= '1'; -- Write Enable in registers
        WrEn2 <= '0'; -- Write disabled in memory
        RW <= "1111"; -- S = R(15)
        RA <= "0000"; -- A = R(0)
        RB <= "0000"; -- busB = R(0)
        OP <= "001"; -- S = B => R(15) = Imm
        COM1 <= '1'; -- B = Imm
        COM2 <= '0'; -- busW = ALUout
        Imm <= "00110010"; -- Imm = 50 => "00110010"

        wait for 5 NS;
        Clk <= '1';
        wait for 5 NS;
        Clk <= '0';

        -- Addition de 2 registres
        -- i.e.  R(1) = R(1) + R(15)

        WrEn1 <= '1'; -- Write Enable in registers
        WrEn2 <= '0'; -- Write desabled in memory
        RW <= "0001"; -- S = R(1)
        RA <= "0001"; -- A = R(1)
        RB <= "1111"; -- busB = R(15)
        OP <= "000"; -- S = A + B => R(1) = R(1) + R(15)
        COM1 <= '0'; -- B = busB
        COM2 <= '0'; -- busW = ALUout
        Imm <= "00000000"; -- Imm = 0

        wait for 5 NS;
        Clk <= '1';
        wait for 5 NS;
        Clk <= '0';
 
        -- Addition d'1 registre avec une valeur immediate
        -- i.e.  R(2) = R(1) + 32

        WrEn1 <= '1'; -- Write Enable in registers
        WrEn2 <= '0'; -- Write desabled in memory
        RW <= "0010"; -- S = R(2)
        RA <= "0001"; -- A = R(1)
        RB <= "0000"; -- busB = R(0)
        OP <= "000"; -- S = A + B => R(2) = R(1) + Imm
        COM1 <= '1'; -- B = Imm
        COM2 <= '0'; -- busW = ALUout
        Imm <= "00100000"; -- Imm = 32

        wait for 5 NS;
        Clk <= '1';
        wait for 5 NS;
        Clk <= '0';

        -- Soustraction de 2 registres
        -- i.e.  R(3) = R(2) - R(1)

        WrEn1 <= '1'; -- Write Enable in registers
        WrEn2 <= '0'; -- Write desabled in memory
        RW <= "0011"; -- S = R(3)
        RA <= "0010"; -- A = R(2)
        RB <= "0001"; -- busB = R(1)
        OP <= "010"; -- S = A - B => R(3) = R(2) - R(1)
        COM1 <= '0'; -- B = busB
        COM2 <= '0'; -- busW = ALUout
        Imm <= "00000000"; -- Imm = 0

        wait for 5 NS;
        Clk <= '1';
        wait for 5 NS;
        Clk <= '0';
        
        -- Soustraction d'une valeur immediate à 1 registre
        -- i.e.  R(4) = R(3) - 20

        WrEn1 <= '1'; -- Write Enable in registers
        WrEn2 <= '0'; -- Write desabled in memory
        RW <= "0100"; -- S = R(4)
        RA <= "0011"; -- A = R(3)
        RB <= "0000"; -- busB = R(0)
        OP <= "010"; -- S = A - B => R(4) = R(3) - Imm
        COM1 <= '1'; -- B = Imm
        COM2 <= '0'; -- busW = ALUout
        Imm <= "00010100"; -- Imm = 20

        wait for 5 NS;
        Clk <= '1';
        wait for 5 NS;
        Clk <= '0';
        
        -- copie d'un registre dans un autre registre
        -- i.e.  R(5) = R(1)

        WrEn1 <= '1'; -- Write Enable in registers
        WrEn2 <= '0'; -- Write desabled in memory
        RW <= "0101"; -- S = R(5)
        RA <= "0001"; -- A = R(1)
        RB <= "0000"; -- busB = R(0)
        OP <= "011"; -- S = A => R(5) = R(1)
        COM1 <= '0'; -- B = busB
        COM2 <= '0'; -- busW = ALUout
        Imm <= "00000000"; -- Imm = 0

        wait for 5 NS;
        Clk <= '1';
        wait for 5 NS;
        Clk <= '0';
        
        -- L'écriture d'un registre dans un mot de la memoire

        WrEn1 <= '0'; -- Write disabled in registers
        WrEn2 <= '1'; -- Write enabled in memory
        RW <= "0000"; -- S = R(0)
        RA <= "0001"; -- A = R(1)
        RB <= "0010"; -- busB = R(2)
        OP <= "011"; -- S = A => ALUout = A => Addr = A(5 downto 0)
        COM1 <= '0'; -- B = busB
        COM2 <= '1'; -- busW = DataOut
        Imm <= "00000000"; -- Imm = 0

        wait for 5 NS;
        Clk <= '1';
        wait for 5 NS;
        Clk <= '0';
        
        -- lecture d'un mot de la memoire dans un registre
        -- i.e.  R(6) = DataOut

        WrEn1 <= '1'; -- Write Enable in registers
        WrEn2 <= '0'; -- Write desabled in memory
        RW <= "0110"; -- S = R(6)
        RA <= "0001"; -- A = R(1)
        RB <= "0000"; -- busB = R(0)
        OP <= "011"; -- S = A =>
        COM1 <= '0'; -- B = busB
        COM2 <= '1'; -- busW = DataOut
        Imm <= "00000000"; -- Imm = 0

        wait for 5 NS;
        Clk <= '1';
        wait for 5 NS;
        Clk <= '0';
        
        wait;     
    end process;

    T1 : entity work.TREATMNT_UNIT port map (Clk=>Clk, Reset=>Reset, COM1=>COM1, COM2=>COM2,
            WrEn1=>WrEn1, WrEn2=>WrEn2, C=>C, V=>V, N=>N, Z=>Z, RW=>RW, RA=>RA, RB=>RB,
            OP=>OP, Imm=>Imm);
end Bench;