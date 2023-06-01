-------------------------------------------------
-- Company : Rochester Institute of Technology (RIT)
-- Engineer : Glenn Vodra (GKV4063@rit.edu)
--  File:          InstructionDecode.vhd
--
--  Entity:        InstructionDecode
--  Architecture:  BEHAVIORAL
--  Author:        Glenn Vodra
--  Created:       02/21/23
--  Description:   The following is the entity and
--                 architectural description of
--                 Instruction Decode
-------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity InstructionDecode is
	port(
	--------- INPUTS ------------------
		--Main Input
		Instruction	: in std_logic_vector(31 downto 0);

		--CLK
		clk			: in std_logic;

		--WB Inputs
		RegWriteAddr : in std_logic_vector(4 downto 0);
		RegWriteData : in std_logic_vector(31 downto 0);
		RegWriteEn	: in std_logic;

	---------- OUTPUTS ----------------
		--Cotrol Unit Outputs
		RegWrite	: out std_logic;
		MemtoReg	: out std_logic;
		MemWrite	: out std_logic;
		ALUControl	: out std_logic_vector(3 downto 0);
		ALUSrc		: out std_logic;
		RegDst		: out std_logic;

		--Register File Outputs
		RD1, RD2	: out std_logic_vector(31 downto 0);

		--Other Outputs
		RtDest		: out std_logic_vector(4 downto 0);
		RdDest		: out std_logic_vector(4 downto 0);
		ImmOut		: out std_logic_vector(31 downto 0)
	);
end entity;

architecture BEHAVIORAL of InstructionDecode is
	component RegisterFile is 
		port(
			addr1, addr2 : in std_logic_vector(4 downto 0);
			addr3 : in std_logic_vector(4 downto 0);
			wd : in std_logic_vector(31 downto 0);
			clk, we : in std_logic;
			RD1, RD2 : out std_logic_vector(31 downto 0)
		);
	end component;
	
	component ControlUnit is 
		port(
			Opcode, Funct : in std_logic_vector(5 downto 0);
			RegWrite, MemtoReg, MemWrite, ALUSrc, RegDst : out std_logic;
			ALUControl : out std_logic_vector(3 downto 0)
		);
	end component;
    
    signal ImmSig : std_logic_vector(31 downto 0);
	
	signal RegWriteTBC   : std_logic;
	signal MemtoRegTBC   : std_logic;
	signal MemWriteTBC   : std_logic;
	signal ALUControlTBC : std_logic_vector(3 downto 0);
	signal ALUSrcTBC	 : std_logic;
	signal RegDstTBC	 : std_logic;
	signal RD1TBC,RD2TBC : std_logic_vector(31 downto 0);
	signal RtDestTBC     : std_logic_vector(4 downto 0);
	signal RdDestTBC     : std_logic_vector(4 downto 0);
	signal ImmOutTBC     : std_logic_vector(31 downto 0);
    
begin
	
	RegisterFile1 : RegisterFile
	port map(
		addr1 => Instruction(25 downto 21),
		addr2 => Instruction(20 downto 16),
		addr3 => RegWriteAddr,
		wd => RegWriteData,
		clk => clk,
		we => RegWriteEn,
		RD1 => RD1TBC,
		RD2 => RD2TBC
	);
	
	ControlUnit1 : ControlUnit
	port map(
		Opcode => Instruction(31 downto 26),
		Funct => Instruction(5 downto 0),
		RegWrite => RegWriteTBC,
		MemtoReg => MemtoRegTBC,
		MemWrite => MemWriteTBC,
		ALUSrc => ALUSrcTBC,
		RegDst => RegDstTBC,
		ALUControl => ALUControlTBC
	);
	
	RtDestTBC <= Instruction(20 downto 16);
	
	RdDestTBC <= Instruction(15 downto 11);
	
	ImmSig(15 downto 0) <= Instruction(15 downto 0);
	signExtend : for i in 31 downto 16 generate 
		ImmSig(i) <= ImmSig(15);
	end generate signExtend;
	
	ImmOutTBC <= ImmSig;
	
	pipeline : process (clk) is begin
		if(rising_edge(clk)) then
			RegWrite	<= RegWriteTBC;  
			MemtoReg	<= MemtoRegTBC;  
			MemWrite	<= MemWriteTBC;  
			ALUControl	<= ALUControlTBC;
			ALUSrc		<= ALUSrcTBC;	
			RegDst		<= RegDstTBC;	
			RD1         <= RD1TBC;
			RD2         <= RD2TBC;    
			RtDest		<= RtDestTBC;    
			RdDest		<= RdDestTBC;    
			ImmOut		<= ImmOutTBC;
		end if;
	end process;

end BEHAVIORAL;
	
	