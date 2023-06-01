-------------------------------------------------
-- Company : Rochester Institute of Technology (RIT)
-- Engineer : Glenn Vodra (GKV4063@rit.edu)
--  File:          InstructionMemory.vhd
--
--  Entity:        InstructionMemory
--  Architecture:  BEHAVIORAL
--  Author:        Glenn Vodra
--  Created:       02/21/23
--  Description:   The following is the entity and
--                 architectural description of
--                 Instruction Memory
-------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity InstructionMemory is
	port(
		addr : in std_logic_vector(27 downto 0);
		d_out : out std_logic_vector(31 downto 0)
	);
end InstructionMemory;

architecture BEHAVIORAL of InstructionMemory is
	type mem_type is array (0 to 500) of std_logic_vector(7 downto 0);
	signal mem : mem_type := (
	--Test 1, Each supported instruction
--	 x"22", x"10", x"00", x"0a",
--	 x"22", x"31", x"00", x"0c",
--	 x"00", x"00", x"00", x"00",
--	 x"00", x"00", x"00", x"00",
--	 x"00", x"00", x"00", x"00",
--	 x"02", x"11", x"40", x"20",
--	 x"02", x"11", x"48", x"24",
--	 x"02", x"11", x"50", x"19",
--	 x"02", x"11", x"58", x"25",
--	 x"02", x"11", x"60", x"26",
--	 x"02", x"11", x"68", x"22",
--	 x"32", x"2e", x"ff", x"ff", 
--	 x"36", x"2f", x"00", x"01",
--	 x"3a", x"18", x"00", x"0c",
--	 x"00", x"00", x"00", x"00",
--	 x"00", x"00", x"00", x"00",
--	 x"00", x"00", x"00", x"00",
--	 x"ae", x"38", x"00", x"00",
--	 x"00", x"00", x"00", x"00",
--	 x"00", x"00", x"00", x"00",
--	 x"00", x"00", x"00", x"00",
--	 x"00", x"00", x"00", x"00",
--	 x"8e", x"39", x"00", x"00",
--	 x"00", x"00", x"00", x"00",
--	 x"00", x"00", x"00", x"00",
--	 x"00", x"00", x"00", x"00",
	
	--Fibonacci sequence to 10
x"20", x"08", x"00", x"00",
x"20", x"09", x"00", x"01",
x"20", x"0a", x"03", x"ed",
x"00", x"00", x"00", x"00",
x"00", x"00", x"00", x"00",
x"00", x"00", x"00", x"00",
x"ad", x"49", x"00", x"00",
x"01", x"28", x"40", x"20",
x"00", x"00", x"00", x"00",
x"00", x"00", x"00", x"00",
x"00", x"00", x"00", x"00",
x"21", x"4a", x"00", x"01",
x"00", x"00", x"00", x"00",
x"00", x"00", x"00", x"00",
x"00", x"00", x"00", x"00",
x"ad", x"48", x"00", x"00",
x"01", x"09", x"48", x"20",
x"00", x"00", x"00", x"00",
x"00", x"00", x"00", x"00",
x"00", x"00", x"00", x"00",
x"21", x"4a", x"00", x"01",
x"00", x"00", x"00", x"00",
x"00", x"00", x"00", x"00",
x"00", x"00", x"00", x"00",
x"ad", x"49", x"00", x"00",
x"01", x"28", x"40", x"20",
x"00", x"00", x"00", x"00",
x"00", x"00", x"00", x"00",
x"00", x"00", x"00", x"00",
x"21", x"4a", x"00", x"01",
x"00", x"00", x"00", x"00",
x"00", x"00", x"00", x"00",
x"00", x"00", x"00", x"00",
x"ad", x"48", x"00", x"00",
x"01", x"09", x"48", x"20",
x"00", x"00", x"00", x"00",
x"00", x"00", x"00", x"00",
x"00", x"00", x"00", x"00",
x"21", x"4a", x"00", x"01",
x"00", x"00", x"00", x"00",
x"00", x"00", x"00", x"00",
x"00", x"00", x"00", x"00",
x"ad", x"49", x"00", x"00",
x"01", x"28", x"40", x"20",
x"00", x"00", x"00", x"00",
x"00", x"00", x"00", x"00",
x"00", x"00", x"00", x"00",
x"21", x"4a", x"00", x"01",
x"00", x"00", x"00", x"00",
x"00", x"00", x"00", x"00",
x"00", x"00", x"00", x"00",
x"ad", x"48", x"00", x"00",
x"01", x"09", x"48", x"20",
x"00", x"00", x"00", x"00",
x"00", x"00", x"00", x"00",
x"00", x"00", x"00", x"00",
x"21", x"4a", x"00", x"01",
x"00", x"00", x"00", x"00",
x"00", x"00", x"00", x"00",
x"00", x"00", x"00", x"00",
x"ad", x"49", x"00", x"00",
x"01", x"28", x"40", x"20",
x"00", x"00", x"00", x"00",
x"00", x"00", x"00", x"00",
x"00", x"00", x"00", x"00",
x"21", x"4a", x"00", x"01",
x"00", x"00", x"00", x"00",
x"00", x"00", x"00", x"00",
x"00", x"00", x"00", x"00",
x"ad", x"48", x"00", x"00",
x"01", x"09", x"48", x"20",
x"00", x"00", x"00", x"00",
x"00", x"00", x"00", x"00",
x"00", x"00", x"00", x"00",
x"21", x"4a", x"00", x"01",
x"00", x"00", x"00", x"00",
x"00", x"00", x"00", x"00",
x"00", x"00", x"00", x"00",
x"ad", x"49", x"00", x"00",
x"01", x"28", x"40", x"20",
x"00", x"00", x"00", x"00",
x"00", x"00", x"00", x"00",
x"00", x"00", x"00", x"00",
x"21", x"4a", x"00", x"01",
x"00", x"00", x"00", x"00",
x"00", x"00", x"00", x"00",
x"00", x"00", x"00", x"00",
x"00", x"00", x"00", x"00",
x"ad", x"48", x"00", x"00",
x"00", x"00", x"00", x"00",
x"00", x"00", x"00", x"00",
x"00", x"00", x"00", x"00",
x"00", x"00", x"00", x"00",
	others => (others => '0'));
begin
	d : process (addr) is begin 
		if(to_integer(unsigned(addr)) < 499) then
			d_out(31 downto 24) <= mem(to_integer(unsigned(addr)));
			d_out(23 downto 16) <= mem(to_integer(unsigned(addr))+1);
			d_out(15 downto 8) <= mem(to_integer(unsigned(addr))+2);
			d_out(7 downto 0) <= mem(to_integer(unsigned(addr))+3);
		else
			d_out <= (others => '0');
		end if;
	end process;
end BEHAVIORAL;