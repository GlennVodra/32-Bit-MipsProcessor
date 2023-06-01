-------------------------------------------------
-- Company  : Rochester Institute of Technology (RIT)
-- Engineer : Glenn Vodra (GKV4063@rit.edu)
--  File:          MipsProcessor.vhd
--
--  Entity:        MipsProcessor
--  Architecture:  BEHAVIORAL
--  Author:        Glenn Vodra
--  Created:       03/20/23
--  Description:   The following is the entity and
--                 architectural description of
--                 a partial 32 Mips Processor
-------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity MipsProcessor is
	port(
		clk, rst : in std_logic;
		MemStageWriteData, ALUResult : out std_logic_vector(31 downto 0)
	);
end MipsProcessor;

architecture behavioral of MipsProcessor is

---------------------Instruction Fetch---------------------
				
	component InstructionFetch is 
		port (
			clk : in std_logic;
			rst : in std_logic;
			Instruction : out std_logic_vector(31 DOWNTO 0)
		);
	end component;
	--Output Signal Fetch
	signal InstructionFetchInstructionOUT : std_logic_vector(31 downto 0);
	
---------------------InstructionDecode---------------------
				
	component InstructionDecode is
		port(
			Instruction	: in std_logic_vector(31 downto 0);
			clk			: in std_logic;
			--WB Inputs
			RegWriteAddr : in std_logic_vector(4 downto 0);
			RegWriteData : in std_logic_vector(31 downto 0);
			RegWriteEn	: in std_logic;
		--OUTPUTS --
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
	end component;
	--Output Signals Decode
	signal InstructionDecodeRegWriteOut      : std_logic;
	signal InstructionDecodeMemtoRegOut      : std_logic;
	signal InstructionDecodeMemWriteOut      : std_logic;
	signal InstructionDecodeALUControlOut    : std_logic_vector(3 downto 0);
	signal InstructionDecodeALUSrcOut   	 : std_logic;
	signal InstructionDecodeRegDstOut   	 : std_logic;
	signal InstructionDecodeRD1Out           : std_logic_vector(31 downto 0);
	Signal InstructionDecodeRD2Out           : std_logic_vector(31 downto 0);
	signal InstructionDecodeRtDestOut        : std_logic_vector(4 downto 0);
	signal InstructionDecodeRdDestOut        : std_logic_vector(4 downto 0);
	signal InstructionDecodeImmOutOut        : std_logic_vector(31 downto 0);
	
---------------------Execute Stage---------------------

	component Execute is
		port(
			clk         : in std_logic;
			RegWrite	: in std_logic;
			MemtoReg	: in std_logic;
			MemWrite	: in std_logic;
			ALUControl	: in std_logic_vector(3 downto 0);
			ALUSrc		: in std_logic;
			RegDst		: in std_logic;
	
			RegSrcA, RegSrcB : in std_logic_vector(31 downto 0);
			
			RtDest		: in std_logic_vector(4 downto 0);
			RdDest		: in std_logic_vector(4 downto 0);
			ImmIn		: in std_logic_vector(31 downto 0);
		---- OUTPUTS ----
			RegWriteOut	: out std_logic;
			MemtoRegOut	: out std_logic;
			MemWriteOut	: out std_logic;
			--ALU Result
			ALUResult	: out std_logic_vector(31 downto 0);
			WriteData : out std_logic_vector(31 downto 0);
			WriteReg : out std_logic_vector(4 downto 0)
		);
	end component;
	--Output Signals Execute
	signal ExecuteStageRegWriteOutOut  : std_logic;
	signal ExecuteStageMemtoRegOutOut  : std_logic;
	signal ExecuteStageMemWriteOutOut  : std_logic;
	signal ExecuteStageALUResultOut	   : std_logic_vector(31 downto 0);
	signal ExecuteStageWriteDataOut    : std_logic_vector(31 downto 0);
	signal ExecuteStageWriteRegOut     : std_logic_vector(4 downto 0);

---------------------Memory Stage---------------------

	component MemoryStage is
		port(
			--Inputs
			clk, rst : in std_logic;
			RegWrite, MemtoReg, MemWrite : in std_logic;
			WriteReg : in std_logic_vector(4 downto 0);
			ALUResult : in std_logic_vector(31 downto 0);
			WriteData : in std_logic_vector(31 downto 0);
			switches : in std_logic_vector(15 downto 0); --Switches
			--Outputs
			RegWriteOut, MemtoRegOut : out std_logic;
			WriteRegOut : out std_logic_vector(4 downto 0);
			ALUResultOut, MemOut : out std_logic_vector(31 downto 0);
			Active_Digit : out std_logic_vector(3 downto 0);
			Seven_Seg_Digit : out std_logic_vector(6 downto 0)
		);
	end component;
	--Input
	signal switches : std_logic_vector(15 downto 0):= (others => '0');
	--Output Signals MemStage
	signal MemoryStageRegWriteOutOut  : std_logic;
	signal MemoryStageMemtoRegOutOut  : std_logic;
	signal MemoryStageWriteRegOutOut  : std_logic_vector(4 downto 0);
	signal MemoryStageALUResultOutOut : std_logic_vector(31 downto 0); 
	signal MemoryStageMemOutOut       : std_logic_vector(31 downto 0);
	--Seven Seg
	signal Active_Digit               : std_logic_vector(3 downto 0);
	signal Seven_Seg_Digit            : std_logic_vector(6 downto 0);

---------------------WriteBack Stage---------------------
	
	component WriteBackStage is
		port(
			--Input
			WriteReg : in std_logic_vector(4 downto 0);
			RegWrite, MemToReg : in std_logic;
			ALUResult, ReadData : in std_logic_vector(31 downto 0);
			--Output
			Result : out std_logic_vector(31 downto 0);
			WriteRegOut : out std_logic_vector(4 downto 0);
			RegWriteOut :out std_logic
		);
	end component;
	--Output Signals WriteBack
	signal WriteBackResultOut      : std_logic_vector(31 downto 0);
	signal WriteBackWriteRegOutOut : std_logic_vector(4 downto 0);
	signal WriteBackRegWriteOutOut : std_logic;
	
begin

	FetechStage_Inst : InstructionFetch
		port map(
			clk => clk,
			rst => rst,
			Instruction => InstructionFetchInstructionOUT
		);
	
	InstructionDecode_Inst : InstructionDecode
		port map(
			Instruction	  => InstructionFetchInstructionOUT,
			clk			  => clk,
			RegWriteAddr  => WriteBackWriteRegOutOut,
			RegWriteData  => WriteBackResultOut,
			RegWriteEn    => WriteBackRegWriteOutOut,
			RegWrite	  => InstructionDecodeRegWriteOut,  
			MemtoReg	  => InstructionDecodeMemtoRegOut,  
			MemWrite	  => InstructionDecodeMemWriteOut,  
			ALUControl	  => InstructionDecodeALUControlOut,
			ALUSrc		  => InstructionDecodeALUSrcOut,   
			RegDst		  => InstructionDecodeRegDstOut,   
			RD1           => InstructionDecodeRD1Out,       
			RD2	          => InstructionDecodeRD2Out,       
			RtDest		  => InstructionDecodeRtDestOut,    
		    RdDest		  => InstructionDecodeRdDestOut,    
		    ImmOut		  => InstructionDecodeImmOutOut    
		);
	
	ExecuteStage_Inst : Execute
		port map(
			clk         => clk,
			RegWrite    => InstructionDecodeRegWriteOut,  
		    MemtoReg    => InstructionDecodeMemtoRegOut,  
		    MemWrite    => InstructionDecodeMemWriteOut,  
		    ALUControl  => InstructionDecodeALUControlOut,
		    ALUSrc	    => InstructionDecodeALUSrcOut,   
		    RegDst	    => InstructionDecodeRegDstOut,   	    
		    RegSrcA     => InstructionDecodeRD1Out,       
			RegSrcB     => InstructionDecodeRD2Out,       
		    RtDest		=> InstructionDecodeRtDestOut,    
		    RdDest		=> InstructionDecodeRdDestOut,    
		    ImmIn		=> InstructionDecodeImmOutOut,    
		    RegWriteOut	=> ExecuteStageRegWriteOutOut,
		    MemtoRegOut	=> ExecuteStageMemtoRegOutOut,
		    MemWriteOut	=> ExecuteStageMemWriteOutOut,
		    ALUResult   => ExecuteStageALUResultOut,	 
		    WriteData   => ExecuteStageWriteDataOut,  
		    WriteReg    => ExecuteStageWriteRegOut   
		);

	MemoryStage_Inst : MemoryStage
		port map(
			clk               => clk,
			rst               => rst,
			RegWrite          => ExecuteStageRegWriteOutOut, 
			MemtoReg          => ExecuteStageMemtoRegOutOut,
			MemWrite          => ExecuteStageMemWriteOutOut,
			WriteReg          => ExecuteStageWriteRegOut, 
			ALUResult         => ExecuteStageALUResultOut,
			WriteData         => ExecuteStageWriteDataOut,  
		    switches          => switches,
		    RegWriteOut       => MemoryStageRegWriteOutOut, 
			MemtoRegOut       => MemoryStageMemtoRegOutOut, 
		    WriteRegOut       => MemoryStageWriteRegOutOut, 
		    ALUResultOut      => MemoryStageALUResultOutOut,
			MemOut            => MemoryStageMemOutOut,      
		    Active_Digit      => Active_Digit,   
		    Seven_Seg_Digit   => Seven_Seg_Digit		
		);
	
	WriteBackStage_Inst : WriteBackStage
		port map(
			WriteReg    => MemoryStageWriteRegOutOut,
		    RegWrite    => MemoryStageRegWriteOutOut,
			MemToReg    => MemoryStageMemtoRegOutOut,
		    ALUResult   => MemoryStageALUResultOutOut,
			ReadData    => MemoryStageMemOutOut,      
		    Result      => WriteBackResultOut,     
		    WriteRegOut => WriteBackWriteRegOutOut,
		    RegWriteOut => WriteBackRegWriteOutOut
		);
	
	MemStageWriteData <= ExecuteStageWriteDataOut; 
	ALUResult <= ExecuteStageALUResultOut;
	
end architecture behavioral;