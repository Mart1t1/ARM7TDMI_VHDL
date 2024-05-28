library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity decoder is
    port (
        Instruction : in std_logic_vector(31 downto 0);
        PSR : in std_logic_vector(31 downto 0);
        nPCSel, RegWr, RegSel, ALUSrc, RegAff, MemWr, 
            PSREn, WrSrc : out std_logic;
        ALUCtr : out std_logic_vector(2 downto 0)
    );
end decoder;

architecture arch of decoder is
    type enum_instruction is (MOV, ADDi, ADDr, CMP, LDR, STR, BAL, BLT);
    signal instr_courante : enum_instruction;
begin
    process(Instruction)
    begin
        if Instruction(27 downto 26) = "00" then            -- instruction de traitement
            if Instruction(24 downto 21) = "0100" then      -- ADD
                if Instruction(25) = '1' then               -- ADDi
                    instr_courante <= ADDi;
                else                                        -- ADDr
                    instr_courante <= ADDr;
                end if;
            elsif Instruction(24 downto 21) = "1101" then   -- MOV
                instr_courante <= MOV;
            else -- Instruction(24 downto 21) = "1010"      -- CMP
                instr_courante <= CMP;
            end if;
        elsif Instruction(27 downto 26) = "01" then         -- instruction de transfert
            if Instruction(20) = '1' then                   -- LDR
                instr_courante <= LDR;
            else                                            -- STR
                instr_courante <= STR;
            end if;
        elsif Instruction(27 downto 25) = "101" then        -- instruction de branchement relatif                                              -- 
            if Instruction(31 downto 28) = "1110" then      -- BAL
                instr_courante <= BAL;
            else -- Instruction(31 downto 28) = "1011"      -- BLT
                instr_courante <= BLT;
            end if;
        end if;
    end process;

    process(Instruction, instr_courante)
    begin
        case instr_courante is
        when MOV => 
            nPCSel <= '0';
            RegWr <= '1';
            RegSel <= '0'; 
            ALUSrc <= '1';
            RegAff <= '0'; 
            MemWr <= '0';
            ALUCtr <= "001"; -- B
            PSREn <= '0';
            WrSrc <= '0';
        when ADDi => 
            nPCSel <= '0';
            RegWr <= '1';
            RegSel <= '0'; 
            ALUSrc <= '1';
            RegAff <= '0'; 
            MemWr <= '0';
            ALUCtr <= "000"; -- A + B
            PSREn <= '0';
            WrSrc <= '0';
        when ADDr => 
            nPCSel <= '0';
            RegWr <= '1';
            RegSel <= '0'; 
            ALUSrc <= '0';
            RegAff <= '0'; 
            MemWr <= '0';
            ALUCtr <= "000";
            PSREn <= '0';
            WrSrc <= '0';
        when CMP => 
            nPCSel <= '0';
            RegWr <= '0';
            RegSel <= '0'; 
            ALUSrc <= '1';
            RegAff <= '0'; 
            MemWr <= '0';
            ALUCtr <= "010"; -- A - B
            PSREn <= '1';
            WrSrc <= '0';
        when STR => 
            nPCSel <= '0';
            RegWr <= '0';
            RegSel <= '1'; 
            ALUSrc <= '1';
            RegAff <= '1'; 
            MemWr <= '1';
            ALUCtr <= "000"; -- A + B
            PSREn <= '0';
            WrSrc <= '0';
        when LDR => 
            nPCSel <= '0';
            RegWr <= '1';
            RegSel <= '0'; 
            ALUSrc <= '1';
            RegAff <= '0'; 
            MemWr <= '0';
            ALUCtr <= "000";
            PSREn <= '0';
            WrSrc <= '1';
        when BAL => 
            nPCSel <= '1';
            RegWr <= '0';
            RegSel <= '0'; 
            ALUSrc <= '0';
            RegAff <= '0'; 
            MemWr <= '0';
            ALUCtr <= "000";
            PSREn <= '0';
            WrSrc <= '0';
        when BLT =>
            if PSR(31) = '1' then  
                nPCSel <= '1';
            else
                nPCSel <= '0';
            end if;
            RegWr <= '0';
            RegSel <= '0'; 
            ALUSrc <= '0';
            RegAff <= '0'; 
            MemWr <= '0';
            ALUCtr <= "000";
            PSREn <= '0';
            WrSrc <= '0';
        end case;
    end process;

end arch ; -- arch