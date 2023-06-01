-------------------------------------------------
-- Company : Rochester Institute of Technology (RIT)
-- Engineer : Glenn Vodra (GKV4063@rit.edu)
--  File:          InstructionFetch.vhd
--
--  Entity:        InstructionFetch
--  Architecture:  BEHAVIORAL
--  Author:        Glenn Vodra
--  Created:       02/21/23
--  Description:   The following is the entity and
--                 architectural description of
--                 Instruction Fetch
-------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity InstructionFetch is 
	port (
		clk : in std_logic;
		rst : in std_logic;
		Instruction : out std_logic_vector(31 DOWNTO 0)
	);
end InstructionFetch;

architecture BEHAVIORAL of InstructionFetch is
	Component InstructionMemory
		port(
			addr : in std_logic_vector(27 downto 0);
			d_out : out std_logic_vector(31 downto 0)
		);
	end component;
	
	signal mem_addr : std_logic_vector(27 downto 0) := (others => '0');
	
	signal InstructionTBC : std_logic_vector(31 downto 0);
	
begin

	memory_inst : InstructionMemory
		port map (
			addr => mem_addr,
			d_out => InstructionTBC
		);
	
	PC_update : process (clk, rst) is begin
		if (rst = '1') then
			mem_addr <= (others => '0');
		elsif rising_edge(clk) then
			mem_addr <= mem_addr + 4;
		end if;
	end process;
	
	pipeline : process (clk) is begin
		if(rising_edge(clk)) then
			Instruction <= InstructionTBC;
		end if;
	end process;

end BEHAVIORAL;	