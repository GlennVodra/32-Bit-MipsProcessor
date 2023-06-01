-------------------------------------------------
-- Company  : Rochester Institute of Technology (RIT)
-- Engineer : Glenn Vodra (GKV4063@rit.edu)
--  File:          data_memory.vhd
--
--  Entity:        data_memory
--  Architecture:  DATAFLOW
--  Author:        Glenn Vodra
--  Created:       02/21/23
--  Description:   The following is the entity and
--                 DATAFLOW description of
--                 MIPS DATA MEMORY
-------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use ieee.std_logic_unsigned.all;

entity data_memory is
	port(
		clk, W_EN : in std_logic;
		ADDR : in std_logic_vector(9 downto 0);
		D_IN : in std_logic_vector(31 downto 0);
		Switches : in std_logic_vector(15 downto 0);
		D_out : out std_logic_vector(31 downto 0);
		Seven_Seg : out std_logic_vector(15 downto 0)
	);
end data_memory;

architecture data_flow of data_memory is
    type mips_mem is array((2**10) downto 0) of std_logic_vector(31 downto 0);
	signal mips_mem_ins : mips_mem := (others => (others => '0'));
begin
	process (clk) is begin
		if(rising_edge(clk)) then
			if (W_EN = '1') then
				mips_mem_ins(to_integer(unsigned(ADDR))) <= D_IN;
			end if;
		end if;
	end process;

	process (clk) is begin
		if (rising_edge(clk)) then
			if(ADDR = 10x"3FF")then
				if (W_EN = '1') then
					Seven_Seg <= D_IN(15 downto 0);
				end if;
			end if;
		end if;
	end process;

	process (clk) is begin
		if (rising_edge(clk)) then
			if(ADDR = 10x"3FE")then
				D_out <= x"0000" & Switches;
			else
				D_out <= mips_mem_ins(to_integer(unsigned(ADDR)));
			end if;
		end if;
	end process;

end data_flow;


