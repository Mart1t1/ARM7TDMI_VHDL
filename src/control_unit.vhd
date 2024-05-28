library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity control_unit is
    port (
        Clk, Reset : in std_logic;
        Afficheur : out std_logic_vector(31 downto 0)
    );
end control_unit;

architecture arch of control_unit is
    signal Instruction : std_logic_vector(31 downto 0);
    signal BusA, BusB, BusW, BusALU : std_logic_vector(31 downto 0);
    signal FlagsNCVZ : std_logic_vector(31 downto 0);
    signal BusRes : std_logic_vector(31 downto 0); -- result of ALU operation
    signal OutPSR : std_logic_vector(31 downto 0);
    signal ImmExt : std_logic_vector(31 downto 0);
    signal BusMem : std_logic_vector(31 downto 0);
    signal nPCSel, RegWr, RegSel, ALUSrc, RegAff, MemWr,
        PSREn, WrSrc : std_logic;
    signal ALUCtr : std_logic_vector(3 downto 0);
    signal RegMuxOut : std_logic_vector(3 downto 0); -- output of Rm/Rd mux
    -- sub signals
    alias Rd : std_logic_vector(3 downto 0) is Instruction(15 downto 12); 
    alias Rn : std_logic_vector(3 downto 0) is Instruction(19 downto 16); 
    alias Rm : std_logic_vector(3 downto 0) is Instruction(3 downto 0); 
    alias Imm24 : std_logic_vector(23 downto 0) is Instruction(23 downto 0);
    alias Imm8 : std_logic_vector(7 downto 0) is Instruction(7 downto 0);
begin
    D : entity work.decoder port map(Instruction => Instruction, PSR => OutPSR
        nPCSel => nPCSel, RegWr => RegWr, RegSel => RegSel, ALUSrc => ALUSrc, RegAff => RegAff,
        MemWr => MemWr, PSREn => PSREn, WrSrc => WrSrc, ALUCtr => ALUCtr);
    
    MUX1 : entity work.mux2 generic map (N => 4) port map(S => RegMuxOut, A => Rm, B => Rd, COM => RegSel);
    
    MUX2 : entity work.mux2 generic map (N => 32) port map(S => BusALU, A => BusB, B => ImmExt, COM => ALUSrc);

    MUX3 : entity work.mux2 generic map (N => 32) port map(S => BusW, A => BusRes, B => BusMem, COM => WrSrc);

    RegBench : entity work.REGBUS port map(Clk => Clk, Reset => Reset, W => BusW, A => BusA, B => BusB,
        WE => RegWr, RW => Rd, RA => Rn, RB => RegMuxOut);

    ImmExtender : entity work.EXTENDER port map(DataIn => Imm8, DataOut = > ImmExt);

    ALU : entity work.ALU port map(OP => ALUCtr, A => BusA, B => BusALU, S => BusRes, N => FlagsNCVZ(31),
        C => FlagsNCVZ(30), V => FlagsNCVZ(29), Z => FlagsNCVZ(28));
    
    RegPSR : entity work.BReg port map(Clk => Clk, Rst => Reset, WE => PSREn, DataIN => FlagsNCVZ, DataOUT => OutPSR);

    RegAff_unit : entity work.BReg port map(Clk => Clk, Rst => Reset, WE => RegAff, DataIN => BusB, DataOUT => Afficheur);

    Mem : entity work.MEMORY port map(Clk => Clk, Reset => Reset, WrEn => MemWr, DataIn => BusB, DataOut => BusMem, Addr => BusRes);

    Instruction_unit : entity work.instruction_control_unit port map(Clk => Clk, Reset => Reset, Offset => Imm24, nPCsel => nPCSel, Instruction => Instruction);

end arch ; -- arch