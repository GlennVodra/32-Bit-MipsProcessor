-------------------------------------------------
-- Company  : Rochester Institute of Technology (RIT)
-- Engineer : Glenn Vodra (GKV4063@rit.edu)
--  File:          WriteBackStage.vhd
--
--  Entity:        WriteBackStage
--  Architecture:  BEHAVIORAL
--  Author:        Glenn Vodra
--  Created:       03/20/23
--  Description:   The following is the entity and
--                 architectural description of
--                 the Writeback Stage
-------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use ieee.std_logic_unsigned.all;

entity WriteBackStage is
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
end entity;

architecture behavioral of WriteBackStage is

begin
	
	result_proc : process (ReadData, MemToReg, ALUResult) is begin
		if MemToReg = '1' then
			Result <= ReadData;
		else
			Result <= ALUResult;
		end if;
	end process;
	
	WriteRegOut <= WriteReg;
	RegWriteOut <= RegWrite;
	
end behavioral;