-------------------------------------------------
-- Company  : Rochester Institute of Technology (RIT)
-- Engineer : Glenn Vodra (GKV4063@rit.edu)
--  File:          Execute.vhd
--
--  Entity:        Execute
--  Architecture:  BEHAVIORAL
--  Author:        Glenn Vodra
--  Created:       03/20/23
--  Description:   The following is the entity and
--                 architectural description of
--                 Execute Stage
-------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.globals.all;

entity Execute is
	port(
	--------- INPUTS ------------------
		--Main Input
		clk : in std_logic;
		--Cotrol Unit Signals
		RegWrite	: in std_logic;
		MemtoReg	: in std_logic;
		MemWrite	: in std_logic;
		ALUControl	: in std_logic_vector(3 downto 0);
		ALUSrc		: in std_logic;
		RegDst		: in std_logic;

		--Register File Outputs
		RegSrcA, RegSrcB : in std_logic_vector(31 downto 0);
		--Other Inputs
		RtDest		: in std_logic_vector(4 downto 0);
		RdDest		: in std_logic_vector(4 downto 0);
		ImmIn		: in std_logic_vector(31 downto 0);

	---------- OUTPUTS ----------------
		--Cotrol Unit Passthrough
		RegWriteOut	: out std_logic;
		MemtoRegOut	: out std_logic;
		MemWriteOut	: out std_logic;
		--ALU Result
		ALUResult	: out std_logic_vector(31 downto 0);
		
		--Other Data
		WriteData : out std_logic_vector(31 downto 0);
		WriteReg : out std_logic_vector(4 downto 0)
	);
end entity;

architecture BEHAVIORAL of Execute is
	component ALU32 is 
		port(
        A : IN std_logic_vector (N-1 downto 0);
        B : IN std_logic_vector (N-1 downto 0);
        OP : IN std_logic_vector(3 downto 0);
        Y : OUT std_logic_vector (N-1 downto 0)
    );
	end component;
    
    --Signals
	signal Second_ALU_input : std_logic_vector(31 downto 0);
	
	signal RegWriteOutTBC  : std_logic;
	signal MemtoRegOutTBC  : std_logic;
	signal MemWriteOutTBC  : std_logic;
	signal ALUResultTBC	   : std_logic_vector(31 downto 0);
	signal WriteDataTBC    : std_logic_vector(31 downto 0);
	signal WriteRegTBC     : std_logic_vector(4 downto 0);
	
begin
	
	alu32_int : ALU32 
	port map(
		A  => RegSrcA,
		B  => Second_ALU_input,
		OP => ALUControl,
		Y  => ALUResultTBC
	);
	
	with ALUSrc select
	Second_ALU_input <= RegSrcB         when '0',
						ImmIn           when '1',
						(others => '0') when others;
	
	with RegDst select
	WriteRegTBC <= RtDest          when '0',
				   RdDest          when '1',
				   (others => '0') when others;
	
	WriteDataTBC <= RegSrcB;
	
    --Control Logic
	RegWriteOutTBC <= RegWrite;
	MemtoRegOutTBC <= MemtoReg;
	MemWriteOutTBC <= MemWrite;


	pipeline : process (clk) is begin
		if(rising_edge(clk)) then
			RegWriteOut <= RegWriteOutTBC;
			MemtoRegOut <= MemtoRegOutTBC;
			MemWriteOut <= MemWriteOutTBC;
			ALUResult	<= ALUResultTBC;	 
			WriteData   <= WriteDataTBC;  
			WriteReg    <= WriteRegTBC;   
		end if;
	end process;

end BEHAVIORAL;
	
	