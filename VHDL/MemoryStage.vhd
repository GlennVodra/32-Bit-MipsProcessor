-------------------------------------------------
-- Company  : Rochester Institute of Technology (RIT)
-- Engineer : Glenn Vodra (GKV4063@rit.edu)
--  File:          MemoryStage.vhd
--
--  Entity:        MemoryStage
--  Architecture:  BEHAVIORAL
--  Author:        Glenn Vodra
--  Created:       03/20/23
--  Description:   The following is the entity and
--                 architectural description of
--                 the Memory Stage
-------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use ieee.std_logic_unsigned.all;

entity MemoryStage is
	port(
		--Inputs
		clk, rst : in std_logic;
		RegWrite, MemtoReg, MemWrite : in std_logic;
		WriteReg : in std_logic_vector(4 downto 0);
		ALUResult : in std_logic_vector(31 downto 0);
		WriteData : in std_logic_vector(31 downto 0);
		switches : in std_logic_vector(15 downto 0);
		--Outputs
		RegWriteOut, MemtoRegOut : out std_logic;
		WriteRegOut : out std_logic_vector(4 downto 0);
		ALUResultOut, MemOut : out std_logic_vector(31 downto 0);
		Active_Digit : out std_logic_vector(3 downto 0);
		Seven_Seg_Digit : out std_logic_vector(6 downto 0)
	);
end MemoryStage;

architecture behavioral of MemoryStage is
	component data_memory is
		port(
			clk, W_EN : in std_logic;
			ADDR : in std_logic_vector(9 downto 0);
			D_IN : in std_logic_vector(31 downto 0);
			Switches : in std_logic_vector(15 downto 0);
			D_out : out std_logic_vector(31 downto 0);
		    Seven_Seg : out std_logic_vector(15 downto 0)
		);
	end component;
		
	component SevenSegController is
		port(
			clk	: in std_logic;
			rst : in std_logic;
			display_number : in std_logic_vector(15 downto 0);
			active_segment : out std_logic_vector(3 downto 0);
			led_out : out std_logic_vector(6 downto 0)
		);
	end component;
		
	
	Signal Seven_Seg_Dat : std_logic_vector(15 downto 0) := (others => '0');
	
	signal RegWriteOutTBC  : std_logic;
	signal MemtoRegOutTBC  : std_logic;
	signal WriteRegOutTBC  : std_logic_vector(4 downto 0);
	signal ALUResultOutTBC : std_logic_vector(31 downto 0);
		
begin

	mem : data_memory
		port map(
			clk => clk,
			W_EN => MemWrite,
			ADDR => ALUResult(9 downto 0),
			D_IN => WriteData,
			Switches => Switches,
			D_out => MemOut,
			Seven_Seg => Seven_Seg_Dat
		);
	
	display : SevenSegController
		port map(
			clk => clk,
			rst => rst,
			display_number => Seven_Seg_Dat,
			active_segment => Active_Digit,
			led_out => Seven_Seg_Digit
		);
		
	RegWriteOutTBC  <= RegWrite;
	MemtoRegOutTBC  <= MemtoReg;
	
	WriteRegOutTBC  <= WriteReg;
	ALUResultOutTBC <= ALUResult;
	
	pipeline : process (clk) is begin
		if(rising_edge(clk)) then
			RegWriteOut  <= RegWriteOutTBC; 
			MemtoRegOut  <= MemtoRegOutTBC;
			WriteRegOut  <= WriteRegOutTBC; 
			ALUResultOut <= ALUResultOutTBC;
		end if;
	end process;
	
end behavioral;
	