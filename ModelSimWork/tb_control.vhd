--------------------------------------------------------------------------------
-- Ehren Fox & Ethan McGill 
-- Department of Electrical and Computer Engineering
-- Iowa State University
--
--------------------------------------------------------------------------------

-- Full ALU Testbench
--------------------------------------------------------------------------------
-- DESCRIPTION: This file contains a Test bench for a 32 bit ALU that can perform 
-- the following functions;   shift left or right (logical) and shift right (arithmetic) 
-- 				and, or, add, sub, xor, nand, nor, and set less than
--
--------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity tb_control is
end tb_control;


architecture behavior of tb_control is
component control
port(i_Instr : in std_logic_vector(31 downto 0);
     o_Raddr1 : out std_logic_vector(4 downto 0);
     o_Raddr2 : out std_logic_vector(4 downto 0);
     o_Waddr : out std_logic_vector(4 downto 0);
     o_Shamt : out std_logic_vector(4 downto 0);
     o_Imme : out std_logic_vector(15 downto 0);
     o_ALUSrc : out std_logic;
     o_ALUOp : out std_logic_vector(5 downto 0);
     o_MemRead : out std_logic;
     o_MemWrite : out std_logic;
     o_RegWrite : out std_logic;
     o_signCont : out std_logic;
     o_luiCont  : out std_logic;
     o_slvCont  : out std_logic;
     o_branchEQ : out std_logic;
     o_branchNE : out std_logic;
     o_jump     : out std_logic;
     o_jalCont     : out std_logic;
     o_jumpReg     : out std_logic);
end component;

signal s_instr : std_logic_vector(31 downto 0);
signal s_addr1, s_addr2, s_waddr, s_shamt : std_logic_vector(4 downto 0);
signal s_aluOp : std_logic_vector(5 downto 0);
signal s_imm : std_logic_vector(15 downto 0);
signal s_ALUSrc, s_MemRead, s_MemWrite, s_RegWrite, s_sign, s_luiCont, s_slvCont, s_branchEQ, s_branchNE, s_jump, s_jalCont, s_jumpReg : std_logic;



	-- Helper Function that will output strings on a modelSim waveform --
	-- Will be beneficial in displaying changes or functions in the wves   --
	signal info, info1 : string(1 to 30);

	  function string_fill(msg : string; len : natural) return string is
		variable res_v : string(1 to len);
	  begin
		res_v := (others => ' ');  -- Fill with spaces to blank all for a start
		res_v(1 to msg'length) := msg;
		return res_v;
	  end function;
	  
begin

controller : control
port map(i_Instr => s_instr,
         o_Raddr1 => s_addr1,
         o_Raddr2 => s_addr2,
         o_Waddr => s_waddr,
         o_Shamt => s_shamt,
         o_Imme => s_imm,
         o_ALUSrc => s_ALUSrc,
         o_ALUOp => s_aluOp,
         o_MemRead => s_MemRead,
         o_MemWrite => s_MemWrite,
         o_RegWrite => s_RegWrite,
         o_signCont => s_sign,
	 o_luiCont => s_luiCont,
	 o_slvCont => s_slvCont,
	 o_branchEQ => s_branchEQ,
	 o_branchNE => s_branchNE,
	 o_jump => s_jump,
	 o_jalCont => s_jalCont,
	 o_jumpReg => s_jumpReg);


process
begin

-------------------------------------------------------------
--Test add throughly here
-------------------------------------------------------------
	info1 <= string_fill("R-TYPE INSTRUCTION", info'length);
	
	
	-- add $1, $2, ,$0
	info <= string_fill("add $1, $2, ,$3", info'length);
	s_instr <= "00000000001000100001100000100000";
	wait for 200 ns;
	
	
-------------------------------------------------------------
--Test addi throughly here
-------------------------------------------------------------
	info1 <= string_fill("I-TYPE INSTRUCTION", info'length);
	
	
	-- addi $1, $2, 7
	info <= string_fill("addi $1, $2, 7", info'length);
	s_instr <= "00100000001000100000000000000111";
	wait for 200 ns;  
	
	
-------------------------------------------------------------
--Test addiu throughly here
-------------------------------------------------------------
	info1 <= string_fill("I-TYPE INSTRUCTION", info'length);
	
	-- addiu $1, $2, 7
	info <= string_fill("addiu $1, $2, 7", info'length);
	s_instr <= "00100000001000100000000000000111";
	wait for 200 ns;

-------------------------------------------------------------
--Test addu throughly here
-------------------------------------------------------------
	info1 <= string_fill("R-TYPE INSTRUCTION", info'length);

	-- addu $1, $2, ,$0
	info <= string_fill("addu $1, $2, ,$3", info'length);
	s_instr <= "00000000001000100001100000100000";
	wait for 200 ns;

-------------------------------------------------------------
-- Test AND throughly here --
-------------------------------------------------------------
	info1 <= string_fill("R-TYPE INSTRUCTION", info'length);
	
	
	-- and $1, $2, ,$0
	info <= string_fill("and $1, $2, ,$3", info'length);
	s_instr <= "00000000001000100001100000100100";
	wait for 200 ns;


-------------------------------------------------------------
--Test andi throughly here
-------------------------------------------------------------
	info1 <= string_fill("I-TYPE INSTRUCTION", info'length);


	-- andi $1, $2, 7
	info <= string_fill("andi $1, $2, 7", info'length);
	s_instr <= "00110000001000100000000000000111";
	wait for 200 ns;  
	
	
-------------------------------------------------------------
--Test lui throughly here
-------------------------------------------------------------
	info1 <= string_fill("I-TYPE INSTRUCTION", info'length);

	-- lui $1, $2, 1
	info <= string_fill("lui $1, $2, 1", info'length);
	s_instr <= "10111100001000100000000000000001";
	wait for 200 ns;

-------------------------------------------------------------
--Test lw throughly here
-------------------------------------------------------------
	info1 <= string_fill("I-TYPE INSTRUCTION", info'length);

	-- lw $1, 0($2)
	info <= string_fill("lw $1, 0($2)", info'length);
	s_instr <= "10001100001000100000000000000001";
	wait for 200 ns;

-------------------------------------------------------------
--Test nor throughly here
-------------------------------------------------------------
	info1 <= string_fill("R-TYPE INSTRUCTION", info'length);

	-- nor $1, $1, $2
	info <= string_fill("nor $1, $1, $2", info'length);
	s_instr <= "00000000001000010001000000100111";
	wait for 200 ns;

-------------------------------------------------------------
--Test xor throughly here
-------------------------------------------------------------
	info1 <= string_fill("R-TYPE INSTRUCTION", info'length);

	-- xor $1, $1, $2
	info <= string_fill("xor $1, $1, $2", info'length);
	s_instr <= "00000000001000010001000000100110";
	wait for 200 ns;

-------------------------------------------------------------
--Test xori throughly here
-------------------------------------------------------------
	info1 <= string_fill("I-TYPE INSTRUCTION", info'length);

	-- xori $1, $2, 1
	info <= string_fill("xori $1, $2, 1", info'length);
	s_instr <= "00111000001000100000000000000001";
	wait for 200 ns;

-------------------------------------------------------------
--Test or throughly here
-------------------------------------------------------------
	info1 <= string_fill("R-TYPE INSTRUCTION", info'length);

	-- or $1, $1, $2
	info <= string_fill("or $1, $1, $2", info'length);
	s_instr <= "00000000001000010001000000100101";
	wait for 200 ns;


-------------------------------------------------------------
--Test ori throughly here
-------------------------------------------------------------
	info1 <= string_fill("I-TYPE INSTRUCTION", info'length);

	-- ori $1, $2, 1
	info <= string_fill("ori $1, $2, 1", info'length);
	s_instr <= "00110100001000100000000000000001";
	wait for 200 ns;

-------------------------------------------------------------
--Test slt throughly here
-------------------------------------------------------------
	info1 <= string_fill("R-TYPE INSTRUCTION", info'length);

	-- slt $1, $1, $2
	info <= string_fill("slt $1, $1, $2", info'length);
	s_instr <= "00000000001000010001000000101010";
	wait for 200 ns;


-------------------------------------------------------------
--Test slti throughly here
-------------------------------------------------------------
	info1 <= string_fill("I-TYPE INSTRUCTION", info'length);

	-- slti $1, $2, 1
	info <= string_fill("slti $1, $2, 1", info'length);
	s_instr <= "00101000001000100000000000000001";
	wait for 200 ns;

-------------------------------------------------------------
--Test sltiu throughly here
-------------------------------------------------------------
	info1 <= string_fill("I-TYPE INSTRUCTION", info'length);
	-- sltiu $1, $2, 1
	info <= string_fill("sltiu $1, $2, 1", info'length);
	s_instr <= "00101100001000100000000000000001";
	wait for 200 ns;

-------------------------------------------------------------
--Test sltu throughly here
-------------------------------------------------------------
	info1 <= string_fill("R-TYPE INSTRUCTION", info'length);
	-- sltu $1, $2, $1
	info <= string_fill("sltu $1, $2, $1", info'length);
	s_instr <= "00000000001000100000100000101011";
	wait for 200 ns;

-------------------------------------------------------------
--Test sll throughly here
-------------------------------------------------------------
	info1 <= string_fill("R-TYPE INSTRUCTION", info'length);

	-- sll $1, $1, 0
	info <= string_fill("sll $1, $1, 0", info'length);
	s_instr <= "00000000001000000000100000000000";
	wait for 200 ns;

-------------------------------------------------------------
--Test srl throughly here
-------------------------------------------------------------
	info1 <= string_fill("R-TYPE INSTRUCTION", info'length);

	-- srl $1, $1, 0
	info <= string_fill("srl $1, $1, 0", info'length);
	s_instr <= "00000000001000000000100000000010";
	wait for 200 ns;

-------------------------------------------------------------
--Test sra throughly here
-------------------------------------------------------------
	info1 <= string_fill("R-TYPE INSTRUCTION", info'length);

	-- sra $1, $1, 0
	info <= string_fill("sra $1, $1, 0", info'length);
	s_instr <= "00000000001000000000100000000011";
	wait for 200 ns;

-------------------------------------------------------------
--Test sllv throughly here
-------------------------------------------------------------
	info1 <= string_fill("R-TYPE INSTRUCTION", info'length);

	-- sllv $1, $1, $2
	info <= string_fill("sllv $1, $1, $2", info'length);
	s_instr <= "00000000001000010001000000000100";
	wait for 200 ns;

-------------------------------------------------------------
--Test srlv throughly here
-------------------------------------------------------------
	info1 <= string_fill("R-TYPE INSTRUCTION", info'length);

	-- srlv $1, $1, $2
	info <= string_fill("srlv $1, $1, $2", info'length);
	s_instr <= "00000000001000010001000000000110";
	wait for 200 ns;

-------------------------------------------------------------
--Test srav throughly here
-------------------------------------------------------------
	info1 <= string_fill("R-TYPE INSTRUCTION", info'length);

	-- srav $1, $1, $2
	info <= string_fill("srav $1, $1, $2", info'length);
	s_instr <= "00000000001000010001000000000111";
	wait for 200 ns;

-------------------------------------------------------------
--Test sw throughly here
-------------------------------------------------------------
	info1 <= string_fill("I-TYPE INSTRUCTION", info'length);

	-- sw $1, 0($2)
	info <= string_fill("sw $1, 0($2)", info'length);
	s_instr <= "10101100001000100000000000000001";
	wait for 200 ns;

-------------------------------------------------------------
--Test sub throughly here
-------------------------------------------------------------

	info1 <= string_fill("R-TYPE INSTRUCTION", info'length);

	-- sub $1, $1, $2
	info <= string_fill("sub $1, $1, $2", info'length);
	s_instr <= "00000000001000010001000000100010";
	wait for 200 ns;

-------------------------------------------------------------
--Test subu throughly here
-------------------------------------------------------------
	info1 <= string_fill("R-TYPE INSTRUCTION", info'length);

	-- subu $1, $1, $2
	info <= string_fill("subu $1, $1, $2", info'length);
	s_instr <= "00000000001000010001000000100010";
	wait for 200 ns;

------------------------------------------------------------
--Test beq
------------------------------------------------------------

info1 <= string_fill("I-TYPE INSTRUCTION", info'length);

	-- beq $1, $2, 1
	info <= string_fill("beq $1, $2, 1", info'length);
	s_instr <= "00010000001000100000000000000001";
	wait for 200 ns;

------------------------------------------------------------
--Test bne
------------------------------------------------------------

info1 <= string_fill("I-TYPE INSTRUCTION", info'length);

	-- bne $1, $2, 1
	info <= string_fill("bne $1, $2, 1", info'length);
	s_instr <= "00010100001000100000000000000001";
	wait for 200 ns;

------------------------------------------------------------
--Test j
------------------------------------------------------------

info1 <= string_fill("I-TYPE INSTRUCTION", info'length);

	-- j 0
	info <= string_fill("j 0", info'length);
	s_instr <= "00001000000000000000000000000000";
	wait for 200 ns;

------------------------------------------------------------
--Test jal
------------------------------------------------------------

info1 <= string_fill("I-TYPE INSTRUCTION", info'length);

	-- jal 0
	info <= string_fill("jal 0", info'length);
	s_instr <= "00001100000000000000000000000000";
	wait for 200 ns;

------------------------------------------------------------
--Test jr
------------------------------------------------------------

info1 <= string_fill("R-TYPE INSTRUCTION", info'length);

	-- jr $31
	info <= string_fill("jr $31", info'length);
	s_instr <= "00000011111000000000000000001000";
	wait for 200 ns;

wait;

end process;
end behavior;

