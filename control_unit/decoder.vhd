library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity decoder is
    port (
        Instruction : in std_logic_vector(31 downto 0);
        PSR : in std_logic_vector(31 downto 0);
        nPCSel, RegWr, RegSel, ALUSrc, RegAff, MemWr, 
            ALUCtr, PSREn, WrSrc : out std_logic;
    );
end decoder;

architecture arch of decoder is
    type enum_instruction is (MOV, ADDi, ADDr, CMP, LDR, STR, BAL, BLT);
    signal instr_courante : enum_instruction;
begin
    process(Instruction)
    begin
        if Instruction(27 downto 26) = "00" then            -- instruction de traitement
            if Instruction(24 downto 21) = "0101" then      -- ADD
                if Instruction(25) = '1' then               -- ADDi
                else                                        -- ADDr
                end if;
            elsif Instruction(24 downto 21) = "1101" then   -- MOV
            end if;
        elsif Instruction(27 downto 26) = "01" then         -- instruction de transfert
            if Instruction(20) = '1' then                   -- LDR
            else                                            -- STR
            end if;
        elsif Instruction(27 downto 25) = "101" then        -- instruction de branchement relatif                                              -- 
            if Instruction(31 downto 28) = "1110" then      -- BAL
            else -- Instruction(31 downto 28) = "1011"      -- BLT
            end if;
        end if;
    end process;

    process(Instruction, enum_instruction)
    begin
    end process;

end arch ; -- arch